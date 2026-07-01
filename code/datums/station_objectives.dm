/datum/station_objective_manager
	/// Is there an active production directive?
	var/active = FALSE
	/// When the directive expires (world.time).
	var/deadline = 0
	/// Cached duration in deciseconds for messaging.
	var/time_limit = 0
	/// Tasks that need to be shipped via the cargo shuttle.
	var/list/tasks = list()
	/// Pool of possible tasks to pick from each round.
	var/list/task_pool = list(
		list("name" = "УГОЛЬ", "item_type" = /obj/item/ore/coal, "min" = 10, "max" = 30),
		list("name" = "УРАН", "item_type" = /obj/item/stack/material/uranium, "min" = 15, "max" = 30),
		list("name" = "СЕРЕБРО", "item_type" = /obj/item/stack/material/silver, "min" = 15, "max" = 30),
		list("name" = "ЗОЛОТО", "item_type" = /obj/item/stack/material/gold, "min" = 15, "max" = 30),
		//list("name" = "СТАЛЬ", "item_type" = /obj/item/stack/material/steel, "min" = 15, "max" = 100),
		//list("name" = "СТЕКЛО", "item_type" = /obj/item/stack/material/glass, "min" = 15, "max" = 100),
		//list("name" = "БАНАН", "item_type" = /obj/item/reagent_containers/food/grown/banana, "min" = 8, "max" = 24),
		//list("name" = "КАРТОШКА", "item_type" = /obj/item/reagent_containers/food/grown/potato, "min" = 10, "max" = 32),
		list("name" = "ПЛАЗМА", "item_type" = /obj/item/stack/material/plasma, "min" = 10, "max" = 25)
	)
	/// If we're currently executing a punishment.
	var/sanction_running = FALSE
	/// When the shock punishment stops (world.time).
	var/shock_end_time = 0
	var/succ_obj = 0

/datum/station_objective_manager/proc/start_directive(list/task_definitions, time_limit_seconds, datum/event/source_event)
	if(!task_definitions || !task_definitions.len)
		return FALSE

	if(succ_obj == 3)
		if(evacuation_controller.is_evacuating())
			return
		init_autotransfer()
		return FALSE

	reset_directive()

	time_limit_seconds = max(time_limit_seconds, 1 MINUTES)

	for(var/list/definition in task_definitions)
		var/datum/station_objective_task/task = new
		task.name = definition["name"]
		task.item_type = definition["item_type"]
		task.required_amount = definition["required_amount"]
		task.include_subtypes = definition["include_subtypes"] || TRUE
		if(task.is_valid())
			tasks += task

	if(!tasks.len)
		return FALSE

	active = TRUE
	time_limit = time_limit_seconds
	deadline = world.time + time_limit_seconds

	announce_start()
	schedule_deadline_check()
	return TRUE

/datum/station_objective_manager/proc/generate_tasks()
	var/list/selected = list()
	var/list/pool = task_pool.Copy()
	var/target = min(3, pool.len)

	while(selected.len < target && pool.len)
		var/list/choice = pick(pool)
		pool -= choice

		// Check if we already have a task with this name and item_type
		var/duplicate = FALSE
		for(var/list/existing in selected)
			if(existing["name"] == choice["name"] && existing["item_type"] == choice["item_type"])
				duplicate = TRUE
				break

		if(!duplicate)
			selected += list(list(
				"name" = choice["name"],
				"item_type" = choice["item_type"],
				"required_amount" = rand(choice["min"], choice["max"]),
				"include_subtypes" = TRUE
			))

	return selected

/datum/station_objective_manager/proc/reset_directive()
	active = FALSE
	sanction_running = FALSE
	shock_end_time = 0
	deadline = 0
	time_limit = 0
	QDEL_LIST(tasks)

/datum/station_objective_manager/proc/schedule_deadline_check()
	if(!active)
		return

	spawn(5 SECONDS)
		check_deadline()

/datum/station_objective_manager/proc/check_deadline()
	if(!active)
		return

	if(world.time >= deadline)
		fail_directive("Лимит времени достигнут.")
	else
		schedule_deadline_check()

/datum/station_objective_manager/proc/record_shipment(atom/movable/AM)
	if(!active || !tasks.len)
		return

	var/obj/structure/closet/crate/C = AM.loc
	if(!istype(C))
		return

	//Проверяем наличие бумаги с печатью квартирмейстера в этом ящике
	var/has_valid_stamp = FALSE
	for(var/obj/item/paper/directive/P in C.contents)
	// 	if(P.stamped && length(P.stamped))
	// 		to_chat(world, "YES1")
	// 		if(is_type_in_list(/obj/item/stamp/qm, P.stamped))
	// 			has_valid_stamp = TRUE
	// 			to_chat(world, "YES2")
	// 			break
		for(var/stamp_type in P.stamped)
			if(stamp_type == /obj/item/stamp/qm)
				has_valid_stamp = TRUE
				break
		if(has_valid_stamp)
			break

	if(!has_valid_stamp)
		return //нет печати – игнорируем

	var/count = 1
	if(istype(AM, /obj/item/stack))
		var/obj/item/stack/S = AM
		count = max(1, S.get_amount())

	var/progress_changed = FALSE
	for(var/datum/station_objective_task/task in tasks)
		if(task.matches(AM))
			task.current_amount += count
			progress_changed = TRUE

	if(progress_changed && all_tasks_completed())
		complete_directive()
		succ_obj += 1
	if(progress_changed && half_tasks_completed())
		half_complete_directive()

// /datum/station_objective_manager/proc/record_shipment(atom/movable/AM)
// 	if(!active || !tasks.len)
// 		return

// 	var/count = 1
// 	if(istype(AM, /obj/item/stack))
// 		var/obj/item/stack/S = AM
// 		count = max(1, S.get_amount())

// 	var/progress_changed = FALSE
// 	for(var/datum/station_objective_task/task in tasks)
// 		if(task.matches(AM))
// 			task.current_amount += count
// 			progress_changed = TRUE

// 	if(progress_changed && all_tasks_completed())
// 		complete_directive()
// 		succ_obj += 1
// 	if(progress_changed && half_tasks_completed())
// 		half_complete_directive()

/datum/station_objective_manager/proc/half_tasks_completed()
	for(var/datum/station_objective_task/task in tasks)
		if(task.is_half_complete())
			return TRUE
	return FALSE
/datum/station_objective_manager/proc/all_tasks_completed()
	if(!tasks.len)
		return FALSE

	for(var/datum/station_objective_task/task in tasks)
		if(!task.is_complete())
			return FALSE

	return TRUE

/datum/station_objective_manager/proc/complete_directive()
	if(!active)
		return

	active = FALSE
	SSannounce.play_station_announce(/datum/announce/station_objectives_success, format_status_text("Все задачи выполнены вовремя."))
	SSsalary.fire()

/datum/station_objective_manager/proc/half_complete_directive()
	if(!active)
		return

	active = FALSE
	SSannounce.play_station_announce(/datum/announce/station_objectives_success, format_status_text("ЗАДАЧИ ВЫПОЛНЕНЫ НЕПОЛНОСТЬЮ. Был назначен штраф для всех членов персонала станции \"Чужбина\" в размере их зарплаты."))
	fine_everyone()
	if(GLOB.station_objectives && !GLOB.station_objectives.active)
		var/list/tasks = GLOB.station_objectives.generate_tasks()
		var/time_limit = 30 * 1 MINUTES
		spawn(3000)
		GLOB.station_objectives.start_directive(tasks, time_limit, null)

/datum/station_objective_manager/proc/fail_directive(reason)
	if(!active)
		return

	active = FALSE
	var/text = format_status_text("СТАТУС ДИРЕКТИВЫ: ПРОВАЛ. [reason || "Недостаточно поставок."]")
	SSannounce.play_station_announce(/datum/announce/station_objectives_failure, text)
	apply_sanction()

/datum/station_objective_manager/proc/format_status_text(message)
	var/list/lines = list(message, "Задачи:")
	for(var/datum/station_objective_task/task in tasks)
		lines += "- [task.current_amount]/[task.required_amount] [task.name]"
	return lines.Join("\n")

/datum/station_objective_manager/proc/announce_start()
	var/time_left_minutes = round(time_limit / (1 MINUTE))
	var/list/lines = list("Новая производственная директива.",
		"Лимит времени: [time_left_minutes] мин.",
		"Отправьте все переработанные ресурсы через челнок снабжения. В случае частичного провала директивы - члены персонала компенсируют потенциальный доход денежным штрафом. В случае полного провала директивы - будет выслана корпгвардия для выяснения причины и принятия соответствующих мер.")

	for(var/datum/station_objective_task/task in tasks)
		lines += "- [task.required_amount]x [task.name]"

	SSannounce.play_station_announce(/datum/announce/station_objectives, lines.Join("\n"))

/datum/station_objective_manager/proc/apply_sanction()
	if(sanction_running)
		return

	sanction_running = TRUE
/*
	if(prob(15))
		start_shock_pulses()
	else
		dispatch_deathsquad()
*/
	for(var/mob/observer/ghost/O in GLOB.player_list)
		if(O.client)
			to_chat(O, SPAN_DEADSAY(FONT_LARGE("Введена санкция за провал директивы.")))
			to_chat(O, SPAN_DEADSAY("Чтобы присоединиться к отряду корпгвардии выберите БЫТЬ ЗЛОДЕЕМ в ООС."))

	SSticker.looking_for_antags = 1
	spawn(3 MINUTES)
		dispatch_deathsquad()
		SSticker.looking_for_antags = 0
	return TRUE

/datum/station_objective_manager/proc/start_shock_pulses()
	shock_end_time = world.time + (1 MINUTES)
	SSannounce.play_station_announce(/datum/announce/station_objectives_sanction, "Ультрашоковая терапия!")
	do_shock_pulse()

/datum/station_objective_manager/proc/do_shock_pulse()
	if(world.time >= shock_end_time)
		sanction_running = FALSE
		return

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == DEAD)
			continue
		if(!electrocute_mob(H, get_area(H), src, 0.5))
			H.electrocute_act(rand(75, 125), src, 0.5, ran_zone(BP_CHEST, 50))

	spawn(59 SECONDS)
		do_shock_pulse()

/datum/station_objective_manager/proc/dispatch_deathsquad()
	SSannounce.play_station_announce(/datum/announce/station_objectives_sanction, "Для выяснения причины и личностей виновных в провале директивы - на станцию \"Чужбина\" отправился отряд корпгвардии. Просьба не оказывать сопротивления и содействовать в расследованиии.")
	var/i = 4 // Количество оперативников отряда зачистки
	if(GLOB.deathsquad)
		for(var/mob/observer/ghost/G in GLOB.player_list)
			if(i)
				if(G.mind in SSticker.antag_pool)
					if(((G.client.inactivity/10)/300) <= 1) // The most active players are more likely to become a deathsquad operative
						if(!(G.mind && G.mind.current && !G.mind.current.is_ooc_dead()))
							GLOB.deathsquad.create_default(G)
							i--
		if(i == initial(i))
			sleep(5 MINUTE)
			apply_sanction()
		else
			GLOB.deathsquad.update_leader()
			sanction_running = FALSE

/datum/station_objective_task
	var/name = "item"
	var/required_amount = 0
	var/current_amount = 0
	var/item_type
	var/include_subtypes = TRUE

/datum/station_objective_task/proc/is_valid()
	return item_type && required_amount > 0

/datum/station_objective_task/proc/matches(atom/movable/AM)
	if(!item_type)
		return FALSE
	if(include_subtypes)
		return istype(AM, item_type)
	return AM.type == item_type

/datum/station_objective_task/proc/is_complete()
	return current_amount >= required_amount

/datum/station_objective_task/proc/is_half_complete()
	return (current_amount < required_amount) && (current_amount > 0)

/datum/station_objective_manager/proc/fine_everyone()
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(!H.mind)
			continue

		// Проверка/создание банковского счёта
		if(!H.account_number)
			var/obj/item/card/id/id_card = H.get_id_card()
			if(id_card && id_card.associated_account_number)
				H.account_number = id_card.associated_account_number
			else
				var/datum/money_account/acc = create_account(H.real_name, 0, null, FALSE)
				if(acc)
					H.account_number = acc.account_number
					log_debug("Created new account [H.account_number] for [H.real_name]")
		if(!H.account_number)
			continue

		var/salary = get_base_salary(H.mind.assigned_role)
		if(salary <= 0)
			continue

		// Пытаемся списать штраф
		var/success = charge_to_account(H.account_number, H.real_name, "ЗАДАЧИ ВЫПОЛНЕНЫ НЕПОЛНОСТЬЮ.", "CentComm", (-salary))
		if(!success)
			log_debug("Failed to charge [H.real_name] ([H.account_number]) for penalty of [salary] credits.")

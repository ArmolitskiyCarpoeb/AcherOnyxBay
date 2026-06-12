#define MAX_SANITY 100
#define MIN_SANITY 0

GLOBAL_LIST_INIT(resilient_jobs, list("Security Operative", "Warden", "Head of Security", "Detective", "Mercenary"))

/mob/living/carbon/human
	var/sanity_broken_warning = FALSE
	var/list/happiness_events = list()
	var/sanity_lost_control = FALSE
	var/last_sanity_update_time = 0

/mob/living/carbon/human/proc/update_sanity_from_events()
	if(!client) return
	var/total_happiness = 0
	for(var/datum/happiness_event/E in happiness_events)
		total_happiness += E.happiness
	var/delta = round(total_happiness / 10)
	if(delta == 0)
		return
	sanity = clamp(sanity + delta, MIN_SANITY, MAX_SANITY)
	update_sanity_effects()

/mob/living/carbon/human/proc/add_happiness_event(event_type, duration = 0)
	var/datum/happiness_event/event = new event_type()
	if(!event_type)
		return
	if(event.group)
		for(var/datum/happiness_event/E in happiness_events)
			if(E.group == event.group)
				happiness_events -= E
				sanity = clamp(sanity - E.happiness, MIN_SANITY, MAX_SANITY)
				qdel(E)
	if(!event)
		return
	for(var/datum/happiness_event/E in happiness_events)
		if(E.type == event_type)
			qdel(event)
			return
	happiness_events += event
	sanity = clamp(sanity + event.happiness, MIN_SANITY, MAX_SANITY)  // мгновенное изменение
	var/timeout = duration > 0 ? duration : event.timeout
	if(timeout > 0)
		spawn(timeout)
			if(src)
				remove_happiness_event(event_type)

/mob/living/carbon/human/proc/remove_happiness_event(event_type)
	for(var/datum/happiness_event/E in happiness_events)
		if(E.type == event_type)
			happiness_events -= E
			sanity = clamp(sanity - E.happiness, MIN_SANITY, MAX_SANITY)
			qdel(E)
			break

/mob/living/carbon/human/proc/update_sanity_effects()
	var/message = ""
	if(sanity < 45)
		if(prob(5))
			adjustBruteLoss(3)
			adjustToxLoss(2)
			message = pick("Тебя никто не любит!", "Как всё печально-то...", "К чёрту всё!", "Работа - ОТСТОЙ!")
			to_chat(src, "<span class='warning'>[message]</span>")
			sound_to(src, sound(pick('sound/effects/badmood2.ogg', 'sound/effects/badmood3.ogg', 'sound/effects/badmood4.ogg')))

	if(sanity < 20)
		if(prob(25) && !is_hallucinating())
			hallucination(rand(10, 25) SECONDS, rand(20, 50))
			message = pick("Убожество, просто умри.", "Разум требует высвобождения из клетки бытия.", "Ты чувствуешь это? Оно хочет выйти из тебя!", "Ещё немного потерпеть и...", "Что будет, если выйти в космос без скафандра?", "Нужно сделать отверствие в своей голове - оттуда будет литься вкусный сок.", "Твой разум хочет обратно в небытие!", "ЭТО КОНЕЦ. ЭТО КОНЕЦ. ЭТО КОНЕЦ!", "Раскрась станцию красным!")
			to_chat(src, "<span class='danger'>[message]</span>")
			sound_to(src, sound(pick('sound/effects/badmood2.ogg', 'sound/effects/badmood3.ogg', 'sound/effects/badmood4.ogg')))

	if(sanity <= 0)
		if(!sanity_broken_warning)
			sanity_broken_warning = TRUE
			to_chat(src, "<span class='danger'>Твой разум гниёт!</span>")
			src.hallucination(rand(120, 360) SECONDS, 100)
			overlay_fullscreen("schizo", /atom/movable/screen/fullscreen/schizo)
			sound_to(src, sound('sound/effects/badmood1.ogg'))
			if(!src.sanity_lost_control)
				//src.sanity_lost_control = TRUE
				// Делаем тело доступным для вселения
				src.controllable = TRUE
				src.possession_candidate = TRUE
				src.can_be_possessed_by()
				GLOB.available_mobs_for_possess["\ref[src]"] = src
				// Игрок становится призраком
				//src.ghostize(CORPSE_CAN_REENTER)
				to_chat(src, "<span class='danger'>Ты чувствуешь свой скорый конец.</span>")
	else
		if(sanity_broken_warning)
			sanity_broken_warning = FALSE
			// Восстановление контроля, если тело не занято
			if(sanity_lost_control && !src.client)
				sanity_lost_control = FALSE
				ckey = src.mind?.key
				to_chat(src, "<span class='danger'>Ты снова контролируешь своё тело.</span>")
			// Убираем тело из списка доступных для вселения
			GLOB.available_mobs_for_possess -= "\ref[src]"
			controllable = FALSE
			possession_candidate = FALSE
			clear_fullscreen("schizo")



// Отрисовка в статпанели
/mob/living/carbon/human/Stat()
	. = ..()
	if(client)
		stat("", "")
		stat("Рассудок", "[sanity]/[MAX_SANITY]")

/mob/living/carbon/human/proc/update_pain_event()
	if(!client) return

	// Получаем уровень боли: используем halloss (через getHalLoss) или сумму урона
	var/pain_level = getHalLoss()  // 0-100+
	var/event_type = null

	if(pain_level >= 70)
		event_type = /datum/happiness_event/pain
	else if(pain_level >= 50)
		event_type = /datum/happiness_event/mildpain
	else if(pain_level >= 30)
		event_type = /datum/happiness_event/verymildpain
	else
		// Удаляем любое событие боли, если оно есть
		for(var/datum/happiness_event/E in happiness_events)
			if(istype(E, /datum/happiness_event/pain) || istype(E, /datum/happiness_event/mildpain) || istype(E, /datum/happiness_event/verymildpain))
				remove_happiness_event(E.type)
		return

	// Если уже активное событие такого же типа – ничего не делаем
	for(var/datum/happiness_event/E in happiness_events)
		if(E.type == event_type)
			return

	// Удаляем все старые события боли и добавляем новое
	for(var/datum/happiness_event/E in happiness_events)
		if(istype(E, /datum/happiness_event/pain) || istype(E, /datum/happiness_event/mildpain) || istype(E, /datum/happiness_event/verymildpain))
			remove_happiness_event(E.type)
	add_happiness_event(event_type)

/mob/living/carbon/human/proc/update_hunger_event()
	if(!client) return
	var/event_type = null
	switch(nutrition)
		if(0 to 100)       event_type = /datum/happiness_event/nutrition/starving
		if(101 to 200)     event_type = /datum/happiness_event/nutrition/veryhungry
		if(201 to 350)     event_type = /datum/happiness_event/nutrition/hungry
		if(351 to 500)     event_type = /datum/happiness_event/nutrition/lilhungry
		if(501 to 700)     event_type = null   // норма
		if(701 to 900)     event_type = /datum/happiness_event/nutrition/fed
		if(901 to INFINITY) event_type = /datum/happiness_event/nutrition/wellfed
/*	// Удаляем все события группы nutrition
	for(var/datum/happiness_event/E in happiness_events)
		if(E.group == "nutrition")
			remove_happiness_event(E.type)*/
	if(event_type)
		add_happiness_event(event_type)

/mob/living/carbon/human/proc/update_thirst_event()
	if(!client) return
	var/event_type = null
	switch(hydration)
		if(0 to 100)       event_type = /datum/happiness_event/thirst/dehydrated
		if(101 to 250)     event_type = /datum/happiness_event/thirst/verythirsty
		if(251 to 400)     event_type = /datum/happiness_event/thirst/thirsty
		if(401 to 550)     event_type = /datum/happiness_event/thirst/thirsting
		if(551 to 700)     event_type = null
		if(701 to 800)     event_type = /datum/happiness_event/thirst/watered
		if(801 to INFINITY) event_type = /datum/happiness_event/thirst/filled
	/*for(var/datum/happiness_event/E in happiness_events)
		if(E.group == "thirst")
			remove_happiness_event(E.type)*/
	if(event_type)
		add_happiness_event(event_type)

/mob/living/carbon/human/proc/update_dirty_event()
	if(!client) return
	var/count = 0
	for(var/atom/A in view(world.view, src))
		if(istype(A, /obj/item/trash))
			count++
		else if(istype(A, /obj/effect/decal/cleanable/blood))
			count++
		else if(istype(A, /obj/item/cigbutt))
			count++
		else if(istype(A, /obj/effect/decal/cleanable/generic))
			count++

	var/event_type = null
	if(count >= 13)
		event_type = /datum/happiness_event/dirty/dirty_heavy
	else if(count >= 7)
		event_type = /datum/happiness_event/dirty/dirty_medium
	else if(count >= 4)
		event_type = /datum/happiness_event/dirty/dirty_slight
	else
		event_type = null

	if(event_type)
		add_happiness_event(event_type)
	else
		for(var/datum/happiness_event/E in happiness_events)
			if(E.group == "disgust")
				remove_happiness_event(E.type)

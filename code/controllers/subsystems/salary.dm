SUBSYSTEM_DEF(salary)
	name = "Salary"
	priority = SS_PRIORITY_TRADE
	flags = SS_NO_FIRE

/datum/controller/subsystem/salary/fire(resumed = 0)
	distribute_salaries()

/proc/distribute_salaries()
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(!H.mind || !H.client || H.stat == DEAD)
			continue

		var/base_salary = get_base_salary(H.mind.assigned_role)
		if(base_salary == 0)
			continue

		// Проверка/создание банковского счёта
		if(!H.account_number)
			var/obj/item/card/id/id_card = H.get_id_card()
			if(id_card && id_card.associated_account_number)
				H.account_number = id_card.associated_account_number
			else
				var/datum/money_account/acc = create_account(H.real_name, 0, null, FALSE)
				H.account_number = acc.account_number
				log_debug("Created new account [H.account_number] for [H.real_name]")

		var/datum/money_account/acc = get_account(H.account_number)
		if(!acc)
			log_debug("No account found for [H.real_name]")
			continue

		if(base_salary > 0)
			var/datum/transaction/T = new("MLC Salary Department", "Salary payout", base_salary, "Station Salary System")
			acc.do_transaction(T)
			send_pda_message(H, base_salary, FALSE)
		else if(base_salary < 0)
			var/penalty = -base_salary
			if(charge_to_account(H.account_number, H.real_name, "Penalty", "Station Salary System", penalty))
				send_pda_message(H, penalty, TRUE)

/proc/get_base_salary(rank)
	if(!job_master)
		return WAGE_MINIMUM
	var/datum/job/J = job_master.GetJob(rank)
	return J ? J.wage : WAGE_MINIMUM

/proc/send_pda_message(mob/living/carbon/human/H, amount, is_penalty = FALSE)
	if(!H || !H.client) return
	var/obj/item/device/pda/PDA = locate() in H.contents
	if(!PDA) return

	var/sender = "MLC Salary Department"
	var/sender_job = "Central Command"
	var/message = is_penalty ? "С вашего счёта списано [amount] кредитов (штраф)." : "На ваш счёт поступило [amount] кредитов (заработная плата)."
	PDA.new_message(null, sender, sender_job, message)

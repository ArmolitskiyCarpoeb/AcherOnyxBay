/datum/job/assistant
	title = "Workman"
	description = "Неважно кто ты, бывший заключённый, вор, доходяга с долгами, это всё в прошлом. Ты тут что бы выполнять грязную работу. Копай руду, выращивай овощи или готовь пайки. Твоя смена кончается только в двух случаях: когда закончится вахта или когда ты умрёшь."
	department = "Civilian"
	department_flag = CIV

	account_allowed = FALSE
	total_positions = -1
	spawn_positions = -1
	supervisors = "the cardinal"
	selection_color = "#515151"
	economic_modifier = 1
	access = list(access_maint_tunnels, access_hydroponics, access_bar, access_kitchen, access_cargo, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_hydroponics, access_bar, access_kitchen, access_cargo, access_qm, access_mining, access_mining_station)
//	alt_titles = list("Technical Assistant","Medical Intern","Research Assistant")
	outfit_type = /decl/hierarchy/outfit/job/assistant
	can_be_hired = FALSE

	loadout_allowed = TRUE

/datum/job/assistant/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,15,5,15,5,15,5,15)
/*
/datum/job/assistant/get_access()
	if(config.game.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
*/

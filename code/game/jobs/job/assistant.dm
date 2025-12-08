/datum/job/assistant
	title = "Nobody"
	description = "Ты - человек без работы и денег. Тебя здесь не любят!"
	department = "Civilian"
	department_flag = CIV

	account_allowed = FALSE
	total_positions = -1
	spawn_positions = -1
	supervisors = "Богом"
	selection_color = "#1f1d1d"
	economic_modifier = 1
	access = list(access_maint_tunnels)
	minimal_access = list(access_maint_tunnels)
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

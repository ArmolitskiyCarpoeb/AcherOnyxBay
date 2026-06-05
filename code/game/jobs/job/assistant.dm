/datum/job/assistant
	title = "Assistant"
	description = "Не забывай - твоя помощь ОЧЕНЬ всем нужна, почаще задавай глупые вопросы и кричи: ''СВОБОДНЫЙ АССИСТЕНТ!''"
	department = "Civilian"
	department_flag = CIV

	account_allowed = FALSE
	total_positions = -1
	spawn_positions = -1
	supervisors = "ЭКИПАЖ и Корпорация"
	selection_color = "#5e5e5e"
	economic_modifier = 0.6
	access = list(access_maint_tunnels)
	minimal_access = list(access_maint_tunnels)
//	alt_titles = list("Technical Assistant","Medical Intern","Research Assistant")
	outfit_type = /decl/hierarchy/outfit/job/assistant
	can_be_hired = FALSE
	no_latejoin = FALSE
	loadout_allowed = TRUE

/datum/job/assistant/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(8,12,8,12,6,11,8,12)
		H.generate_skills()
		H.skills["ranged"] = rand(10, 90)
		H.skills["melee"] = rand(10, 90)
		H.skills["engineering"] = rand(10, 90)
		H.skills["crafting"] = rand(10, 90)
		H.skills["cooking"] = rand(10, 90)
		H.skills["medical"] = rand(10, 90)
		H.skills["surgery"] = rand(10, 90)
		H.skills["gardening"] = rand(10, 90)
		H.body_build_stats(H)
/*
/datum/job/assistant/get_access()
	if(config.game.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
*/

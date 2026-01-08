/datum/job/assistant
	title = "Nobody"
	description = "Ты - человек без работы, денег и будущего. Тебя здесь не очень любят! Отыгрыш: Ты буквально никто и кто угодно, придумай свою историю. Безумец давно застрявший на станции, сбежавший арестант, наркоман в поисках дозы или просто бомж нашедший тут пристанище. Удачи выжить."
	department = "Civilian"
	department_flag = CIV

	account_allowed = FALSE
	total_positions = -1
	spawn_positions = -1
	supervisors = "Богом"
	selection_color = "#1f1d1d"
	economic_modifier = 0.6
	access = list(access_maint_tunnels)
	minimal_access = list(access_maint_tunnels)
//	alt_titles = list("Technical Assistant","Medical Intern","Research Assistant")
	outfit_type = /decl/hierarchy/outfit/job/assistant
	can_be_hired = FALSE
	no_latejoin = TRUE
	loadout_allowed = TRUE

/datum/job/assistant/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,15,5,15,5,15,5,15)
		H.generate_skills()
		H.skills["ranged"] = rand(0, 100)
		H.skills["melee"] = rand(0, 100)
		H.skills["engineering"] = rand(0, 100)
		H.skills["crafting"] = rand(0, 100)
		H.skills["cooking"] = rand(0, 100)
		H.skills["medical"] = rand(0, 100)
		H.skills["surgery"] = rand(0, 100)
		H.skills["gardening"] = rand(0, 100)
		H.body_build_stats(H)
/*
/datum/job/assistant/get_access()
	if(config.game.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
*/

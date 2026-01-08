/datum/job/cmo
	title = "Chief Medical Officer"
	head_position = 1
	department = "Medical"
	department_flag = MED|COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#026865"
	req_admin_notify = 1
	economic_modifier = 10
	faction_restricted = TRUE
	access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)

	minimal_player_age = 30
	minimum_character_age = 25
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/medical/cmo

/datum/job/doctor
	title = "Medical Doctor"
	description = "Купил ли ты свой диплом или потратил несколько лет на обучение уже не важно. Твоя задача — чтобы пациент ушёл на своих ногах и с головой на плечах. Ты здесь — последняя грань между жизнью и тем, что ждёт в этих коридорах. Ошибешься и станешь следующим в морге. Отыгрыш: скорее всего ты единственный кто умеет лечить в этом месте, и вряд ли ты филантроп. Требуй деньги, проси оказать услугу взамен или просто капризничай, показывая свою важность, ведь кто если не ты им поможет?"
	department = "Medical"
	department_flag = MED

	loadout_allowed = TRUE

	minimal_player_age = 0
	total_positions = 2
	spawn_positions = 1
	supervisors = "кардиналом"
	selection_color = "#13817e"
	economic_modifier = 1.5
	access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor

/datum/job/doctor/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,13,8,14,11,20,7,15)
		H.generate_skills()
		H.skills["medical"] = rand(60, 95)
		H.skills["surgery"] = rand(50, 85)
		H.body_build_stats(H)

/datum/job/virologist
	title = "Virologist"
	department = "Medical"
	department_flag = MED

	minimal_player_age = 7
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 5
	access = list(access_medical, access_medical_equip, access_virology)
	minimal_access = list(access_medical, access_medical_equip, access_virology)
	outfit_type = /decl/hierarchy/outfit/job/medical/virologist

//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
/datum/job/chemist
	title = "Chemist"
	department = "Medical"
	department_flag = MED

	minimal_player_age = 7
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 5
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology)
	minimal_access = list(access_medical, access_medical_equip, access_chemistry)
	alt_titles = list("Pharmacist")
	outfit_type = /decl/hierarchy/outfit/job/medical/chemist

/datum/job/psychiatrist
	title = "Psychiatrist"
	department = "Medical"
	department_flag = MED

	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	minimal_player_age = 3
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	alt_titles = list("Psychologist" = /decl/hierarchy/outfit/job/medical/psychiatrist/psychologist)
	outfit_type = /decl/hierarchy/outfit/job/medical/psychiatrist

/datum/job/paramedic
	title = "Paramedic"
	department = "Medical"
	department_flag = MED

	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 4
	minimal_player_age = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva, access_maint_tunnels, access_external_airlocks, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)
	alt_titles = list("Emergency Medical Technician" = /decl/hierarchy/outfit/job/medical/paramedic/emt)
	outfit_type = /decl/hierarchy/outfit/job/medical/paramedic

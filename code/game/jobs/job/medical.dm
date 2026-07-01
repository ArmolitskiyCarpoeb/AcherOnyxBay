/datum/job/cmo
	title = "Chief Medical Officer"
	description = "Ты преуспел в деле врачевания и теперь за лечение берёшь в два раза дороже, чем раньше."
	head_position = 1
	department = "Medical"
	department_flag = MED|COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "Капитан и Корпорация"
	selection_color = "#026865"
	req_admin_notify = 1
	economic_modifier = 5
	faction_restricted = TRUE
	access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks, access_change_ids)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks, access_change_ids)

	minimal_player_age = 0
	minimum_character_age = 25
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/medical/cmo
	wage = WAGE_COMMAND

/datum/job/cmo/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/obj/item/implant/death_alarm/D = new()
		D.implant_in_mob(H, BP_HEAD)
		H.newgeneratestats(8,10,8,12,12,20,7,11)
		H.generate_skills()
		H.skills["medical"] = rand(75, 95)
		H.skills["surgery"] = rand(75, 95)
		H.body_build_stats(H)

/datum/job/doctor
	title = "Medical Doctor"
	description = "Тебе предстоит полностью оправдать все те слухи о том, что ты купил свой диплом и ни разу никого не лечил до этой смены."
	department = "Medical"
	department_flag = MED

	loadout_allowed = TRUE

	minimal_player_age = 0
	total_positions = 2
	spawn_positions = 2
	supervisors = "Капитан и Корпорация"
	selection_color = "#13817e"
	economic_modifier = 3
	access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor
	wage = WAGE_HIGH

/datum/job/doctor/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(8,11,8,12,11,17,7,12)
		H.generate_skills()
		H.skills["medical"] = rand(45, 90)
		H.skills["surgery"] = rand(45, 90)
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

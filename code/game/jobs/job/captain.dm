/datum/job/captain
	title = "Cardinal"
	description = "Церковь дала тебе власть, а корпорация эти стены. Твоя воля - закон. Наставляй на пусть истинный тех доходяг, которых отправили с тобой в эту дыру, заставь их работать, искорени ересь среди них."
	department = "Command"
	head_position = 1
	department_flag = COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "церковью и корпорацией"
	selection_color = "#4d0d0d"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 0
	minimum_character_age = 28
	economic_modifier = 2
	faction_restricted = TRUE
	sex_lock = MALE
	loadout_allowed = TRUE
	//body_build_lock = "Default"
	ideal_character_age = 42 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/captain/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/obj/item/implant/death_alarm/D = new()
		D.implant_in_mob(H, BP_HEAD)
		H.newgeneratestats(11,18,8,16,8,16,10,18)
		H.generate_skills()
		H.skills["ranged"] = rand(50, 85)
		H.skills["melee"] = rand(50, 85)
		var/obj/machinery/nuclearbomb/nuke = locate(/obj/machinery/nuclearbomb/station) in world
		if(nuke)
			H.mind.store_memory("")
			H.mind.store_memory("<B>ПРИ ЗАХВАТЕ ЕРЕТИКАМИ, ПРЕДАТЕЛЯМИ КОРПОРАЦИИ И ВРАГАМИ НАРОДА, ШАХТЁРСКИЙ АВАНПОСТ ФОРТУНА ПОДЛЕЖИТ УНИЧТОЖЕНИЮ</B>")
			H.mind.store_memory("")
			H.mind.store_memory("<B>КОД АКТИВАЦИИ ЯДЕРНОГО ЗАРЯДА: [nuke.r_code]</B>")
			H.mind.store_memory("")

/*
/datum/job/captain/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		to_chat(H, "<b>Your life is shit.</b>")
*/

/datum/job/captain/get_access()
	return get_all_station_access()

/datum/job/hop
	title = "Head of Personnel"
	department = "Civilian"
	head_position = 1
	department_flag = COM|CIV|SRV

	total_positions = 0
	spawn_positions = 0
	supervisors = "the captain"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 30
	minimum_character_age = 25
	economic_modifier = 10
	ideal_character_age = 50
	faction_restricted = TRUE

	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_iaa,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_lawyer)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_iaa,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_lawyer)

	outfit_type = /decl/hierarchy/outfit/job/hop

/datum/job/captain
	title = "Cardinal"
	department = "Command"
	head_position = 1
	department_flag = COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "the church and the corporation"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 0
	minimum_character_age = 28
	economic_modifier = 25
	faction_restricted = TRUE

	loadout_allowed = TRUE

	ideal_character_age = 42 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/captain/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(12,20,5,15,5,15,12,20)
		var/obj/machinery/nuclearbomb/nuke = locate(/obj/machinery/nuclearbomb/station) in world
		if(nuke)
			H.mind.store_memory("<B>ПРИ ЗАХВАТЕ ЕРЕТИКАМИ, ПРЕДАТЕЛЯМИ КОРПОРАЦИИ И ВРАГАМИ НАРОДА, ШАХТЁРСКИЙ АВАНПОСТ ФОРТУНА ПОДЛЕЖИТ УНИЧТОЖЕНИЮ</B>")
			H.mind.store_memory("[nuke.r_code]")
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

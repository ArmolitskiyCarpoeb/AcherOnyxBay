/datum/job/hos
	title = "Head of Security"
	head_position = 1
	department = "Security"
	department_flag = SEC|COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#8e2929"
	req_admin_notify = 1
	economic_modifier = 10
	faction_restricted = TRUE
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks, access_lawyer)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks, access_lawyer)
	minimal_player_age = 30
	minimum_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/security/hos

/datum/job/hos/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

/datum/job/warden
	title = "Warden"
	department = "Security"
	department_flag = SEC

	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#601c1c"
	economic_modifier = 5
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/security/warden

/datum/job/detective
	title = "Detective"
	department = "Security"
	department_flag = SEC

	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#601c1c"
	alt_titles = list("Forensic Technician" = /decl/hierarchy/outfit/job/security/detective/forensic)
	economic_modifier = 5
	access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels)
	minimal_access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/security/detective

/datum/job/officer
	title = "Security Operative"
	description = "Ты — инструмент, а не герой. Приказ слепо выполнен — вот и вся твоя доблесть. Хорошо подумай прежде чем рискнуть жизнь ради кого-то: твоя жизнь — расходник, а на твоё место уже стоит в очереди следующий."
	department = "Security"
	department_flag = SEC

	total_positions = 1
	spawn_positions = 1
	supervisors = "кардиналом"
	selection_color = "#552828"
	//alt_titles = list("Junior Officer")
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_hydroponics, access_bar, access_kitchen, access_cargo, access_qm, access_mining, access_mining_station, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 0
	outfit_type = /decl/hierarchy/outfit/job/security/officer
	sex_lock = MALE
	//body_build_lock = "Default"

/datum/job/officer/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/obj/item/implant/death_alarm/D = new()
		D.implant_in_mob(H, BP_HEAD)
		H.newgeneratestats(11,17,9,15,5,15,11,17)

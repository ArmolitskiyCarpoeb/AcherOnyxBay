
/datum/map/fortuna
	name = "Fortuna"
	full_name = "MS Fortuna"
	path = "fortuna"
	jobs_needed = list("Cardinal" = "Кардинала", "Quartermaster" = "Завхоза")

	shuttle_types = list(
		/datum/shuttle/autodock/ferry/emergency/centcom/polar,
		/datum/shuttle/autodock/ferry/supply/drone/polar,
		/datum/shuttle/autodock/ferry/train
	)
	load_legacy_saves = TRUE

	map_levels = list(
		new /datum/space_level/fortuna_1,
		new /datum/space_level/fortuna_2,
		new /datum/space_level/fortuna_3,
		new /datum/space_level/fortuna_4
	)

	allowed_jobs = list(/datum/job/assistant,
			/datum/job/captain,
			/datum/job/officer,
			/datum/job/qm,
			/datum/job/doctor,
			/datum/job/engineer,
			/datum/job/mining,
			/datum/job/bartender,
			/datum/job/chef,
			/datum/job/hydro
		)

	station_name  = "MS Fortuna"
	station_short = "Fortuna"
	dock_name     = "Orbital Station ''Outerland''"
	boss_name     = "Mons-Laden Corporation"
	boss_short    = "MLC"
	company_name  = "The Great Novotheist Church"
	company_short = "The Church"
	system_name   = "Zeta-8"

	base_floor_type = /turf/simulated/floor/asteroid/air
	evac_controller_type = /datum/evacuation_controller/shuttle

	station_networks = list(
		NETWORK_CIVILIAN_EAST,
		NETWORK_CIVILIAN_WEST,
		NETWORK_COMMAND,
		NETWORK_ENGINE,
		NETWORK_ENGINEERING,
		NETWORK_ENGINEERING_OUTPOST,
		NETWORK_EXODUS,
		NETWORK_MAINTENANCE,
		NETWORK_MEDICAL,
		NETWORK_MINE,
		NETWORK_RESEARCH,
		NETWORK_RESEARCH_OUTPOST,
		NETWORK_ROBOTS,
		NETWORK_PRISON,
		NETWORK_SECURITY,
		NETWORK_ALARM_ATMOS,
		NETWORK_ALARM_CAMERA,
		NETWORK_ALARM_FIRE,
		NETWORK_ALARM_MOTION,
		NETWORK_ALARM_POWER,
		NETWORK_THUNDER,
		NETWORK_TELECOM,
		NETWORK_MASTER
	)

	post_round_safe_areas = list (
	)

	background_choices = list(
		"The Great Novotheist Church",
		"Mons-Laden Corporation"
		)

	home_system_choices = list(
		"Acheron",
		"Artemis"
		)

	religion_choices = list(
		"Novotheism"
		)

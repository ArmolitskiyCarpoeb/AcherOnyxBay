/datum/event/station_production_objectives
	id = "station_production_objectives"
	name = "Central Command Production Directive (Manual)"
	description = "Admin/trigger-only repeat of the station production directive."

	mtth = 0
	triggered_only = TRUE
	fire_only_once = FALSE
	difficulty = 25

/datum/event/station_production_objectives/check_conditions()
	if(!GLOB.station_objectives)
		return FALSE
	if(GLOB.station_objectives.active)
		return FALSE
	return TRUE

/datum/event/station_production_objectives/on_fire()
	if(!GLOB.station_objectives)
		return

	var/list/tasks = GLOB.station_objectives.generate_tasks()
	var/time_limit = 60 * 1 MINUTES

	if(!GLOB.station_objectives.start_directive(tasks, time_limit, src))
		log_and_message_admins("Station production objectives could not start; manager refused to start.")

	return

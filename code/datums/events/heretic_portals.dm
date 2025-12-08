/datum/event/heretic_portals
	id = "heretic_portals"
	name = "Heretic Portals"
	description = "Monsters will appear somewhere"

	mtth = 1 HOURS
	difficulty = 50
	fire_only_once = FALSE

/datum/event/heretic_portals/get_mtth()
	. = ..()
	. -= (SSevents.triggers.living_players_count * (15 MINUTES))
	. = max(1 HOUR, .)

/datum/event/heretic_portals/on_fire()
	var/location = pick(GLOB.monster_areas)
	var/list/heretic_monster_turf = get_area_turfs(location, list(/proc/is_station_turf, /proc/not_turf_contains_dense_objects))
	var/spawn_count = 1
	var/players_count = length(GLOB.player_list)
	if(players_count >= 7)
		spawn_count = 3
	else if(players_count < 5)
		spawn_count = 1

	if(!location)
		log_debug("heretic_portals event failed to find a proper spawn point. Aborting.")
		return

	spawn()
		log_and_message_admins("heretic_portals spawned in \the [location]")
		while(length(heretic_monster_turf) && spawn_count > 0)
			var/turf/simulated/floor/T = pick(heretic_monster_turf)
			heretic_monster_turf.Remove(T)
			spawn_count--

			new	/obj/effect/portal/wormhole2(T)
			if(prob(50))
				new /mob/living/simple_animal/hostile/creature(T)
			if(prob(50))
				new /mob/living/simple_animal/hostile/giant_spider/nurse/scrawny(T)

	SSannounce.play_station_announce(/datum/announce/heretic_monsters)

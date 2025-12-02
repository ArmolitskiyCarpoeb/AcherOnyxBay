/obj/machinery/merchant_pad
	name = "Teleportation Pad"
	desc = "Place things here to trade."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "merchant_pad"
	anchored = TRUE
	density = FALSE
	idle_power_usage = 25 WATTS
	active_power_usage = 100 KILO WATTS

/obj/machinery/merchant_pad/proc/get_target()
	var/turf/T = get_turf(src)
	for(var/a in T)
		if(a == src || (!istype(a,/obj) && !istype(a,/mob/living)) || istype(a,/obj/effect))
			use_power_oneoff(5000)
			continue
		return a

/obj/machinery/merchant_pad/proc/get_targets()
	. = list()
	var/turf/T = get_turf(src)
	for(var/a in T)
		if(a == src || (!istype(a,/obj) && !istype(a,/mob/living)) || istype(a,/obj/effect))
			use_power_oneoff(5000)
			continue
		. += a

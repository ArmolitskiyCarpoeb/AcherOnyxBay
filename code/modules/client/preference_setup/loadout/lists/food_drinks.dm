/datum/gear/drinks
	sort_category = "Drinks"

/datum/gear/flask
	sort_category = "Drinks"
	display_name = "flask"
	path = /obj/item/reagent_containers/vessel/flask

/datum/gear/flask/New()
	..()
	gear_tweaks += new /datum/gear_tweak/reagents(lunchables_ethanol_reagents())

/datum/gear/flask/bar
	display_name = "bar flask"
	path = /obj/item/reagent_containers/vessel/flask/barflask

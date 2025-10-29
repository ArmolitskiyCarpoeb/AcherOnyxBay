/datum/gear/wrist_accessory
	sort_category = "Wrist Accessories"

/datum/gear/wrist_accessory/watch
	display_name = "watch selection"
	path = /obj/item/underwear/wrist/watch

/datum/gear/wrist_accessory/watch/New()
	..()
	var/watchtypes = list()
	watchtypes["Silver watch"] = /obj/item/underwear/wrist/watch/silver
	watchtypes["Golden watch"] = /obj/item/underwear/wrist/watch/gold
	watchtypes["Leather watch"] = /obj/item/underwear/wrist/watch/leather
	watchtypes["Spy watch"] = /obj/item/underwear/wrist/watch/spy
	gear_tweaks += new /datum/gear_tweak/path(watchtypes)

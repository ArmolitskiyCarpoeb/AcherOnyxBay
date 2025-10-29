
/datum/gear/clothing
	sort_category = "Clothing Pieces"
	slot = slot_tie

/datum/gear/clothing/hawaii
	display_name = "hawaii shirt"
	path = /obj/item/clothing/accessory/toggleable/hawaii

/datum/gear/clothing/hawaii/New()
	..()
	var/list/shirts = list()
	shirts["blue hawaii shirt"] = /obj/item/clothing/accessory/toggleable/hawaii
	shirts["red hawaii shirt"] = /obj/item/clothing/accessory/toggleable/hawaii/red
	shirts["random colored hawaii shirt"] = /obj/item/clothing/accessory/toggleable/hawaii/random
	gear_tweaks += new /datum/gear_tweak/path(shirts)

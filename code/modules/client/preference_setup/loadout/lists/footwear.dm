
/datum/gear/shoes
	sort_category = "Shoes"
	slot = slot_shoes

/datum/gear/shoes/color
	display_name = "shoes selection"
	path = /obj/item/clothing/shoes

/datum/gear/shoes/color/New()
	..()
	var/shoes = list()
	shoes += /obj/item/clothing/shoes/black
	shoes += /obj/item/clothing/shoes/brown
	shoes += /obj/item/clothing/shoes/laceup
	shoes += /obj/item/clothing/shoes/leather
	gear_tweaks += new /datum/gear_tweak/path/specified_types_list(shoes)

/datum/gear/shoes/workboots
	display_name = "workboots"
	path = /obj/item/clothing/shoes/cheapboots/work
	cost = 2

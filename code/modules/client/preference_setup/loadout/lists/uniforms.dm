/datum/gear/uniform
	sort_category = "Uniforms"
	slot = slot_w_uniform

/datum/gear/uniform/suit
	display_name = "clothes selection"
	path = /obj/item/clothing/under
	subgroup = "Formal & Work"

/datum/gear/uniform/suit/New()
	..()
	var/suits = list()
	suits += /obj/item/clothing/under/sl_suit
	suits += /obj/item/clothing/under/lawyer/blue
	gear_tweaks += new /datum/gear_tweak/path/specified_types_list(suits)

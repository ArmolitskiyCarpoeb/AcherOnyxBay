/datum/gear/head
	sort_category = "Hats"
	slot = slot_head

/datum/gear/head/bandana
	display_name = "bandana selection"
	path = /obj/item/clothing

/datum/gear/head/bandana/New()
	..()
	gear_tweaks += new /datum/gear_tweak/path/specified_types_list(typesof(/obj/item/clothing/mask/bandana) + typesof(/obj/item/clothing/head/bandana))
/*
/datum/gear/head/hardhat
	display_name = "hardhat selection"
	path = /obj/item/clothing/head/hardhat
	cost = 2
	allowed_roles = TECHNICAL_ROLES

/datum/gear/head/hardhat/New()
	..()
	var/hardhats = list()
	hardhats["blue hardhat"] = /obj/item/clothing/head/hardhat/dblue
	hardhats["orange hardhat"] = /obj/item/clothing/head/hardhat/orange
	hardhats["red hardhat"] = /obj/item/clothing/head/hardhat/red
	hardhats["yellow hardhat"] = /obj/item/clothing/head/hardhat
	gear_tweaks += new /datum/gear_tweak/path(hardhats)
*/

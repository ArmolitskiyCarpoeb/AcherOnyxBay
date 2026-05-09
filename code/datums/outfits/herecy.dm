/decl/hierarchy/outfit/terro/equip(mob/living/carbon/human/H, rank, assignment, equip_adjustments)
    . = ..(H, rank, assignment, equip_adjustments)
    if(H.skills)
        H.skills["ranged"] += rand(15,65)
        H.skills["melee"] += rand(15,65)
/*
/decl/hierarchy/outfit/terro/terro_1
	name = "A terro PILL"
	uniform = /obj/item/clothing/under/color/orange
	suit = null
	back = null
	belt = null
	gloves = null
	shoes = /obj/item/clothing/shoes/jackboots
	head = null
	mask = /obj/item/clothing/mask/balaclava
	l_ear = /obj/item/device/radio/headset/syndicate
	r_ear = null
	glasses = null
	id = null
	l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	r_pocket = /obj/item/storage/pill_bottle/terro
	suit_store = null
	r_hand = /obj/item/material/hatchet/tacknife
	l_hand = /obj/item/grenade/chem_grenade/incendiary
	backpack_contents = list() // In the list(path=count,otherpath=count) format
	// uniform = /obj/item/clothing/under/color/orange
	// shoes = /obj/item/clothing/shoes/jackboots
	// head = /obj/item/clothing/head/culthood
	// l_ear = /obj/item/device/radio/headset
	// suit = /obj/item/clothing/suit/cultrobes
	// l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	// r_pocket = /obj/item/storage/pill_bottle/herecy
	// l_hand = /obj/item/material/hatchet/tacknife
	// r_hand = /obj/item/material/twohanded/fireaxe/cult
*/
/decl/hierarchy/outfit/terro/terro_2
	name = "A terro FUEL"
	uniform = /obj/item/clothing/under/color/orange
	suit = null
	back = null
	belt = null
	gloves = null
	shoes = /obj/item/clothing/shoes/jackboots
	head = null
	mask = /obj/item/clothing/mask/balaclava
	l_ear = /obj/item/device/radio/headset/syndicate
	r_ear = null
	glasses = null
	id = null
	l_pocket = /obj/item/material/hatchet/tacknife
	r_pocket = /obj/item/reagent_containers/vessel/bottle/vodka/fuel
	suit_store = null
	r_hand = /obj/item/reagent_containers/rag
	l_hand = /obj/item/flame/lighter/zippo/black
	backpack_contents = list()
	// uniform = /obj/item/clothing/under/color/orange
	// shoes = /obj/item/clothing/shoes/jackboots
	// head = /obj/item/clothing/head/culthood
	// l_ear = /obj/item/device/radio/headset
	// back = /obj/item/material/twohanded/fireaxe
	// suit = /obj/item/clothing/suit/cultrobes
	// l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	// r_pocket = /obj/item/reagent_containers/rag
	// l_hand = /obj/item/flame/lighter/zippo/black
	// r_hand = /obj/item/reagent_containers/vessel/bottle/vodka/fuel

/decl/hierarchy/outfit/terro/terro_3
	name = "A terro RIFLE"
	uniform = /obj/item/clothing/under/color/orange
	suit = null
	back = /obj/item/gun/projectile/automatic/as75
	belt = null
	gloves = null
	shoes = /obj/item/clothing/shoes/jackboots
	head = null
	mask = /obj/item/clothing/mask/balaclava
	l_ear = /obj/item/device/radio/headset/syndicate
	r_ear = null
	glasses = null
	id = null
	l_pocket = /obj/item/material/hatchet/tacknife
	r_pocket = /obj/item/ammo_magazine/c556
	suit_store = null
	r_hand = /obj/item/grenade/chem_grenade/incendiary
	// l_hand = null
	backpack_contents = list()
	// uniform = /obj/item/clothing/under/color/orange
	// shoes = /obj/item/clothing/shoes/jackboots
	// mask = /obj/item/clothing/mask/balaclava
	// l_ear = /obj/item/device/radio/headset
	// back = /obj/item/gun/projectile/automatic/as75
	// suit = /obj/item/clothing/suit/cultrobes
	// l_pocket = /obj/item/ammo_magazine/c556

/obj/item/storage/pill_bottle/terro
	name = "pill_bottle"
	desc = "Contains pills used to stabilize the severely injured."
	label_color = "#610303"
	starting_label = "secret"
	startswith = list(
					/obj/item/reagent_containers/pill/bicaridine = 2,
					/obj/item/reagent_containers/pill/dermaline = 2,
					/obj/item/reagent_containers/pill/dexalin_plus = 2,
					/obj/item/reagent_containers/pill/oxycodone = 5,
					/obj/item/reagent_containers/pill/alkysine = 1
					)

/obj/item/reagent_containers/vessel/bottle/vodka/fuel
	name = "Бутылка с бензином"
	desc = "Время сделать погорячее"
	startswith = list(/datum/reagent/fuel)

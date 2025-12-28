/decl/hierarchy/outfit/herecy/heretic_1
	name = "Heretic PILL"
	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/culthood
	l_ear = /obj/item/device/radio/headset
	suit = /obj/item/clothing/suit/cultrobes
	l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	r_pocket = /obj/item/storage/pill_bottle/herecy
	l_hand = /obj/item/material/hatchet/tacknife
	r_hand = /obj/item/material/twohanded/fireaxe/cult

/decl/hierarchy/outfit/herecy/heretic_2
	name = "Heretic FUEL"
	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/culthood
	l_ear = /obj/item/device/radio/headset
	back = /obj/item/material/twohanded/fireaxe
	suit = /obj/item/clothing/suit/cultrobes
	l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	r_pocket = /obj/item/reagent_containers/rag
	l_hand = /obj/item/flame/lighter/zippo/black
	r_hand = /obj/item/reagent_containers/vessel/bottle/vodka/fuel

/decl/hierarchy/outfit/herecy/heretic_3
	name = "Heretic RIFLE"
	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/balaclava
	l_ear = /obj/item/device/radio/headset
	back = /obj/item/gun/projectile/automatic/as75
	suit = /obj/item/clothing/suit/cultrobes
	l_pocket = /obj/item/ammo_magazine/c556

/obj/item/storage/pill_bottle/herecy
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

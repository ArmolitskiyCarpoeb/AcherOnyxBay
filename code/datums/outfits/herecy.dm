/decl/hierarchy/outfit/herecy/heretic_1
	name = "Heretic PILL"
	//uniform = /obj/item/clothing/under/overalls
	shoes = /obj/item/clothing/shoes/jackboots
	//gloves = /obj/item/clothing/gloves/latex
	mask = /obj/item/clothing/mask/redwscarf
	head = /obj/item/clothing/head/culthood
	l_ear = /obj/item/device/radio/headset
	//glasses = /obj/item/clothing/glasses/hud/plain/thermal/monocle
	suit = /obj/item/clothing/suit/cultrobes
	l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	r_pocket = /obj/item/storage/pill_bottle/herecy
	l_hand = /obj/item/material/hatchet/tacknife
	r_hand = /obj/item/material/twohanded/fireaxe/cult

/decl/hierarchy/outfit/herecy/heretic_2
	name = "Heretic FUEL"
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/redwscarf
	head = /obj/item/clothing/head/culthood
	l_ear = /obj/item/device/radio/headset
	back = /obj/item/material/twohanded/fireaxe/cult
	suit = /obj/item/clothing/suit/cultrobes/alt
	l_pocket = /obj/item/stack/medical/advanced/bruise_pack
	//r_pocket = /obj/item/storage/pill_bottle/herecy
	l_hand = /obj/item/flame/lighter/zippo/black
	r_hand = /obj/item/reagent_containers/vessel/bottle/vodka/fuel

/obj/item/storage/pill_bottle/herecy
	name = "pill_bottle" // Keeping these for mapping or merchants
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

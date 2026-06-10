/decl/hierarchy/outfit/job/cargo
	l_ear = /obj/item/device/radio/headset/headset_cargo
	hierarchy_type = /decl/hierarchy/outfit/job/cargo

/decl/hierarchy/outfit/job/cargo/qm
	name = OUTFIT_JOB_NAME("Cargo")
	head = /obj/item/clothing/head/soft/hop
	uniform = /obj/item/clothing/under/rank/qm
	l_ear = /obj/item/device/radio/headset/heads/hop
	shoes = /obj/item/clothing/shoes/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	id_type = /obj/item/card/id/provisioning/head
	pda_type = /obj/item/device/pda/heads/hop
	backpack_contents = list(/obj/item/clipboard = 1)

/decl/hierarchy/outfit/job/cargo/cargo_tech
	name = OUTFIT_JOB_NAME("Cargo technician")
	uniform = /obj/item/clothing/under/rank/cargotech
	id_type = /obj/item/card/id/provisioning/cargo
	pda_type = /obj/item/device/pda/cargo

/decl/hierarchy/outfit/job/cargo/mining
	name = OUTFIT_JOB_NAME("Shaft miner")
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/miner
	id_type = /obj/item/card/id/provisioning/cargo/mining
	pda_type = /obj/item/device/pda/shaftminer
	pda_slot = slot_l_store
	backpack_contents = list(/obj/item/crowbar = 1)
	belt = /obj/item/storage/ore
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/cargo/mining/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/cargo/mining/void
	name = OUTFIT_JOB_NAME("Shaft miner - Voidsuit")
	head = /obj/item/clothing/head/helmet/space/void/mining
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/void/mining

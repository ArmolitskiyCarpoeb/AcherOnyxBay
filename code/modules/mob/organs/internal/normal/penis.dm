//cara eu sem querer castrei o code
/obj/item/organ/internal/penis
	name = "penis"
	gender = PLURAL
	icon_state = "lungs"
	w_class = ITEM_SIZE_NORMAL
	organ_tag = BP_PENIS
	parent_organ = BP_CHEST
	min_bruised_damage = 35
	min_broken_damage = 65
	max_damage = 100
	relative_size = 60
	//removed_type = /obj/item/weapon/reagent_containers/food/snacks/organ/internal/penis

/obj/item/weapon/reagent_containers/food/snacks/organ/internal/penis
    name = "penis"
    icon_state = "penis"
    gender = PLURAL
    var/potenzia = 10

/obj/item/weapon/reagent_containers/food/snacks/organ/internal/penis/New()
	desc = "It's [potenzia] cm long."
	..()

/obj/item/weapon/reagent_containers/food/snacks/organ/internal/penis/proc/set_potenzia(var/P_size)
	potenzia = P_size
	desc = "It's [potenzia] cm long."

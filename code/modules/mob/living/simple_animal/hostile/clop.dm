/mob/living/simple_animal/hostile/clop
	name = "клоп"
	desc = "Клоп-переросток. Какая мерзость!"
	icon = 'icons/mob/clop.dmi'
	speak_emote = list("clicks")
	icon_state = "clop"
	icon_living = "clop"
	item_state = "clop"
	icon_gib = "gib"
	icon_dead = "dead"
	health = 5
	maxHealth = 5
	melee_damage_lower = 2
	melee_damage_upper = 7
	attacktext = "stinged"
	attack_sound = 'sound/weapons/bite.ogg'
	see_in_dark = 5
	speed = 3
	possession_candidate = 1
	bodyparts = /decl/simple_animal_bodyparts/clop
	var/datum/disease2/disease/virus = null
	universal_speak = 0
	universal_understand = 1
	controllable = TRUE
	meat_type = /obj/item/reagent_containers/food/meat/clop
	meat_amount = 1
	mob_size = MOB_SMALL

/decl/simple_animal_bodyparts/clop
	hit_zones = list("segmented body", "sting", "eye", "segmented legs")

/mob/living/simple_animal/hostile/clop/harvest(mob/user)
	var/actual_meat_amount = max(1,(meat_amount/2))
	if(meat_type && actual_meat_amount>0 && (is_ooc_dead()))
		for(var/i=0;i<actual_meat_amount;i++)
			var/obj/item/meat = new meat_type(get_turf(src))
			meat.SetName("[meat.name]")
			user.visible_message("<span class='danger'>[user] chops up \the [src]!</span>")
			new /obj/effect/decal/cleanable/blood/clop(get_turf(src))
			qdel(src)

/mob/living/simple_animal/hostile/clop/Initialize()
	. = ..()

	verbs += /mob/living/proc/hide

	if(name == initial(name))
		name = "[name] ([sequential_id(/mob/living/simple_animal/hostile/clop)])"
	real_name = name

	if(prob(25))
		if(prob(1))
			virus = new (VIRUS_EXOTIC)
		else if(prob(5))
			virus = new (VIRUS_ENGINEERED)
		else if(prob(15))
			virus = new (VIRUS_COMMON)
		else
			virus = new (VIRUS_MILD)

/mob/living/simple_animal/hostile/clop/Destroy()
	virus = null
	return ..()

/mob/living/simple_animal/hostile/clop/AttackingTarget()
	setClickCooldown(attack_delay)
	if(!Adjacent(target_mob))
		return
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		UnarmedAttack(L)
		return L
	if(istype(target_mob,/obj/mecha))
		var/obj/mecha/M = target_mob
		M.attack_generic(src, rand(melee_damage_lower, melee_damage_upper), attacktext)
		return M

/mob/living/simple_animal/hostile/clop/UnarmedAttack(atom/A, proximity)
	if(ishuman(A))
		var/mob/living/carbon/human/H = A

		if(hiding)
			to_chat(src, SPAN_WARNING("You can't sting while you are hiding!"))
			return

		var/available_limbs = H.lying ? BP_ALL_LIMBS : BP_FEET
		var/obj/item/organ/external/limb
		for(var/L in shuffle(available_limbs))
			limb = H.get_organ(L)
			if(limb)
				break

		var/blocked = H.get_flat_armor(limb.organ_tag, "melee")
		/*
		for(var/obj/item/clothing/clothes in list(H.head, H.wear_mask, H.wear_suit, H.w_uniform, H.gloves, H.shoes))
			if(istype(clothes) && (clothes.body_parts_covered & limb.body_part) && ((clothes.item_flags & ITEM_FLAG_THICKMATERIAL) || (blocked >= 30)))
				visible_message(SPAN_NOTICE("[src] stings [H]'s [clothes] harmlessly."),
								SPAN_WARNING("You failed to sting through [H]'s [clothes]."))
				do_attack_animation(H)
				return
		*/
		if(H.apply_damage(rand(1, 5), BRUTE, limb.organ_tag, blocked) && !BP_IS_ROBOTIC(limb) && prob(70 - blocked))
			limb.germ_level += rand(75, 150)
			if(virus)
				infect_virus2(H, virus)
		visible_message(SPAN_DANGER("[src] stings [H]'s [organ_name_by_zone(H, limb.organ_tag)]!"),
						SPAN_WARNING("You sting [H]'s [organ_name_by_zone(H, limb.organ_tag)]!"))
		admin_attack_log(src, H, "Sting the victim", "Was stinged", "sting")
		H.apply_damage(15, PAIN, limb.organ_tag)
		setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		do_attack_animation(H)
		playsound(loc, attack_sound, 25, 1, 1)
		return
	return ..()

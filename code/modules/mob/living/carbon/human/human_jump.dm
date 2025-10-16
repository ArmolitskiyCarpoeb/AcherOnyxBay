#define NO_HURT_JUMP_PROB 15
#define LITE_HURT_PROB 60
#define KNOCK_DOWN_PROB 40
#define HURT_LEGS_PROB 1

#define LONG_JUMP_PROB 25
#define MAX_JUMP_LENGTH 3
#define DEFAULT_JUMP_LENGTH 2

#define SALTO_PROB 10


/mob/living/carbon/human/throw_impact(atom/hit_atom, speed, target_zone)
	. = ..()
	var/jump_in_spaceman = FALSE

	if (hit_atom.density)
		if (ishuman(hit_atom))
			jump_in_spaceman = TRUE
			var/mob/living/carbon/human/jump_target_human = hit_atom

			playsound(src, SFX_FIGHTING_PUNCH, 25, 0, 1)
			do_attack_animation(jump_target_human)

			if (prob(KNOCK_DOWN_PROB))
				jump_target_human.apply_damage(10, BRUTE)
				jump_target_human.Weaken(2)
				visible_message(SPAN_NOTICE("[src] was knokout [hit_atom.name] in jump!."))

			else
				jump_target_human.apply_damage(5, BRUTE)
				jump_target_human.Stun(1)

		if (prob(NO_HURT_JUMP_PROB) && jump_in_spaceman == FALSE)
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It's lucky you weren't hurt."))
			return

		if (prob(LITE_HURT_PROB))
			Stun(3)
			adjustBruteLoss(10)
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It must have hurt."))

		else
			Weaken(5)
			adjustBruteLoss(20)
			to_chat(src, SPAN_WARNING("Jumping into the [hit_atom.name] knocked the wind out of you"))

/mob/living/carbon/human/proc/toggle_jump()
	if (!src || src.stat)
		return

	if (jump_icon?.icon_state == "act_jump0")
		jump_icon?.icon_state = "act_jump1"
		src.active_ability = HUMAN_POWER_JUMP
	else
		jump_icon?.icon_state = "act_jump0"
		src.active_ability = HUMAN_POWER_NONE

/mob/living/carbon/human/proc/process_jump(atom/A)
	if (QDELETED(A) || QDELETED(src) || A.z != z)
		return

	if (A == src || A == loc || lying || pulledby || LAZYLEN(grabbed_by))
		to_chat(src, SPAN_WARNING("You can't jump right now"))
		toggle_jump(HUMAN_POWER_JUMP)
		return

	if (buckled)
		to_chat(src, SPAN_WARNING("You need to unbuckle first"))
		toggle_jump(HUMAN_POWER_JUMP)
		return

	if (poise < (poise_pool / 2))
		to_chat(src, SPAN_WARNING("Not enough balance!"))
		toggle_jump(HUMAN_POWER_JUMP)
		return

	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	face_atom(A)
	var/jump_distance = MAX_JUMP_LENGTH
	var/jump_turf = src.loc

	for (var/i = 0, i < jump_distance, i++)
		jump_turf = get_step(jump_turf, dir)

	if (!jump_turf || jump_turf == loc)
		return

	playsound(src, src.gender == MALE ? SFX_MALE_JUMP : SFX_FEMALE_JUMP, 25, 0, 1)
	visible_message(SPAN_NOTICE("[src] jumps to [A]."))
	damage_poise(body_build.poise_pool / 2)
	throw_spin = FALSE

	if (prob(SALTO_PROB))
		throw_spin = TRUE
		visible_message(SPAN_NOTICE("[src] did a somersault!."))
	else
		throw_spin = FALSE

	var/orig_flags = src.pass_flags
	src.pass_flags |= PASS_FLAG_TABLE

	src.pixel_y = 5

	if (prob(LONG_JUMP_PROB))
		throw_at(jump_turf, MAX_JUMP_LENGTH, 1.25, src)
		Stun(1)
	else
		throw_at(jump_turf, DEFAULT_JUMP_LENGTH, 1.25, src)
		Stun(1)

	if (QDELETED(src))
		return

	if (prob(HURT_LEGS_PROB))
		var/legs_to_hurt = pick(BP_L_FOOT, BP_R_FOOT)
		src.apply_damage(45, PAIN, legs_to_hurt, 0)
		src.apply_damage(10, BRUTE, legs_to_hurt, 0)
		visible_message(SPAN_NOTICE("[src] jumped unsuccessfully and hurt foot!"))

	spawn(2)
		src.pass_flags = orig_flags
		src.pixel_y = 0
	throw_spin = TRUE
	toggle_jump(HUMAN_POWER_JUMP)

#undef NO_HURT_JUMP_PROB
#undef LITE_HURT_PROB
#undef KNOCK_DOWN_PROB
#undef HURT_LEGS_PROB
#undef LONG_JUMP_PROB
#undef MAX_JUMP_LENGTH
#undef DEFAULT_JUMP_LENGTH
#undef SALTO_PROB

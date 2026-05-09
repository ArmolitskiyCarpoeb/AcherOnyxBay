#define FACE_SPEED_MOFIFIER 1.25

/**
 * Generic face surgry step, does nothing.
 */
/datum/surgery_step/face
	priority = 2

/datum/surgery_step/face/check_zone(mob/living/carbon/human/target, target_zone)
	return (..() && target_zone == BP_MOUTH)

/datum/surgery_step/face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	. = ..()
	if(!.)
		return

	if(BP_IS_ROBOTIC(parent_organ))
		return FALSE

	return !parent_organ.is_stump()

/**
 * Facial tissue cutting step.
 */
/datum/surgery_step/face/cut_face
	duration = CUT_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/scalpel = 100,
		/obj/item/material/knife = 75,
		/obj/item/material/shard = 50
		)

	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	failure_sound = 'sound/weapons/bladeslice.ogg'

/datum/surgery_step/face/cut_face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return target.surgery_status.face == 0

/datum/surgery_step/face/cut_face/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts to cut open [target]'s face and neck with \the [tool].",
		"You start to cut open [target]'s face and neck with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/cut_face/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] has cut open [target]'s face and neck with \the [tool].",
		"You have cut open [target]'s face and neck with \the [tool]."
		)
	target.surgery_status.face = 1

/datum/surgery_step/face/cut_face/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, slicing [target]'s throat wth \the [tool]!",
		"Your hand slips, slicing [target]'s throat wth \the [tool]!"
		)
	parent_organ.take_cut_damage(40, tool)
	target.losebreath += 10

//Отрезание языка кусачками
/datum/surgery_step/face/cut_off_tongue

	duration = 300
	blood_level = BLOODY_HANDS
	shock_level = 60

	allowed_tools = list(
		/obj/item/wirecutters = 100,
		)

	preop_sound = 'sound/items/Wirecutter.ogg'
	success_sound = 'sound/items/Wirecutter.ogg'
	failure_sound = 'sound/weapons/bladeslice.ogg'

/datum/surgery_step/face/cut_off_tongue/check_zone(mob/living/carbon/human/target, target_zone)
	return (..() && target_zone in list(BP_MOUTH, BP_HEAD))

/datum/surgery_step/face/cut_off_tongue/pick_target_organ(atom/user, mob/living/carbon/human/target, target_zone)
	return target.internal_organs_by_name[BP_TONGUE]

/datum/surgery_step/face/cut_off_tongue/check_target_organ(obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	if(!target.should_have_organ(BP_TONGUE))
		return FALSE

	return istype(target_organ, /obj/item/organ/internal/tongue)

/datum/surgery_step/face/cut_off_tongue/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] медленно сжимает зубцы, подводя их к корню языка [target].",
		"Ты подводишь холодные зубцы к корню языка [target]."
		)
	target.custom_pain(
		"Сталь впивается в мясо языка [target], кровь заполняет горло.",
		60,
		affecting = parent_organ
		)
	return ..()

/datum/surgery_step/face/cut_off_tongue/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] разводит лезвия кусачек, фиксируя язык [target] для отсечения. Одно движение и ты остался без языка!.",
		"Вы слышите скрип стали, фиксируя язык перед отсечением. ЧИК И ГОТОВО, [target] больше не поговорит!"
		)

	parent_organ.take_external_damage(
		10,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)

	// Второй удар по голове, имитирующий финальный срез.
	parent_organ.take_external_damage(
		10,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)

	var/obj/item/organ/internal/tongue/T = target_organ
	T.removed(user)

/datum/surgery_step/face/cut_off_tongue/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"Рука [user] срывается, мясо рвётся, зубы скрипят под металлом.",
		"Ваша рука срывается, мясо рвётся, зубы скрипят под металлом."
		)

	parent_organ.take_external_damage(
		25,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)
/**
 * Vaocal mending step.
 */
/datum/surgery_step/face/mend_vocal
	duration = CLAMP_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/device/assembly/mousetrap = 10
		)

	preop_sound = 'sound/surgery/hemostat1.ogg'
	success_sound = 'sound/surgery/hemostat.ogg'
	failure_sound = 'sound/surgery/hatchet.ogg'

/datum/surgery_step/face/mend_vocal/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face == 1)

/datum/surgery_step/face/mend_vocal/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts mending [target]'s vocal cords with \the [tool].",
		"You start mending [target]'s vocal cords with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/mend_vocal/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] mends [target]'s vocal cords with \the [tool].",
		"You mend [target]'s vocal cords with \the [tool]."
		)
	target.surgery_status.face = 2

/datum/surgery_step/face/mend_vocal/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, clamping [target]'s trachea shut for a moment with \the [tool]!",
		"Your hand slips, clamping [user]'s trachea shut for a moment with \the [tool]!"
		)
	target.losebreath += 10

/**
 * Facial reconstruction step.
 */
/datum/surgery_step/face/fix_face
	duration = RETRACT_DURATION * 1.25

	allowed_tools = list(
		/obj/item/retractor = 100,
		/obj/item/crowbar = 55,
		/obj/item/material/kitchen/utensil/fork = 75
		)

	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor.ogg'
	failure_sound = 'sound/weapons/bladeslice.ogg'

/datum/surgery_step/face/fix_face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face == 2)

/datum/surgery_step/face/fix_face/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts pulling the skin on [target]'s face back in place with \the [tool].",
		"You start pulling the skin on [target]'s face back in place with \the [tool].")
	return ..()

/datum/surgery_step/face/fix_face/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] pulls the skin on [target]'s face back in place with \the [tool].",
		"You pull the skin on [target]'s face back in place with \the [tool]."
		)
	target.surgery_status.face = 3

/datum/surgery_step/face/fix_face/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, tearing skin on [target]'s face with \the [tool]!",
		"Your hand slips, tearing skin on [target]'s face with \the [tool]!"
		)
	parent_organ.take_cut_damage(10, tool)

/**
 * Facial cauterization step.
 */
/datum/surgery_step/face/cauterize
	duration = CAUTERIZE_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/cautery = 100,
		/obj/item/clothing/mask/smokable/cigarette = 75,
		/obj/item/flame/lighter = 50,
		/obj/item/weldingtool = 25,
		/obj/item/hothands = 20
		)

	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'
	failure_sound = 'sound/surgery/cautery.ogg'

/datum/surgery_step/face/cauterize/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face > 0)

/datum/surgery_step/face/cauterize/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] is beginning to cauterize the incision on [target]'s face and neck with \the [tool].",
		"You are beginning to cauterize the incision on [target]'s face and neck with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/cauterize/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] cauterizes the incision on [target]'s face and neck with \the [tool].",
		"You cauterize the incision on [target]'s face and neck with \the [tool]."
		)
	if(target.surgery_status.face == 3)
		var/obj/item/organ/external/head/H = parent_organ
		H.status &= ~ORGAN_DISFIGURED
		H.deformities = 0
	target.surgery_status.face = 0
	target.update_deformities()

/datum/surgery_step/face/cauterize/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, leaving a small burn on [target]'s face with \the [tool]!",
		"Your hand slips, leaving a small burn on [target]'s face with \the [tool]!"
		)
	parent_organ.take_burn_damage(4, tool)

#undef FACE_SPEED_MOFIFIER

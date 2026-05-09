/obj/item/proc/do_surgery(mob/living/carbon/human/target, mob/user)
	if(!hasorgans(target))
		return FALSE

	if(user.a_intent == I_HURT)
		return FALSE

	if(!target.can_operate(user))
		return FALSE

	var/required_skill = 50
	var/required_iq = 12

	// Lowered thresholds for tongue removal with wirecutters (grim improvisation)
	if(istype(src, /obj/item/wirecutters))
		var/sel_zone = user.zone_sel?.selecting
		if(sel_zone in list(BP_MOUTH, BP_HEAD))
			required_skill = 25
			required_iq = 7

	if(!user.skillcheck(user.skills["surgery"], required_skill, null, "surgery") || !user.newstatcheck(user.stats[STAT_IQ], required_iq, null, STAT_IQ))
		return FALSE

	for(var/datum/surgery_step/S in GLOB.surgery_steps)
		var/status = S.do_step(user, target, src, user.zone_sel.selecting, user.rightclicked)
		if(status == SURGERY_FAILURE)
			return FALSE
		if(status)
			return TRUE
	return FALSE

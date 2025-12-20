/obj/item/proc/do_surgery(mob/living/carbon/human/target, mob/user)
	if(!hasorgans(target))
		return FALSE

	if(user.a_intent == I_HURT)
		return FALSE

	if(!target.can_operate(user))
		return FALSE

	for(var/datum/surgery_step/S in GLOB.surgery_steps)
		var/status = S.do_step(user, target, src, user.zone_sel.selecting)
		if(status == SURGERY_FAILURE)
			return FALSE
		if(status)
			return TRUE
		if(user.skillcheck(user.skills["surgery"], 50, null, "surgery") || user.statcheck(user.stats[STAT_IQ], 12, null, STAT_IQ))
			//user.learn_skills("surgery")
			return TRUE
	return FALSE

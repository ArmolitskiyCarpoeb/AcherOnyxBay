// Gives various spooky messages to people afraid of a specific thing.
// Doesn't have any real mechanical effect, and is more of an aid to remind someone "You're supposed to be afraid of the dark", and such.

/datum/modifier/trait/phobia
	var/current_fear = 0                // Counter for how 'afraid' the holder is.
	var/max_fear = 100                  // Cap for current_fear.
	var/fear_decay_rate = 1             // How much is subtracted every Life() tick when not being spooked by something.
	var/should_not_fear = 0

	var/list/zero_fear_up = list()      // Message displayed to holder when current_fear raises above 0.
	var/list/zero_fear_down = list()    // Message displayed when reaching 0.

	var/list/half_fear_up = list()      // Message displayed when current_fear passes half of max_fear.
	var/list/half_fear_down = list()    // Message displayed when current_fear goes below half of max_fear.

	var/list/full_fear_up = list()      // Similar to above, but for the cap.
	var/list/full_fear_down = list()    // Ditto.

/datum/modifier/trait/phobia/tick()
	if(holder.stat)
		return // You got bigger problems.

	var/new_fear = should_fear()
	if(new_fear)
		if(should_not_fear > 0)
			should_not_fear--
			return
		adjust_fear(new_fear)
	else
		adjust_fear(-fear_decay_rate)

/datum/modifier/trait/phobia/proc/adjust_fear(amount)
	var/last_fear = current_fear
	current_fear = between(0, current_fear + amount, max_fear)

	// Handle messages.  safepick() is used so that if no messages are defined, it just does nothing, verses runtiming.
	var/message = null
	if(amount > 0) // Increase in spooks.
	// H.internal_organs_by_name[BP_HEART]
		if(current_fear == max_fear && last_fear < max_fear)
			message = safepick(full_fear_up)
			holder.emote("scream", intentional = FALSE)
			holder.emote("faint", intentional = FALSE)
			current_fear = max_fear / 2
			should_not_fear = 10
		else if(current_fear >= (max_fear / 2) && last_fear < (max_fear / 2))
			message = safepick(half_fear_up)
		else if(current_fear > 0 && last_fear == 0)
			message = safepick(zero_fear_up)
	else if(amount < 0) // Decrease in spooks.
		if(last_fear == max_fear && current_fear < max_fear)
			message = safepick(full_fear_down)
		else if(last_fear >= (max_fear / 2) && current_fear < (max_fear / 2))
			message = safepick(half_fear_down)
		else if(last_fear > 0 && current_fear == 0)
			message = safepick(zero_fear_down)

	if(message)
		to_chat(holder, message)

// Override for specific fears, e.g. seeing blood or spiders.
/datum/modifier/trait/phobia/proc/should_fear()
	return FALSE


// Actual phobia trait implementations below.

/datum/modifier/trait/phobia/haemophobia
	name = "Гемофобия"
	desc = "Вид крови не очень приятен большинству людей, но для тебя вгоняет в панику."
	fear_decay_rate = 4

	on_created_text = "<span class='warning'>Ты боишься увидеть кровь.</span>"
	on_expired_text = "<span class='notice'>Ты чувствуешь, что кровь, по крайней мере, не беспокоит тебя так сильно, как раньше.</span>"

	zero_fear_up = list(
		"<span class='warning'><font size='3'>Ты обращаешь внимание на кровь...</font></span>",
		"<span class='warning'><font size='3'>Ты стараешься не смотреть на кровь.</font></span>"
		)
	zero_fear_down = list(
		"<span class='notice'>Ты ощущаешь себя лучше, без крови вокруг.</span>",
		"<span class='notice'>Наконец, крови нет.</span>",
		"<span class='notice'>Есть еще надежда, что ты больше не увидишь кровь за сегодня.</span>"
		)

	half_fear_up = list(
		"<span class='danger'><font size='3'>Кровь всё ещё поблизости!</font></span>",
		"<span class='danger'><font size='3'>Столько крови... Ты не можешь устоять.</font></span>"
		)
	half_fear_down = list(
		"<span class='warning'>Крови больше нет, но напряжение осталось.</span>",
		"<span class='warning'>Тебе тревожно, хоть крови и нет поблизости.</span>"
		)

	full_fear_up = list(
		"<span class='danger'><font size='4'>Слишком много крови!</font></span>",
		"<span class='danger'><font size='4'>Тут слишком много крови, это омерзительно!</font></span>",
		"<span class='danger'><font size='4'>Ты не можешь устоять перед видом всей этой крови!</font></span>"
		)
	full_fear_down = list(
		"<span class='danger'>Крови нет, но тревога не отступает.</span>",
		"<span class='danger'>Пожалуйста... Пусть больше крови не будет.</span>"
		)

/datum/modifier/trait/phobia/haemophobia/check_if_valid()
	if(iscultist(holder)) // Nar-nar can't be having cultists afraid of blood.
		expire()
	else
		..()

/datum/modifier/trait/phobia/haemophobia/should_fear()
	if(holder.blinded)
		return 0 // Can't fear what cannot be seen.

	var/fear_amount = 0
	for(var/atom/thing in view(5, holder)) // It's 5 and not 7 so players have a chance to go away before getting the prompts, and for performance.
		// Blood stains are bad.
		if(istype(thing, /obj/effect/decal/cleanable/blood))
			var/obj/effect/decal/cleanable/blood/B = thing
			// Tracks are special, apparently.
			if(istype(thing, /obj/effect/decal/cleanable/blood/tracks))
				var/obj/effect/decal/cleanable/blood/tracks/T = B
				for(var/datum/fluidtrack/F in T.stack)
					if(F.basecolor != SYNTH_BLOOD_COLOUR)
						fear_amount++
						break
			else
				if(B.basecolor != SYNTH_BLOOD_COLOUR)
					fear_amount++

		// People covered in blood is also bad.
		// Feel free to trim down if its too expensive CPU wise.
		if(istype(thing, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = thing
			var/self_multiplier = H == holder ? 2 : 1
			var/human_blood_fear_amount = 0
			if(!H.gloves && H.bloody_hands && H.hand_blood_color != SYNTH_BLOOD_COLOUR)
				human_blood_fear_amount += 1
			if(!H.shoes && H.feet_blood_color && H.feet_blood_color != SYNTH_BLOOD_COLOUR)
				human_blood_fear_amount += 1

			// List of slots.  Some slots like pockets are omitted due to not being visible, if H isn't the holder.
			var/list/clothing_slots = list(H.back, H.wear_mask, H.l_hand, H.r_hand, H.wear_id, H.glasses, H.gloves, H.head, H.shoes, H.belt, H.wear_suit, H.w_uniform, H.s_store, H.l_ear, H.r_ear)
			if(H == holder)
				clothing_slots += list(H.l_store, H.r_store)

			for(var/obj/item/clothing/C in clothing_slots)
				if(C.is_bloodied && C.blood_color && C.blood_color != SYNTH_BLOOD_COLOUR)
					human_blood_fear_amount += 1

			// This is divided, since humans can wear so many items at once.
			human_blood_fear_amount = round( (human_blood_fear_amount * self_multiplier) / 3, 1)
			fear_amount += human_blood_fear_amount

		// Bloody objects are also bad.
		if(istype(thing, /obj))
			var/obj/O = thing
			if(O.is_bloodied && O.blood_color && O.blood_color != SYNTH_BLOOD_COLOUR)
				fear_amount++

	return fear_amount


/datum/modifier/trait/phobia/nyctophobe
	name = "Никтофобия"
	desc = "Более известный как страх темноты. Тени могут скрывать множество опасностей, поэтому перспектива погружения в глубины технических туннелей довольно тревожна."
	fear_decay_rate = 5

	on_created_text = "<span class='warning'>Ты боишься темноты.</span>"
	on_expired_text = "<span class='notice'>Ты больше не боишься темноты.</span>"

	var/fear_threshold = 0.5 // Average lighting needs to be below this to start increasing fear.

	zero_fear_up = list(
		"<span class='warning'><font size='3'>Тут так темно!</font></span>",
		"<span class='warning'><font size='3'>Слишком темно!</font></span>"
		)
	zero_fear_down = list(
		"<span class='notice'>Ты ощущаешь себя спокойней, на свету.</span>",
		"<span class='notice'>По крайней мере, тут светлее.</span>",
		"<span class='notice'>Свет делает тебя спокойнее.</span>"
		)

	half_fear_up = list(
		"<span class='danger'><font size='3'>Тебе надо сбежать из этой темноты!</font></span>",
		"<span class='danger'><font size='3'>Что-то может скрываться рядом с тобой, но ты не можешь этого увидеть в этой темноте.</font></span>",
		"<span class='danger'><font size='3'>Тебе надо выйти на свет!</font></span>",
		)
	half_fear_down = list(
		"<span class='warning'>Тьма отошла</span>",
		"<span class='warning'>Ты больше не в темноте, но от одной мысли, тревожно.</span>"
		)

	full_fear_up = list(
		"<span class='danger'><font size='4'>Сзади!</font></span>",
		"<span class='danger'><font size='4'>Тебя что-то коснулось...</font></span>"
		)
	full_fear_down = list(
		"<span class='danger'>Свет, наконец!</span>",
		"<span class='danger'>Тьмы наконец нет!</span>"
		)

/datum/modifier/trait/phobia/nyctophobe/should_fear()
	if(holder.blinded)
		return 5 // Unlike most other fears coded here, being blind when afraid of darkness is pretty bad, I imagine.

	if(holder.see_in_dark >= 5)
		return 0 // What darkness?

	var/fear_amount = 0
	var/total_lum = 0
	var/total_tiles = 0
	var/average_lum = null

	for(var/turf/simulated/T in view(5, get_turf(holder))) // See haemophobia for why this is 5.  This uses get_turf() since darkness makes tiles not visible to holder.
		total_lum += T.get_lumcount()
		total_tiles++

	if(total_tiles)
		average_lum = total_lum / total_tiles

	if(average_lum > fear_threshold)
		switch(average_lum)
			if(0.0 to 0.1)
				fear_amount += 5
			if(0.1 to 0.2)
				fear_amount += 4
			if(0.2 to 0.3)
				fear_amount += 3
			if(0.3 to 0.4)
				fear_amount += 2
			if(0.4 to 0.5)
				fear_amount += 1

	var/turf/T = get_turf(holder)
	if(T.get_lumcount() <= LIGHTING_SOFT_THRESHOLD) // Standing in complete darkness.
		fear_amount += 5

	return fear_amount

/datum/modifier/trait/phobia/claustrophobe
	name = "Клаустрофобия"
	desc = "Тесное пространство и теснота создают ощущение дискомфорта. К сожалению, и то, и другое довольно распространено в космосе."
	fear_decay_rate = 2

	var/open_tiles_needed = 15 // Tends to be just right, as maint triggers this but hallways don't.

	on_created_text = "<span class='warning'>You are terrified of tight spaces.  Why did you come to space?</span>"
	on_expired_text = "<span class='notice'>Small rooms aren't so bad now.</span>"

	zero_fear_up = list(
		"<span class='warning'><font size='3'>This room is too small...</font></span>",
		"<span class='warning'><font size='3'>The walls are too close together...</font></span>"
		)
	zero_fear_down = list(
		"<span class='notice'>You feel calmer, now that you're in a larger room.</span>",
		"<span class='notice'>At last, the walls are far apart.</span>",
		"<span class='notice'>The relatively open area makes you feel calmer.</span>"
		)

	half_fear_up = list(
		"<span class='danger'><font size='3'>Your surroundings look like they are closing in.</font></span>",
		"<span class='danger'><font size='3'>Is the room getting smaller?</font></span>",
		"<span class='danger'><font size='3'>You need to get out of here!</font></span>",
		)
	half_fear_down = list(
		"<span class='warning'>Your surroundings seem to have stopped closing in.</span>",
		"<span class='warning'>You're not in a tight space anymore, but you're still anxious.</span>"
		)

	full_fear_up = list(
		"<span class='danger'><font size='4'>You need to escape!</font></span>",
		"<span class='danger'><font size='4'>There's barely any room to move around!</font></span>"
		)
	full_fear_down = list(
		"<span class='danger'>The surroundings stop shrinking.</span>",
		"<span class='danger'>The walls seem to have stopped.</span>"
		)

/datum/modifier/trait/phobia/claustrophobe/should_fear()
	if(holder.blinded)
		return 0 // No idea if this is accurate.

	if(holder.loc && !isturf(holder.loc)) // Hiding in a locker or inside an exosuit is spooky.
		return 5

	var/fear_amount = 0
	var/open_tiles = 0
	var/radius = 5 // See haemophobia for why this is 5.
	var/max_open_tiles = radius * radius // Potential maximum tiles.  In practice it will be rare for someone to be inside a 5x5 plane.
	for(var/turf/T in view(radius, holder))
		var/open = TRUE
		if(T.density)
			continue
		for(var/atom/movable/AM in T)
			if(AM.density)
				open = FALSE
				break
		if(open)
			open_tiles++

	if(open_tiles < open_tiles_needed)
		var/fear_reduction = abs( (open_tiles / max_open_tiles) - 1) // The smaller the space, the smaller this number is, and fear will build up faster.
		fear_amount = 5 * fear_reduction

	return fear_amount

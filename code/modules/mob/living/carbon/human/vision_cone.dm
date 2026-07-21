/////////////VISION CONE///////////////
// Vision cone code by Matt and Honkertron, made for Otuska.
// Allows mobs behind the player to be hidden from their field of vision.
// Ported from Intergay-dev with hide.dmi screen overlay.
///////////////////////////////////////


/atom/proc/InCone(atom/center = usr, dir = NORTH, cone_angle = 90)
	if(get_dist(center, src) == 0 || src == center)
		return FALSE

	var/dx = src.x - center.x
	var/dy = src.y - center.y

	if(dx == 0 && dy == 0)
		return FALSE

	var/vx = 0
	var/vy = 0
	if(dir & NORTH) vy = 1
	if(dir & SOUTH) vy = -1
	if(dir & EAST)  vx = 1
	if(dir & WEST)  vx = -1

	var/dot = vx * dx + vy * dy
	if(dot > 0 && (dx * vy - dy * vx) == 0)
		return TRUE

	var/v_mag = sqrt(vx * vx + vy * vy)
	var/t_mag = sqrt(dx * dx + dy * dy)

	if(v_mag == 0 || t_mag == 0)
		return FALSE

	var/cos_theta = (vx * dx + vy * dy) / (v_mag * t_mag)

	var/cos_half_cone = cos(cone_angle / 2)

	if(cos_theta >= cos_half_cone)
		return TRUE

	return FALSE

/proc/cone(atom/center = usr, dir = NORTH, cone_angle = 90, list/list = oview(center))
	for(var/atom/A in list)
		if(!A.InCone(center, dir, cone_angle))
			list -= A
	return list

/mob/dead/InCone(mob/center = usr, dir = NORTH)
	return

/mob/living/proc/update_vision_cone()
	return

/mob/living/proc/clear_cone_effect(image/I)
	if(I)
		qdel(I)

/mob/living/proc/clear_fov_footstep(client/C, image/I)
	if(C && I)
		C.images -= I
		qdel(I)

/mob/living/proc/handle_fov_footsteps()
	for(var/client/C in in_vision_cones)
		var/datum/component/fov_comp/comp = get_component(/datum/component/fov_comp)
		if(!comp)
			return
		if(src in comp.hidden_mobs)
			var/turf/T = get_turf(src)
			if(!T)
				continue
			var/image/I = image('icons/effects/footstepsound.dmi', T, "default", layer = 18)
			C.images += I
			spawn(4)
				if(src && !QDELETED(src))
					clear_fov_footstep(C, I)
		else
			in_vision_cones.Remove(C)

/*
/mob/living/carbon/human/update_vision_cone()
	var/client/C = client
	if(!C || !fov)
		return

	// Удаляем всех мобов из hidden_mobs и чистим их in_vision_cones
	for(var/mob/living/M in C.hidden_mobs)
		M.in_vision_cones -= C
	C.hidden_mobs.Cut()

	for(var/image/I in C.hidden_atoms)
		C.images -= I
		qdel(I)
		clear_cone_effect(I)
	C.hidden_atoms.Cut()

	check_fov()
	fov.dir = dir

	if(fov.alpha != 0)
		for(var/mob/living/M in cone(src, OPPOSITE_DIR(dir), view(10, src)))
			var/image/I = image("split", M)
			I.override = 1
			C.images += I
			C.hidden_atoms += I
			C.hidden_mobs += M
			if(pulling == M)
				I.override = 0
			else
				M.in_vision_cones[C] = TRUE

	// Обновляем fov (конус) в client.images
	C.images -= fov
	C.images += fov

/mob/living/carbon/human/proc/SetFov(show)
	if(!show)
		hide_cone()
	else
		show_cone()

/mob/living/carbon/human/proc/check_fov()
	if(!client || !fov)
		return

	if(resting || lying || client.eye != client.mob)
		fov.alpha = 0
		return

	if(usefov)
		show_cone()
	else
		hide_cone()

/mob/living/carbon/human/proc/show_cone()
	if(!fov)
		return
	fov.alpha = 255
	usefov = TRUE

/mob/living/carbon/human/proc/hide_cone()
	if(!fov)
		return
	fov.alpha = 0
	usefov = FALSE
*/
/*
/mob/living/carbon/human/verb/toggle_fov()
	set name = "Toggle Field of View"
	set category = "OOC"
	set desc = "Toggle the field of view overlay and mob hiding behind you."

	if(!fov)
		to_chat(src, SPAN_WARNING("Your species does not support field of view."))
		return

	SetFov(!usefov)
	to_chat(src, SPAN_NOTICE("Field of view [usefov ? "enabled" : "disabled"]."))
	update_vision_cone()
*/

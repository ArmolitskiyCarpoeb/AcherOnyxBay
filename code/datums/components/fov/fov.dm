
#define SHOW TRUE
#define HIDE FALSE
#define FOV_NORMAL 0
#define FOV_MASK 1
#define FOV_HELMET 2
#define IS_OTHER 2
GLOBAL_ALIST_INIT(fov_states, alist(FOV_NORMAL = "combat", FOV_MASK = "behind", FOV_HELMET = "helmet"))
GLOBAL_ALIST_INIT(fov_angles, alist(FOV_NORMAL = 90, FOV_MASK = 160, FOV_HELMET = 270))

#define OPPOSITE_DIR(D) turn(D, 180)

/atom/movable/screen/fov
	icon = 'icons/mob/hide.dmi'
	icon_state = "combat"
	name = " "
	screen_loc = "1,1"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = UNDER_HUD_LAYER

/datum/component/fov_comp

	var/list/hidden_atoms = list()
	var/list/hidden_mobs = list()

	var/atom/movable/screen/fov/fov

	var/usefov = TRUE
	var/fov_state = FOV_NORMAL // 0 - нормальный, 1 - маска, 2 - шлем
	var/fov_angle = 90

	var/list/fov_affecting = list("mask" = FALSE, "helmet" = FALSE)

/datum/component/fov_comp/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	/*fov = image("split", M)
	fov.layer = 18
	fov.appearance_flags = APPEARANCE_OVERRIDE_ICON*/

	register_signal(parent, SIGNAL_MOB_MOVED, PROC_REF(update_vision_cone))
	register_signal(parent, SIGNAL_DIR_SET, PROC_REF(update_vision_cone))
	register_signal(parent, COMSIG_HUMAN_LOGIN, PROC_REF(update_vision_cone))
	register_signal(parent, SIGNAL_MOB_EQUIP_ITEM, PROC_REF(handle_fov_size))
	register_signal(parent, SIGNAL_HUMAN_CHANGE_LYING, PROC_REF(update_vision_cone))
	register_signal(SSelements, SIGNAL_GLOBAL_MOVED_HUMAN, PROC_REF(on_someone_move))

	init_fov()

/datum/component/fov_comp/Destroy(force, silent)
	var/mob/living/carbon/human/H = parent
	unregister_signal(parent, SIGNAL_MOB_MOVED)
	unregister_signal(parent, SIGNAL_DIR_SET)
	unregister_signal(parent, COMSIG_HUMAN_LOGIN)
	unregister_signal(parent, SIGNAL_MOB_EQUIP_ITEM)
	unregister_signal(parent, SIGNAL_HUMAN_CHANGE_LYING)
	unregister_signal(SSelements, SIGNAL_GLOBAL_MOVED_HUMAN)
	H.client.images -= fov
	. = ..()


/datum/component/fov_comp/proc/init_fov()
	var/mob/living/carbon/human/H = parent
	fov = new()
	handle_fov_size()

/datum/component/fov_comp/proc/handle_fov_size(item, slot)
	var/mob/living/carbon/human/H = parent

	if(!slot && !item)
		update_fov_size()
		update_vision_cone()
		return

	var/equipping = IS_OTHER
	if(slot in list(slot_r_hand, slot_l_hand))
		if(H.wear_mask == null)
			equipping = FALSE
		if(H.head == null)
			equipping = FALSE

	if(slot in list(slot_wear_mask, slot_head))
		equipping = TRUE


	if(equipping != IS_OTHER)
		var/obj/item/clothing/clothing
		if(istype(item, /obj/item/clothing))
			clothing = item
		else
			return

		if(istype(item, /obj/item/clothing/mask) && clothing.has_fov)
			fov_affecting["mask"] = equipping
		if(istype(item, /obj/item/clothing/head/helmet) && clothing.has_fov)
			fov_affecting["helmet"] = equipping

		if(!fov_affecting["helmet"])
			if(!fov_affecting["mask"])
				fov_state = FOV_NORMAL
			else
				fov_state = FOV_MASK
		else
			fov_state = FOV_HELMET

		update_fov_size()
		update_vision_cone()

/datum/component/fov_comp/proc/update_fov_size()
	fov.icon_state = GLOB.fov_states[fov_state]
	fov_angle = GLOB.fov_angles[fov_state]

/datum/component/fov_comp/proc/on_someone_move(mob/living/M, oldloc, loc)
	var/mob/living/carbon/human/H = parent
	if(!M)
		return
	if((get_dist(H, M) > 10))
		return
	if(M == H)
		return
	update_vision_cone()

/datum/component/fov_comp/proc/update_vision_cone()
	var/mob/living/carbon/human/H = parent
	var/client/C = H.client
	if(!C || !fov)
		return

	clear_cone_mobs()

	clear_cone_items()

	check_fov()
	fov.dir = H.dir

	if(fov.alpha != 0 && usefov)
		for(var/mob/living/M in cone(H, OPPOSITE_DIR(H.dir), fov_angle))
			var/image/I = image("split", M)
			I.override = 1
			C.images += I
			hidden_atoms += I
			hidden_mobs += M
			if(H.pulling == M)
				I.override = 0
			else
				M.in_vision_cones[C] = TRUE

	C.images -= fov
	C.images += fov

/datum/component/fov_comp/proc/check_fov()
	var/mob/living/carbon/human/H = parent
	var/client/C = H.client

	if(!C || !fov)
		return

	if(H.resting || H.lying || C.eye != H)
		change_cone(HIDE)
		return
	change_cone(SHOW)

/datum/component/fov_comp/proc/change_cone(state) //1 = show, 0 - hide
	if(!fov) return
	if(!usefov)
		fov.alpha = 0
		return
	switch(state)
		if(SHOW)
			fov.alpha = 255
		if(HIDE)
			fov.alpha = 0

/datum/component/fov_comp/proc/clear_cone_items()
	var/mob/M = parent
	var/client/C = M.client
	if(!C) return

	for(var/image/I in hidden_atoms)
		C.images -= I
		qdel(I)
	hidden_atoms.Cut()

/datum/component/fov_comp/proc/clear_cone_mobs()
	var/mob/M = parent
	var/client/C = M.client
	for(var/mob/living/T in hidden_mobs)
		T.in_vision_cones -= C
	hidden_mobs.Cut()
#undef SHOW
#undef HIDE
#undef FOV_NORMAL
#undef FOV_MASK
#undef FOV_HELMET
#undef IS_OTHER

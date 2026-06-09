/mob/living/carbon/human/Login()
	..()
	update_hud()
	update_vision_cone()
	if(species) species.handle_login_special(src)
	toggle_twohanded_mode(FALSE, TRUE)
	return

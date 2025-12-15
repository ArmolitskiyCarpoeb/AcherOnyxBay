////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/pill
	name = "pill"
	desc = "A pill."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	randpixel = 7
	possible_transfer_amounts = null
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS
	volume = 30
	var/mimic_color = FALSE

	drop_sound = SFX_DROP_FOOD
	pickup_sound = SFX_PICKUP_FOOD

/obj/item/reagent_containers/pill/Initialize()
	. = ..()
	if(!icon_state)
		icon_state = "pill[rand(1, 5)]" //preset pills only use colour changing or unique icons

	if(mimic_color)
		color = reagents.get_color()

/obj/item/reagent_containers/pill/examine(mob/user, infix)
	. = list()

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.stats[STAT_IQ] <= 15 || H.skills[SKILL_MED] <= 50 )
			//to_chat(user, "<span class='uppertext'>That's a pill.</span>\n<span class='statustext'>Don't know what's in it.</span>")
			. += SPAN_WARNING("<span class='uppertext'>Похоже на пилюлю.</span>\n<span class='statustext'>Не знаю, что внутри!</span>")
			return .
		else
			//to_chat(user, "<span class='uppertext'>That's [name].</span>\n<span class='statustext'>[desc]</span>")
			. += SPAN_WARNING("<span class='uppertext'>Это же пилюля.</span>\n<span class='statustext'>[desc]</span>")
			return .

	. += "[src]"  // This will show the actual name
	. += desc
	return .

/obj/item/reagent_containers/pill/attack(mob/M, mob/user, def_zone)
	if(M == user)
		if(!M.can_eat(src))
			return

		to_chat(M, "<span class='notice'>You swallow \the [src].</span>")

		if(ishuman(M))
			if(!M.drop(src, M.loc))
				return
			var/mob/living/carbon/human/H = M
			if(H.ingest(src, TRUE))
				return 1

		if(reagents.total_volume)
			reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		qdel(src)
		return 1

	else if(ishuman(M))
		if(!M.can_force_feed(user, src))
			return

		user.visible_message("<span class='warning'>[user] attempts to force [M] to swallow \the [src].</span>")
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		if(!do_mob(user, M))
			return

		if(!isrobot(user) && user.get_active_hand() != src)
			return

		if(!M.can_force_feed(user, src, check_resist = TRUE))
			return

		if(!user.drop(src, M.loc))
			return

		user.visible_message("<span class='warning'>[user] forces [M] to swallow \the [src].</span>")
		var/contained = reagentlist()
		admin_attack_log(user, M, "Fed the victim with [name] (Reagents: [contained])", "Was fed [src] (Reagents: [contained])", "used [src] (Reagents: [contained]) to feed")

		var/mob/living/carbon/human/H = M
		if(H.ingest(src, TRUE))
			return 1

		if(reagents.total_volume)
			reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		qdel(src)
		return 1

	return 0

/obj/item/reagent_containers/pill/afterattack(obj/target, mob/user, proximity)
	if(!proximity) return

	if(target.is_open_container() && target.reagents)
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='notice'>[target] is empty. Can't dissolve \the [src].</span>")
			return
		to_chat(user, "<span class='notice'>You dissolve \the [src] in [target].</span>")

		admin_attacker_log(user, "spiked \a [target] with a pill. Reagents: [reagentlist()]")
		reagents.trans_to(target, reagents.total_volume)
		for(var/mob/O in viewers(2, user))
			O.show_message("<span class='warning'>[user] puts something in \the [target].</span>", 1)
		qdel(src)
	return

////////////////////////////////////////////////////////////////////////////////
/// Pills. END
////////////////////////////////////////////////////////////////////////////////

//We lied - it's pills all the way down
/obj/item/reagent_containers/pill/tox
	desc = "toxins pill. Highly toxic."
	icon_state = "pill4"
	startswith = list(/datum/reagent/toxin)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/cyanide
	desc = "strange pill. It's marked 'KCN'. Smells vaguely of almonds."
	icon_state = "pill9"
	startswith = list(/datum/reagent/toxin/cyanide)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/adminordrazine
	desc = "Adminordrazine pill. It's magic. We don't have to explain it."
	icon_state = "pillA"
	startswith = list(/datum/reagent/adminordrazine)

/obj/item/reagent_containers/pill/stox
	desc = "Soporific (15 ml). Commonly used to treat insomnia."
	icon_state = "pill3"
	startswith = list(/datum/reagent/soporific = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/kelotane
	desc = "Kelotane (15 ml). Used to treat burns."
	icon_state = "pill2"
	startswith = list(/datum/reagent/kelotane = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/paracetamol
	desc = "Paracetamol (15 ml). A painkiller for the ages. Chewables!"
	icon_state = "pill3"
	startswith = list(/datum/reagent/painkiller/paracetamol = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/tramadol
	desc = "Tramadol (15 ml). A simple painkiller."
	icon_state = "pill3"
	startswith = list(/datum/reagent/painkiller/tramadol = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/inaprovaline
	desc = "Inaprovaline (30 ml). Used to stabilize patients."
	icon_state = "pill1"
	startswith = list(/datum/reagent/inaprovaline)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/dexalin
	desc = "Dexalin (15ml). Used to treat oxygen deprivation."
	icon_state = "pill1"
	startswith = list(/datum/reagent/dexalin = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/dexalin_plus
	desc = "Dexalin Plus (15 ml). Used to treat extreme oxygen deprivation."
	icon_state = "pill2"
	startswith = list(/datum/reagent/dexalinp = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/dermaline
	desc = "Dermaline (15 ml). Used to treat burn wounds."
	icon_state = "pill2"
	startswith = list(/datum/reagent/dermaline = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/dylovene
	desc = "Dylovene (15 ml). A broad-spectrum anti-toxin."
	icon_state = "pill1"
	startswith = list(/datum/reagent/dylovene = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/bicaridine
	desc = "Bicaridine (20 ml). Used to treat physical injuries."
	icon_state = "pill2"
	startswith = list(/datum/reagent/bicaridine = 20)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/happy
	desc = "happy pill. Happy happy joy joy!"
	icon_state = "pill4"
	startswith = list(
		/datum/reagent/space_drugs = 15,
		/datum/reagent/sugar = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/zoom
	desc = "zoom pill. Zoooom!"
	icon_state = "pill4"
	startswith = list(
		/datum/reagent/impedrezene = 10,
		/datum/reagent/synaptizine = 5,
		/datum/reagent/hyperzine = 5)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/spaceacillin
	desc = "Spaceacillin (10 ml). Contains antiviral agents."
	icon_state = "pill3"
	startswith = list(/datum/reagent/spaceacillin = 10)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/diet
	desc = "diet pill. Guaranteed to get you slim!"
	icon_state = "pill4"
	startswith = list(/datum/reagent/lipozine = 2)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/noexcutite
	desc = "Noexcutite (15 ml). Feeling jittery? This should calm you down."
	icon_state = "pill4"
	startswith = list(/datum/reagent/noexcutite = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/antidexafen
	desc = "Antidexafen (15 ml). Common cold mediciation. Safe for babies!"
	icon_state = "pill4"
	startswith = list(
		/datum/reagent/antidexafen = 10,
		/datum/reagent/drink/juice/lemon = 5,
		/datum/reagent/menthol = REM*0.2)
	mimic_color = TRUE

//Psychiatry pills.
/obj/item/reagent_containers/pill/methylphenidate
	desc = "Methylphenidate (15 ml). Improves the ability to concentrate."
	icon_state = "pill2"
	startswith = list(/datum/reagent/methylphenidate = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/citalopram
	desc = "Citalopram (15 ml). Mild anti-depressant."
	icon_state = "pill4"
	startswith = list(/datum/reagent/citalopram = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/paroxetine
	desc = "Paroxetine (10 ml). Before you swallow a bullet: try swallowing this!"
	icon_state = "pill4"
	startswith = list(/datum/reagent/paroxetine = 10)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/hyronalin
	desc = "Hyronalin (10 ml). Got some rads? Eat this!"
	icon_state = "pill4"
	startswith = list(/datum/reagent/hyronalin = 10)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/glucose
	desc = "Glucose (20 ml). Used to treat blood loss"
	icon_state = "pill4"
	startswith = list(/datum/reagent/nutriment/glucose = 20)
	mimic_color = TRUE

//Mining pills.
/obj/item/reagent_containers/pill/leporazine
	desc = "Thermostabilizine. Contents 15 ml of leporazine. Effectively stabilizes body temperature."
	icon_state = "pill2"
	startswith = list(/datum/reagent/leporazine = 15)
	mimic_color = TRUE

//Not actually a pill, but pills type provide everything needed for this
/obj/item/reagent_containers/pill/sugar_cube
	desc = "sugar cube. Sugar pressed together in block shape that is used to sweeten drinks."
	icon_state = "sugar_cubes"
	startswith = list(/datum/reagent/sugar = 15)
	mimic_color = TRUE

//Not actually a pill, but pills type provide everything needed for this
/obj/item/reagent_containers/pill/cleanerpod
	desc = "space cleaner pod. BLAM!-brand non-foaming space cleaner in concentrated form! Use one pod per half a liter water. Should not be consumed, but hey I'm not your mom nor a doctor."
	icon_state = "cleanerpod"
	startswith = list(/datum/reagent/space_cleaner/dry = 10)
	mimic_color = FALSE

//Pills that probably won't be used anywhere, except in merchants or mapping, but who cares?

/obj/item/reagent_containers/pill/oxycodone
	desc = "Oxycodone (15 ml). A complex painkiller."
	icon_state = "pill3"
	startswith = list(/datum/reagent/painkiller/tramadol/oxycodone = 15)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/metazine
	desc = "Metazine (10 ml). A combat painkiller."
	icon_state = "pill24"
	startswith = list(/datum/reagent/painkiller = 10)
	mimic_color = FALSE

/obj/item/reagent_containers/pill/tricordrazine
	desc = "Tricordrazine (20 ml). Used to slowly treat external injuries."
	icon_state = "pill2"
	startswith = list(/datum/reagent/tricordrazine = 20)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/alkysine
	desc = "Alkysine (5 ml). Do you have a headache? Just eat me!"
	icon_state = "pill2"
	startswith = list(/datum/reagent/alkysine = 5)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/imidazoline
	desc = "Imidazoline (10 ml). Used to treat eye injuries."
	icon_state = "pill2"
	startswith = list(/datum/reagent/imidazoline = 10)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/ryetalyn
	desc = "Ryetalyn (5 ml). Used for genetic defects, including cataracts."
	icon_state = "pill3"
	startswith = list(/datum/reagent/ryetalyn = 5)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/peridaxon
	desc = "Peridaxon (10 ml). Used to restore the internal organs and nervous system."
	icon_state = "pill2"
	startswith = list(/datum/reagent/peridaxon = 10)
	mimic_color = TRUE

/obj/item/reagent_containers/pill/albumin
	desc = "Albumin (20 ml). Used to restore blood loss."
	icon_state = "pill3"
	startswith = list(
		/datum/reagent/albumin = 15,
		/datum/reagent/iron = 5)
	mimic_color = TRUE

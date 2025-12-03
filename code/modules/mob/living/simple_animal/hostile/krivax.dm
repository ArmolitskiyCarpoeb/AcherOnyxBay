GLOBAL_LIST_EMPTY(krivax) //all sentient spider mobs

/mob/living/simple_animal/hostile/krivax
	name = "кривакс"
	desc = "Криваксы - насекомо-примато-подобные твари, агрессивные и противные."
	icon = 'icons/mob/animal.dmi'
	speak_emote = list("chitters")
	emote_hear = list("chitters")
	icon_state = "krivax"
	icon_living = "krivax"
	icon_dead = "krivax_dead"
	health = 100
	maxHealth = 100
	melee_damage_lower = 10
	melee_damage_upper = 20
	can_escape = 1
	attacktext = list("punched", "clawed", "bitten")
	attack_sound = 'sound/weapons/bite.ogg'
	speed = 4
	bodyparts = /decl/simple_animal_bodyparts/krivax
	response_help  = "pets"
	response_disarm = "pushes aside"
	min_gas = null
	max_gas = null
	minbodytemp = 0
	see_in_dark = 6
	controllable = TRUE
	break_stuff_probability = 25

/decl/simple_animal_bodyparts/krivax
	hit_zones = list("segmented arms", "maw", "eye", "segmented legs")

/datum/language/krivax
	name = LANGUAGE_KRIVAX
	desc = "A strange language that can be understood both by the sounds made and by the movement needed to create those sounds."
	signlang_verb = list("chitters", "grinds its mouthparts", "chitters and grinds its mouthparts")
	key = "k"
	language_flags = RESTRICTED | SIGNLANG | NO_STUTTER | NONVERBAL
//	colour = ".spider"
	shorthand = "KR"

/mob/living/simple_animal/hostile/giant_spider/New(location, atom/parent)
	get_light_and_color(parent)
	InitializeHud()

	GLOB.krivax.Add(src)

	var/language = new /datum/language/krivax
	languages.Add(language)
	default_language = language
	..()

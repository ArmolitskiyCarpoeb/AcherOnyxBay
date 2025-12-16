var/list/trait_datums = list() // Assoc list using name = instance.  Traits are saved as a list of strings.
var/list/trait_type_to_ref = list() // Similar to above but uses paths, which is more reliable but more risky to save.
var/list/trait_categories = list() // The categories available for the trait menu.
var/TRAIT_POINTS_MAX = 0

/hook/startup/proc/populate_trait_list()

	//create a list of trait datums
	for(var/trait_type in typesof(/datum/trait) - list(
		/datum/trait,
		/datum/trait/modifier,
		/datum/trait/modifier/good,
		/datum/trait/modifier/bad,
		/datum/trait/modifier/neutral
	))
		var/datum/trait/T = new trait_type

		if(!T.name)
			//if(!T.category) //Well we don't want to get runtime errors for generic /datum/trait/modifier/physical and /datum/trait/modifier/mental, right?
			error("Trait Menu - Missing name: [T.type]")
			continue

		if(!T.category)
			error("Trait Menu - Missing category: [T.type]")
			continue

		T.desc = T.generate_desc()

		trait_datums[T.name] = T
		trait_type_to_ref[T.type] = T
		if(!(T.category in trait_categories))
			trait_categories += T.category

	return 1

/datum/category_item/player_setup_item/traits
	name = "Traits"
	sort_order = 1
	var/current_tab = "Physical"

/datum/category_item/player_setup_item/traits/load_character(datum/pref_record_reader/R)
	pref.traits = R.read("traits")

/datum/category_item/player_setup_item/traits/save_character(datum/pref_record_writer/W)
	W.write("traits", pref.traits)

/datum/category_item/player_setup_item/traits/proc/get_current_trait_points()
	var/points = 0
	if(!islist(pref.traits))
		return points
	for(var/trait_name in pref.traits)
		var/datum/trait/T = trait_datums[trait_name]
		if(T)
			points += T.trait_cost
	return points

/datum/category_item/player_setup_item/traits/proc/enforce_trait_points_limit()
	var/current_points = get_current_trait_points()
	if(current_points <= TRAIT_POINTS_MAX)
		return

	// Собираем положительные трейты и их стоимость
	var/list/positive_traits = list()
	for(var/trait_name in pref.traits)
		var/datum/trait/T = trait_datums[trait_name]
		if(T && T.trait_cost > 0)
			positive_traits[trait_name] = T.trait_cost

	// Снимаем самые дорогие положительные трейты, пока не уложимся в лимит
	while(current_points > TRAIT_POINTS_MAX && positive_traits.len)
		var/remove_trait = null
		var/remove_cost = -INFINITY
		for(var/trait_name in positive_traits)
			var/cost = positive_traits[trait_name]
			if(cost > remove_cost)
				remove_cost = cost
				remove_trait = trait_name

		if(!remove_trait)
			break

		pref.traits -= remove_trait
		positive_traits -= remove_trait
		current_points -= remove_cost

		var/mob/preference_mob = preference_mob()
		if(preference_mob)
			to_chat(preference_mob, SPAN("warning", "Трейт [remove_trait] удалён: недостаточно очков."))

/datum/category_item/player_setup_item/traits/content()
	. = list()
	var/current_points = get_current_trait_points()
	. += "<table align = 'center' width = 100%>"
	. += "<tr><td colspan=3><b><center>Traits (Очки: [current_points]/[TRAIT_POINTS_MAX])</center></b></td></tr>"
	. += "<table align = 'center' width = 100%>"
	. += "<tr><td colspan=3><hr></td></tr>"
	. += "<tr><td colspan=3><b><center>Traits</center></b></td></tr>"
	. += "<tr><td colspan=3><hr></td></tr>"

	. += "<tr><td colspan=3><center>"
	var/firstcat = 1
	for(var/category in trait_categories)
		if(firstcat)
			firstcat = 0
		else
			. += " |"

		if(category == current_tab)
			. += " <span class='linkOn'>[category]</span> "
		else
			. += " <a href='?src=\ref[src];select_category=[category]'>[category]</a> "
	. += "</center></td></tr>"


	for(var/trait_name in trait_datums)
		var/datum/trait/T = trait_datums[trait_name]
		if(T.category != current_tab)
			continue

		var/ticked = (T.name in pref.traits)
		var/style_class
		if(!T.validate(pref.traits, src))
			style_class = "linkOff"
		else if(ticked)
			style_class = "linkOn"
		. += "<tr style='vertical-align:top;'><td width=25%><div align='center'><a style='white-space:normal;' [style_class ? "class='[style_class]' " : ""]href='?src=\ref[src];toggle_trait=[html_encode(T.name)]'>[T.name] ([T.trait_cost])</a></div></td>"
//		. += "<td width = 10% style='vertical-align:top'>[G.cost]</td>"

		var/invalidity = T.test_for_invalidity(src)
		var/conflicts = T.test_for_trait_conflict(pref.traits)
		var/invalid = ""
		if(invalidity)
			invalid += "[invalidity]  "
		if(conflicts)
			invalid += "This trait is mutually exclusive with [conflicts]."

		. += "<td width = 75%><font size=2><i>[T.desc]</i>\
		[invalid ? "<font color='#FF0000'><br>Cannot take trait. Reason: [invalid]</font>":""]</font></td></tr>"
//		if(ticked)
//			. += "<tr><td colspan=3>"
//			for(var/datum/gear_tweak/tweak in G.gear_tweaks)
//				. += " <a href='?src=\ref[src];gear=[G.display_name];tweak=\ref[tweak]'>[tweak.get_contents(get_tweak_metadata(G, tweak))]</a>"
//			. += "</td></tr>"
	. += "</table>"
	. = jointext(., null)

/datum/category_item/player_setup_item/traits/sanitize_character()
	var/mob/preference_mob = preference_mob()
	if(!islist(pref.traits))
		pref.traits = list()

	for(var/trait_name in pref.traits)
		if(!(trait_name in trait_datums))
			pref.traits -= trait_name

	for(var/trait_name in pref.traits)
		if(!trait_datums[trait_name])
			to_chat(preference_mob, SPAN("warning", "You cannot have more than one of trait: [trait_name]"))
			pref.traits -= trait_name
		else
			var/datum/trait/T = trait_datums[trait_name]
			var/invalidity = T.test_for_invalidity(src)
			if(invalidity)
				pref.traits -= trait_name
				to_chat(preference_mob, SPAN("warning", "You cannot take the [trait_name] trait. Reason: [invalidity]"))

			var/conflicts = T.test_for_trait_conflict(pref.traits)
			if(conflicts)
				pref.traits -= trait_name
				to_chat(preference_mob, SPAN("warning", "The [trait_name] trait is mutually exclusive with [conflicts]."))

/datum/category_item/player_setup_item/traits/OnTopic(href, href_list, user)
	if(href_list["toggle_trait"])
		var/datum/trait/T = trait_datums[href_list["toggle_trait"]]
		if(T.name in pref.traits)
			pref.traits -= T.name
			enforce_trait_points_limit()
		else
			var/invalidity = T.test_for_invalidity(src)
			if(invalidity)
				to_chat(user, SPAN("warning", "You cannot take the [T.name] trait. Reason: [invalidity]"))
				return TOPIC_NOACTION

			var/conflicts = T.test_for_trait_conflict(pref.traits)
			if(conflicts)
				to_chat(user, SPAN("warning", "The [T.name] trait is mutually exclusive with [conflicts]."))
				return TOPIC_NOACTION

			var/current_points = get_current_trait_points()
			var/new_points = current_points + T.trait_cost
			if(new_points > TRAIT_POINTS_MAX)
				to_chat(user, SPAN("warning", "Вы не можете взять трейт ''[T.name]'': недостаточно очков трейтов. (Текущие: [current_points], нужно: [T.trait_cost])"))
				return TOPIC_NOACTION

			pref.traits += T.name
		return TOPIC_REFRESH_UPDATE_PREVIEW
	else if(href_list["select_category"])
		current_tab = href_list["select_category"]
		return TOPIC_REFRESH
	return ..()



/datum/trait
	var/name = null							// Name to show on UI
	var/desc = null							// Description of what it does, also shown on UI.
	var/list/mutually_exclusive = list()	// List of trait types which cannot be taken alongside this trait.
	var/category = null						// What section to place this trait inside.
	var/trait_cost = 0						// How many points this trait costs.

// Applies effects to the newly spawned mob.
/datum/trait/proc/apply_trait_post_spawn(mob/living/L)
	return

// Used to forbid a trait based on certain criteria (e.g. if they are an FBP).
// It receives the player_setup_item datum since some reasons for being invalid depend on the currently loaded preferences.
// Returns a string explaining why the trait is invalid.  Returns null if valid.
/datum/trait/proc/test_for_invalidity(datum/category_item/player_setup_item/traits/setup)
	return null

// Checks mutually_exclusive.  current_traits needs to be a list of strings.
// Returns null if everything is well, similar to the above proc.  Otherwise returns an english_list() of conflicting traits.
/datum/trait/proc/test_for_trait_conflict(list/current_traits)
	var/list/conflicts = list()
	var/result

	for(var/trait_name in current_traits)
		var/datum/trait/T = trait_datums[trait_name]
		if(!T)
			continue
		// Проверяем конфликт как в прямом, так и в обратном направлении,
		// чтобы ловить случаи, когда конфликт указан только на одной стороне.
		if((mutually_exclusive.len && T.type in mutually_exclusive) || (T.mutually_exclusive.len && src.type in T.mutually_exclusive))
			conflicts.Add(T.name)

	if(conflicts.len)
		result = english_list(conflicts)

	return result

// Similar to above, but uses the above two procs, in one place.
// Returns TRUE is everything is well.
/datum/trait/proc/validate(list/current_traits, datum/category_item/player_setup_item/traits/setup)
	if(test_for_invalidity(setup))
		return FALSE
	if(test_for_trait_conflict(current_traits))
		return FALSE
	return TRUE

// Creates a description, if one doesn't exist.
// This one is for inheritence, and so doesn't do anything.
/datum/trait/proc/generate_desc()
	return desc

/mob/living/proc/apply_traits()
	if(!mind || !mind.traits || !mind.traits.len)
		return
	for(var/trait in mind.traits)
		var/datum/trait/T = trait_datums[trait]
		if(istype(T))
			T.apply_trait_post_spawn(src)

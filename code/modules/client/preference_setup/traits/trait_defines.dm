// This contains character setup datums for traits.
// The actual modifiers (if used) for these are stored inside code/modules/mob/_modifiers/traits.dm

/datum/trait/modifier
	var/modifier_type = null // Type to add to the mob post spawn.

/datum/trait/modifier/apply_trait_post_spawn(mob/living/L)
	L.add_modifier(modifier_type)

/datum/trait/modifier/generate_desc()
	var/new_desc = desc
	if(!modifier_type)
		new_desc = "[new_desc] This trait is not implemented yet."
		return new_desc
	var/datum/modifier/M = new modifier_type()
	if(!desc)
		new_desc = M.desc // Use the modifier's description, if the trait doesn't have one defined.
	var/modifier_effects = M.describe_modifier_effects()
	new_desc = "[new_desc][modifier_effects ? "<br>[modifier_effects]":""]" // Now describe what the trait actually does.
	qdel(M)
	return new_desc

// Base groups for trait categories in the UI.
/datum/trait/modifier/good
	category = "Положительные" // positive traits, usually cost points

/datum/trait/modifier/bad
	category = "Отрицательные" // negative traits, usually give points
/*
/datum/trait/modifier/neutral
	category = "Нейтральные" // neutral / flavour traits
*/

/// ХОРОШИЕ ТРЕЙТЫ

// /datum/trait/modifier/good/skiled_medical
// 	name = "Учился врачевать"
// 	desc = "Одно время ты работал в больнице и нахватался полезных знаний."
// 	modifier_type = /datum/modifier/trait/skiled_medical
// 	mutually_exclusive = list(/datum/trait/modifier/bad/unskiled_medical)
// 	trait_cost = 2

/datum/trait/modifier/good/skiled_melee
	name = "Умею махать кулаками"
	desc = "Жизнь заставила тебя научится стоять за себя"
	modifier_type = /datum/modifier/trait/skiled_melee
	mutually_exclusive = list(/datum/trait/modifier/bad/unskiled_melee)
	trait_cost = 2

/datum/trait/modifier/good/skiled_ranged
	name = "Умелый стрелок"
	desc = "Твой папка учит тебя держать оружие в руках. Пригодятся ли тебе этот навык сейчас?"
	modifier_type = /datum/modifier/trait/skiled_ranged
	//mutually_exclusive = list(/datum/trait/modifier/bad/unskiled_ranged)
	trait_cost = 2

// /datum/trait/modifier/good/skiled_engineering
// 	name = "Неплохой инженер"
// 	desc = "Когда-то у тебя был свой шаттл. Не важно что он не работал, зато ты умеешь его чинить!"
// 	modifier_type = /datum/modifier/trait/skiled_engineering
// 	mutually_exclusive = list(/datum/trait/modifier/bad/unskiled_engineering)
// 	trait_cost = 2

// /datum/trait/modifier/good/skiled_cooking
// 	name = "Хорошо готовлю"
// 	desc = "Твои навыки кулинарии на высоте!"
// 	modifier_type = /datum/modifier/trait/skiled_cooking
// 	mutually_exclusive = list(/datum/trait/modifier/bad/unskiled_cooking)
// 	trait_cost = 2

// /datum/trait/modifier/good/high_metabolism
// 	name = "Быстрый метаболизм"
// 	modifier_type = /datum/modifier/trait/high_metabolism
// 	mutually_exclusive = list(/datum/trait/modifier/bad/low_metabolism)
// 	trait_cost = 1 // positive: costs points

// /datum/trait/modifier/good/high_metabolism/test_for_invalidity(datum/category_item/player_setup_item/traits/setup)
// 	if(setup.is_FBP())
// 		return "Full Body Prosthetics do not have a metabolism."
// 	return ..()

/datum/trait/modifier/good/less_stun
	name = "Быстрое восстановление"
	desc = "Ты часто падал. Но всё равно вставал. Это тебя кое-чему научило."
	modifier_type = /datum/modifier/trait/less_stun
	mutually_exclusive = list(/datum/trait/modifier/bad/more_stun)
	trait_cost = 2 // positive: costs points

// /datum/trait/modifier/good/toxinlover
// 	name = "Житель индустриального района"
// 	modifier_type = /datum/modifier/trait/toxinlover
// 	trait_cost = 2 // positive: costs points

// /datum/trait/modifier/good/fast_hands
// 	name = "Быстрые руки"
// 	desc = "Поспешишь - людей насмешишь."
// 	modifier_type = /datum/modifier/actionspeed/timecookie
// 	trait_cost = 2 // positive: costs points

// /datum/trait/modifier/good/fast_legs
// 	name = "Быстрые ноги"
// 	desc = "Ты торопишься. Нет, ты ОЧЕНЬ торопишься."
// 	modifier_type = /datum/modifier/movespeed/fast_legs
// 	mutually_exclusive = list(/datum/trait/modifier/bad/slow_legs)
// 	trait_cost = 2 // positive: costs points

/// ПЛОХИЕ ТРЕЙТЫ

// /datum/trait/modifier/bad/autism //ДОБАВИТЬ ИСКЛЮЧЕНИЕ ТРЕЙТОВ НА ЗДОРОВЬЕ И МЕТАБОЛИЗМ
// 	name = "Аутизм"
// 	desc = "Тебя часто роняли головой. Удачи!"
// 	modifier_type = /datum/modifier/trait/autism
// 	mutually_exclusive = list(/datum/trait/modifier/bad/stammering, /datum/trait/modifier/bad/burrieng, /datum/trait/modifier/bad/lisping,
// 						/datum/modifier/trait/haemophilia,
// 						/datum/trait/modifier/good/high_metabolism, /datum/trait/modifier/bad/low_metabolism)
// 	trait_cost = -4

/datum/trait/modifier/bad/bad_eyes
	name = "Плохое зрение"
	desc = "У тебя плохое зрение"
	modifier_type = /datum/modifier/trait/bad_eyes
	trait_cost = -2

// /datum/trait/modifier/bad/unskiled_medical
// 	name = "Врач-шарлатан"
// 	desc = "Пока ты работал в больнице, смертей стало больше. Интересно почему?"
// 	modifier_type = /datum/modifier/trait/unskiled_medical
// 	mutually_exclusive = list(/datum/trait/modifier/good/skiled_medical)
// 	trait_cost = -2

/datum/trait/modifier/bad/unskiled_melee
	name = "Тюфяк"
	desc = "Ты даже не знаешь как постоять за себя."
	modifier_type = /datum/modifier/trait/unskiled_melee
	mutually_exclusive = list(/datum/trait/modifier/good/skiled_melee)
	trait_cost = -3

// /datum/trait/modifier/bad/unskiled_ranged
// 	name = "Не разбираюсь в оружии"
// 	desc = "Оружие - фу."
// 	modifier_type = /datum/modifier/trait/unskiled_ranged
// 	mutually_exclusive = list(/datum/trait/modifier/good/skiled_ranged)
// 	trait_cost = -2

// /datum/trait/modifier/bad/unskiled_engineering
// 	name = "Бездарный инженер"
// 	desc = "Ты так и не починил смеситель у себя дома..."
// 	modifier_type = /datum/modifier/trait/unskiled_engineering
// 	mutually_exclusive = list(/datum/trait/modifier/good/skiled_engineering)
// 	trait_cost = -1

// /datum/trait/modifier/bad/unskiled_cooking
// 	name = "Массовый отравитель"
// 	desc = "Ты готовишь плохо. Даже очень плохо. Твоей бабушке лучше это не пробовать."
// 	modifier_type = /datum/modifier/trait/unskiled_cooking
// 	mutually_exclusive = list(/datum/trait/modifier/good/skiled_cooking)
// 	trait_cost = -1

// /datum/trait/modifier/bad/slow_legs
// 	name = "Медленные ноги"
// 	desc = "Ты не торопишься. Нет, ты ОЧЕНЬ не торопишься."
// 	modifier_type = /datum/modifier/movespeed/slow_legs
// 	mutually_exclusive = list(/datum/trait/modifier/good/fast_legs)
// 	trait_cost = -2 // positive: costs points

/datum/trait/modifier/bad/more_stun
	name = "Любитель полежать"
	desc = "Ты часто падал. Пол так и манит, тебе нравится полежать подольше!"
	modifier_type = /datum/modifier/trait/more_stun
	mutually_exclusive = list(/datum/trait/modifier/good/less_stun)
	trait_cost = -2 // positive: costs points
/*
/datum/trait/modifier/bad/haemophilia
	name = "Haemophilia"
	desc = "Some say that when it rains, it pours.  Unfortunately, this is also true for yourself if you get cut."
	modifier_type = /datum/modifier/trait/haemophilia
	trait_cost = -2

/datum/trait/modifier/bad/haemophilia/test_for_invalidity(datum/category_item/player_setup_item/traits/setup)
	if(setup.is_FBP())
		return "Full Body Prosthetics cannot bleed."
	// If a species lacking blood is added, it is suggested to add a check for them here.
	return ..()

/datum/trait/modifier/bad/inaccurate
	name = "Inaccurate"
	desc = "You're rather inexperienced with guns, you've never used one in your life, or you're just really rusty.  \
	Regardless, you find it quite difficult to land shots where you wanted them to go."
	modifier_type = /datum/modifier/trait/inaccurate
	mutually_exclusive = list(/datum/trait/modifier/good/skilledmarksman)
	trait_cost = -1

/datum/trait/modifier/bad/low_metabolism
	name = "Low Metabolism"
	modifier_type = /datum/modifier/trait/low_metabolism
	mutually_exclusive = list(/datum/trait/modifier/good/high_metabolism)
	trait_cost = -1

/datum/trait/modifier/bad/low_metabolism/test_for_invalidity(datum/category_item/player_setup_item/traits/setup)
	if(setup.is_FBP())
		return "Full Body Prosthetics do not have a metabolism."
	return ..()

/datum/trait/modifier/bad/test_for_invalidity(datum/category_item/player_setup_item/traits/setup)
	if(setup.is_FBP())
		if(setup.get_FBP_type() == PREF_FBP_SOFTWARE)
			return "Drone Intelligences cannot feel emotions."
	return ..()

/datum/trait/modifier/bad/nyctophobe
	name = "Nyctophobic"
	desc = "More commonly known as the fear of darkness.  The shadows can hide many dangers, which makes the prospect of going into the depths of Maintenance rather worrisome."
	modifier_type = /datum/modifier/trait/phobia/nyctophobe
	trait_cost = -1


/datum/trait/modifier/bad/haemophobe
	name = "Haemophobia"
	desc = "Not to be confused with Haemophilia (which makes you bleed faster), Haemophobia is the fear of blood.  Seeing a bunch of blood isn't really \
	pleasant for most people, but for you, it is very distressing."
	modifier_type = /datum/modifier/trait/phobia/haemophobia
	trait_cost = -1

/datum/trait/modifier/bad/claustrophobe
	name = "Claustrophobic"
	desc = "Small spaces and tight quarters makes you feel distressed.  Unfortunately both are rather common when living in space."
	modifier_type = /datum/modifier/trait/phobia/claustrophobe
	trait_cost = -1
*/
/datum/trait/modifier/bad/stammering
	name = "Заика"
	modifier_type = /datum/modifier/trait/stammering
	mutually_exclusive = list(/datum/trait/modifier/bad/burrieng, /datum/trait/modifier/bad/lisping)
	trait_cost = -1

/datum/trait/modifier/bad/burrieng
	name = "Картавый"
	modifier_type = /datum/modifier/trait/burrieng
	mutually_exclusive = list(/datum/trait/modifier/bad/stammering, /datum/trait/modifier/bad/lisping)
	trait_cost = -1

/datum/trait/modifier/bad/lisping
	name = "Шипилявый"
	modifier_type = /datum/modifier/trait/lisping
	mutually_exclusive = list(/datum/trait/modifier/bad/stammering, /datum/trait/modifier/bad/burrieng)
	trait_cost = -1

/// НЕЙТРАЛЬНЫЕ ТРЕЙТЫ
/*
/datum/trait/modifier/neutral/colorblind_protanopia
	name = "Protanopia"
	desc = "You have a form of red-green colorblindness. You cannot see reds, and have trouble distinguishing them from yellows and greens."
	modifier_type = /datum/modifier/trait/colorblind_protanopia
	mutually_exclusive = list(
		/datum/trait/modifier/neutral/colorblind_deuteranopia,
		/datum/trait/modifier/neutral/colorblind_tritanopia,
		/datum/trait/modifier/neutral/colorblind_monochrome
	)
	trait_cost = 0 // neutral / cosmetic

/datum/trait/modifier/neutral/colorblind_deuteranopia
	name = "Deuteranopia"
	desc = "You have a form of red-green colorblindness. You cannot see greens, and have trouble distinguishing them from yellows and reds."
	modifier_type = /datum/modifier/trait/colorblind_deuteranopia
	mutually_exclusive = list(
		/datum/trait/modifier/neutral/colorblind_protanopia,
		/datum/trait/modifier/neutral/colorblind_tritanopia,
		/datum/trait/modifier/neutral/colorblind_monochrome
	)
	trait_cost = 0

/datum/trait/modifier/neutral/colorblind_tritanopia
	name = "Tritanopia"
	desc = "You have a form of blue-yellow colorblindness. You have trouble distinguishing between blues, greens, and yellows, and see blues and violets as dim."
	modifier_type = /datum/modifier/trait/colorblind_tritanopia
	mutually_exclusive = list(
		/datum/trait/modifier/neutral/colorblind_protanopia,
		/datum/trait/modifier/neutral/colorblind_deuteranopia,
		/datum/trait/modifier/neutral/colorblind_monochrome
	)
	trait_cost = 0

/datum/trait/modifier/neutral/colorblind_monochrome
	name = "Monochromacy"
	desc = "You are fully colorblind. Your condition is rare, but you can see no colors at all."
	modifier_type = /datum/modifier/trait/colorblind_monochrome
	mutually_exclusive = list(
		/datum/trait/modifier/neutral/colorblind_protanopia,
		/datum/trait/modifier/neutral/colorblind_deuteranopia,
		/datum/trait/modifier/neutral/colorblind_tritanopia
	)
	trait_cost = 0




*/

/datum/trait/modifier/bad/opiat_addiction
	name = "Зависимость от опиатов"
	desc = "Подлый отказ от героина вынудет твой организм отказаться от существования."
	modifier_type = /datum/modifier/trait/opiat_addiction
	mutually_exclusive = list(
		/datum/trait/modifier/bad/alcohol_addiction,
		/datum/trait/modifier/bad/cannabis_addiction,
		/datum/trait/modifier/bad/smoker
	)
	trait_cost = -2

/datum/trait/modifier/bad/cannabis_addiction
	name = "Любитель марихуаны"
	desc = "Без марихуаны расслабиться не выйдет. Увы!"
	modifier_type = /datum/modifier/trait/cannabis_addiction
	mutually_exclusive = list(
		/datum/trait/modifier/bad/alcohol_addiction,
		/datum/trait/modifier/bad/smoker,
		/datum/trait/modifier/bad/opiat_addiction
	)
	trait_cost = -1

/datum/trait/modifier/bad/alcohol_addiction
	name = "Алкоголик"
	desc = "Между первой и второй - перерывчик небольшой."
	modifier_type = /datum/modifier/trait/alcohol_addiction
	mutually_exclusive = list(
		/datum/trait/modifier/bad/smoker,
		/datum/trait/modifier/bad/cannabis_addiction,
		/datum/trait/modifier/bad/opiat_addiction
	)
	trait_cost = -1

/datum/trait/modifier/bad/smoker
	name = "Курильщик"
	desc = "Но если есть в кармане пачка сигарет... Значит, всё не так уж плохо на сегодняшний день."
	modifier_type = /datum/modifier/trait/smoker
	mutually_exclusive = list(
		/datum/trait/modifier/bad/alcohol_addiction,
		/datum/trait/modifier/bad/cannabis_addiction,
		/datum/trait/modifier/bad/opiat_addiction
	)
	trait_cost = -1

/datum/trader/ship/MonsLadenCargo
	name = "Roger Herb"
	origin = "Mons-Laden delivery service"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 240

	possible_wanted_items = list(
							/obj/item/reagent_containers/food/grown								= TRADER_ALL,
							/obj/item/ore 														= TRADER_ALL,
							/obj/item/seeds  													= TRADER_ALL,
							/obj/item/stack/material/											= TRADER_SUBTYPES_ONLY,
							/obj/item/reagent_containers/food/human								= TRADER_ALL,
							/obj/item/reagent_containers/food/meat 								= TRADER_ALL
							)

	possible_trading_items = list(
							/obj/item/pizzabox													= TRADER_SUBTYPES_ONLY,
							/mob/living/simple_animal/pig 										= TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/soydope 							= TRADER_THIS_TYPE,
							/datum/design/item/powercell/device/high							= TRADER_THIS_TYPE,
							/obj/item/stack/material/plastic/fifty 								= TRADER_THIS_TYPE,
							/obj/item/stack/material/marble/fifty 								= TRADER_THIS_TYPE,
							/obj/item/stack/material/glass/plass/ten 							= TRADER_THIS_TYPE,
							/obj/item/bodybag/cryobag 											= TRADER_THIS_TYPE,
							/obj/item/device/binoculars 										= TRADER_THIS_TYPE,
							/obj/item/music_player/boombox										= TRADER_THIS_TYPE,
							/obj/item/cell/device/high											= TRADER_THIS_TYPE,
							/obj/item/music_tape/custom											= TRADER_THIS_TYPE
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Слушаю. Давай только быстрее. У меня ещё тоннель 7-G проветривать, смена через два часа.",
		TRADER_HAIL_DENY          = "Отстань, у меня обед! Вернее, ужин... Завтрак? В пещерах тяжело определить время.",

		TRADER_TRADE_COMPLETE     = "Дело сделано. Хочешь что-то ещё или я могу допить своё пиво?",
		TRADER_NO_MONEY           = "Нет денег - нет доставки.",
		TRADER_NOT_ENOUGH         = "Что поделать, иди достань бабки и приходи обратно!",
		TRADER_FOUND_UNWANTED     = "Эту дребедень можешь себе оставить.",
		TRADER_HOW_MUCH           = "Это стоит всего VALUE!. Считай быстрее, у сканера штрихкодов батарея садится, а до зарядной станции ещё три километра по тоннелям.",
		TRADER_WHAT_WANT          = "Что-то настоящее. Фрукты или овощи, мясо. А ещё руда и всякие материалы",

		TRADER_COMPLEMENT_FAILURE = "Оставь свои комплименты для того кого они волнуют.",
		TRADER_COMPLEMENT_SUCCESS = "Спасибо. Редко тут услышишь что-то человеческое. Если не считать бормотание из вентиляции.",
		TRADER_INSULT_GOOD        = "Да, я знаю. Я – винтик в системе. Но без нас, вся эта махина остановится.",
		TRADER_INSULT_BAD         = "Слышь, придурок, хочешь чтобы твой заказ *случайно* упал в вентиляцию шахты?",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/MonsLadenCargo/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/MonsLadenCargo/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/MonsLadenCargo/tick()
	return 1

/datum/trader/ship/contraband/MonsLadenContraband
	name = "Joe Hard"
	origin = "Some suspicious trader"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 240

	possible_wanted_items = list(
							// /mob/living/carbon/human 											= TRADER_ALL, //Пока отключил что бы раундстартом не продавали работяг
							/obj/item/organ/internal/											= TRADER_SUBTYPES_ONLY,
							/obj/item/organ/external/											= TRADER_SUBTYPES_ONLY,
							/obj/item/gun/projectile/automatic/									= TRADER_SUBTYPES_ONLY,
							/obj/item/gun/projectile/bolt_action/								= TRADER_SUBTYPES_ONLY,
							/obj/item/gun/projectile/revolver/									= TRADER_SUBTYPES_ONLY,
							/obj/item/gun/projectile/pistol										= TRADER_SUBTYPES_ONLY,
							/obj/item/gun/energy/ 												= TRADER_SUBTYPES_ONLY
							)

	possible_trading_items = list(/obj/item/gun/projectile/automatic/as75 						= TRADER_THIS_TYPE,
							/obj/item/ammo_magazine/c556 										= TRADER_THIS_TYPE,
							/obj/item/gun/projectile/bolt_action/mauser							= TRADER_THIS_TYPE,
							/obj/item/ammo_magazine/c792										= TRADER_THIS_TYPE,
							/obj/item/gun/projectile/revolver/detective/saw620 					= TRADER_THIS_TYPE,
							/obj/item/ammo_magazine/c38											= TRADER_THIS_TYPE,
							/obj/item/clothing/suit/armor/vest 									= TRADER_ALL,
							/obj/item/clothing/suit/armor/bulletproof							= TRADER_THIS_TYPE,
							/obj/item/clothing/accessory/legguards								= TRADER_ALL,
							/obj/item/clothing/accessory/armguards 								= TRADER_ALL
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Чего? Ты из этих святош? Нет? Тогда по делу говори.",
		TRADER_HAIL_DENY          = "Ладно, похуй.",

		TRADER_TRADE_COMPLETE     = "Заебись, удачно вышло.",
		TRADER_NO_MONEY           = "Ты думаешь, я из благотворительности в этой сырости сижу? Иди найди денег.",
		TRADER_NOT_ENOUGH         = "На эту сумму я только пыль из фильтра могу тебе продать. И то с натяжкой.",
		TRADER_FOUND_UNWANTED     = "Это лучшее что ты смог притащить?",
		TRADER_HOW_MUCH           = "Будёшь выёбываться - не продам вообще. VALUE, всего-то. Решай быстрее!",
		TRADER_WHAT_WANT          = "Ищу необычные... комплектующие. Оружие, броня, органы — всё, что делает жизнь короче или, наоборот, продлевает её неестественным путём.",

		TRADER_COMPLEMENT_FAILURE = "Да пошёл ты. Оставь лесть при себе",
		TRADER_COMPLEMENT_SUCCESS = "Хех. Редко кто замечает. Обычно все смотрят сквозь меня, как сквозь породу. Ценю.",
		TRADER_INSULT_GOOD        = "Остро. Как обвал в соляной шахте. Уважил. Теперь давай по делу.",
		TRADER_INSULT_BAD         = "Знаешь, ведь рано или поздно тебе выходить из шахт. Как бы не случилось чего...",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/contraband/MonsLadenContraband/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/contraband/MonsLadenContraband/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/contraband/MonsLadenContraband/tick()
	return 1

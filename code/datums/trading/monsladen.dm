/datum/trader/ship/regular/MonsLadenCargo
	name = "Roger Herb"
	origin = "Mons-Laden delivery service"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 240

	possible_wanted_items = list(
							/obj/item/reagent_containers/food/grown								= TRADER_ALL,
							/obj/item/seeds  													= TRADER_ALL,
							/obj/item/reagent_containers/food/human								= TRADER_ALL,
							/obj/item/reagent_containers/food/meat/human						= TRADER_ALL,
							/obj/item/reagent_containers/food/meat 								= TRADER_ALL
							)

	possible_trading_items = list(
							/obj/item/storage/tobaccopack/generic								= TRADER_THIS_TYPE,
							/obj/item/flame/lighter/random										= TRADER_THIS_TYPE,
							/obj/item/storage/fancy/cigarettes/menthols							= TRADER_THIS_TYPE,
							/obj/item/storage/fancy/cigarettes									= TRADER_THIS_TYPE,
							/mob/living/simple_animal/pig 										= TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/soydope 							= TRADER_THIS_TYPE,
							/datum/design/item/powercell/device/high							= TRADER_THIS_TYPE,
							/obj/item/bodybag/cryobag 											= TRADER_THIS_TYPE,
							/obj/item/music_player/boombox										= TRADER_THIS_TYPE,
							/obj/item/cell/device/high											= TRADER_THIS_TYPE,
							/obj/item/music_tape/custom											= TRADER_THIS_TYPE,
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Слушаю. Давай только быстрее. У меня ещё тоннель 7-G проветривать.",
		TRADER_HAIL_DENY          = "Отстань, у меня обед! Вернее, ужин... Завтрак? В космосе тяжело определить время.",

		TRADER_TRADE_COMPLETE     = "Дело сделано. Хочешь что-то ещё или я могу допить своё пиво?",
		TRADER_NO_MONEY           = "Нет денег - нет доставки.",
		TRADER_NOT_ENOUGH         = "Что поделать, иди достань бабки и приходи обратно!",
		TRADER_FOUND_UNWANTED     = "Эту дребедень можешь себе оставить.",
		TRADER_HOW_MUCH           = "Это стоит всего VALUE!",
		TRADER_WHAT_WANT          = "Что-то настоящее. Фрукты или овощи, мясо",

		TRADER_COMPLEMENT_FAILURE = "Оставь свои комплименты для того кого они волнуют.",
		TRADER_COMPLEMENT_SUCCESS = "Спасибо. Редко тут услышишь что-то человеческое. Если не считать бормотание из вентиляции.",
		TRADER_INSULT_GOOD        = "Да, я знаю. Я – винтик в системе. Но без нас, вся эта махина остановится.",
		TRADER_INSULT_BAD         = "Слышь, придурок, хочешь чтобы твой заказ *случайно* упал в радиоактивую лужу?",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/regular/MonsLadenCargo/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/regular/MonsLadenCargo/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/regular/MonsLadenCargo/tick()
	return 1

/datum/trader/ship/regular/MonsLadenMedbay
	name = "Bazil Fobos"
	origin = "Точно настоящий врач"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 120

	possible_wanted_items = list(
							/obj/item/organ/internal/											= TRADER_SUBTYPES_ONLY,
							/obj/item/organ/external/											= TRADER_SUBTYPES_ONLY,
							)

	possible_trading_items = list(
							/obj/item/storage/firstaid/surgery/syndie 							= TRADER_THIS_TYPE,
							/obj/item/storage/firstaid/surgery/									= TRADER_THIS_TYPE,
							/obj/item/storage/firstaid											= TRADER_THIS_TYPE,
							/obj/item/clothing/accessory/stethoscope							= TRADER_THIS_TYPE,
							/obj/item/autopsy_scanner											= TRADER_THIS_TYPE,
							/obj/item/defibrillator/loaded 										= TRADER_THIS_TYPE,
							/obj/item/storage/box/bloodpacks									= TRADER_THIS_TYPE,
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Чего? Что-то болит? Обычно помогает меньше жить.",
		TRADER_HAIL_DENY          = "Умрите так что бы не беспокоить меня.",

		TRADER_TRADE_COMPLETE     = "Дело сделано.",
		TRADER_NO_MONEY           = "Не вижу денег. Вижу проблему, которой нужно найти деньги.",
		TRADER_NOT_ENOUGH         = "Не хватает, мил человек.",
		TRADER_FOUND_UNWANTED     = "Эту дребедень можешь себе оставить.",
		TRADER_HOW_MUCH           = "VALUE кредитов. Берёшь?",
		TRADER_WHAT_WANT          = "Ничего не хочу. Честно. Вот прям ничего... Даже никаких частей тела и внутренних органов НЕ хочу.",

		TRADER_COMPLEMENT_FAILURE = "Лесть не принимается в качестве оплаты.",
		TRADER_COMPLEMENT_SUCCESS = "Спасибо за комплимент, отправлю тебе что-то не просроченное в следующий раз.",
		TRADER_INSULT_GOOD        = "Моя клятва Гиппократа истекла вместе с лицензией",
		TRADER_INSULT_BAD         = "Да иди ты, смотри как бы топором не огрёб.",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/regular/MonsLadenMedbay/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/regular/MonsLadenMedbay/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/regular/MonsLadenMedbay/tick()
	return 1

/datum/trader/ship/regular/MonsLadenMine
	name = "Borisi Koldin"
	origin = "Обычный работяга"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 120

	possible_wanted_items = list(
							/obj/item/ore														= TRADER_SUBTYPES_ONLY,
							)

	possible_trading_items = list(
							/obj/item/pickaxe 													= TRADER_SUBTYPES_ONLY,
							/obj/item/pickaxe/drill												= TRADER_SUBTYPES_ONLY,
							/obj/item/pickaxe/drill/adv											= TRADER_SUBTYPES_ONLY,
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Я так устал работать",
		TRADER_HAIL_DENY          = "Прощай.",

		TRADER_TRADE_COMPLETE     = "Маладца!",
		TRADER_NO_MONEY           = "Жаль что ты без денег. Как и я.",
		TRADER_NOT_ENOUGH         = "Мало денег у тебя.",
		TRADER_FOUND_UNWANTED     = "Оставь лучше для своих друзей",
		TRADER_HOW_MUCH           = "VALUE деньжат",
		TRADER_WHAT_WANT          = "Руду тащи, родной",

		TRADER_COMPLEMENT_FAILURE = "Оставь это для своей мамы",
		TRADER_COMPLEMENT_SUCCESS = "Спасибо, дружище!",
		TRADER_INSULT_GOOD        = "У нам много дерьма, но тебе отправим что-то хорошее.",
		TRADER_INSULT_BAD         = "Да иди ты, урод!",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/regular/MonsLadenMine/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/regular/MonsLadenMine/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/regular/MonsLadenMine/tick()
	return 1

/datum/trader/ship/regular/MonsLadenEngineer
	name = "Eric Finth"
	origin = "Инженер"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 120

	possible_wanted_items = list(
							/obj/item/stack/material											= TRADER_SUBTYPES_ONLY,
							)

	possible_trading_items = list(
							/obj/item/stock_parts/capacitor										= TRADER_THIS_TYPE,
							/obj/item/stock_parts/capacitor/adv									= TRADER_THIS_TYPE,
							/obj/item/stock_parts/capacitor/super 								= TRADER_THIS_TYPE,
							/obj/item/stock_parts/capacitor/rectangular							= TRADER_THIS_TYPE,

							/obj/item/stock_parts/manipulator									= TRADER_THIS_TYPE,
							/obj/item/stock_parts/manipulator/nano								= TRADER_THIS_TYPE,
							/obj/item/stock_parts/manipulator/pico								= TRADER_THIS_TYPE,
							/obj/item/stock_parts/manipulator/femto								= TRADER_THIS_TYPE,

							/obj/item/stock_parts/micro_laser									= TRADER_THIS_TYPE,
							/obj/item/stock_parts/micro_laser/high								= TRADER_THIS_TYPE,
							/obj/item/stock_parts/micro_laser/ultra								= TRADER_THIS_TYPE,

							/obj/item/stock_parts/matter_bin									= TRADER_THIS_TYPE,
							/obj/item/stock_parts/matter_bin/adv								= TRADER_THIS_TYPE,
							/obj/item/stock_parts/matter_bin/super								= TRADER_THIS_TYPE,
							)

	blacklisted_trade_items = null

	speech = list(
		TRADER_HAIL_GENERIC       = "Чего покупаешь?",
		TRADER_HAIL_DENY          = "Пока!",

		TRADER_TRADE_COMPLETE     = "Опа. Вот и всё",
		TRADER_NO_MONEY           = "Денег нет - товара нет",
		TRADER_NOT_ENOUGH         = "Мало денег у тебя.",
		TRADER_FOUND_UNWANTED     = "Оставь лучше для своих друзей",
		TRADER_HOW_MUCH           = "VALUE твоих денег. Бери скорее!",
		TRADER_WHAT_WANT          = "Ну всякое покупаю. Доски там, железные листы, стекло... Может ещё чё.",

		TRADER_COMPLEMENT_FAILURE = "Комплименты оставь себе",
		TRADER_COMPLEMENT_SUCCESS = "Спасибо за комплимент, мой друг.",
		TRADER_INSULT_GOOD        = "У нас много ржавых железяк, но тебе отправим новые",
		TRADER_INSULT_BAD         = "Да пошёл ты!",
	)

	mob_transfer_message = "<span class='danger'>You are transported to ORIGIN, and with a sickening thud, you fall unconscious, never to wake again.</span>"

/datum/trader/ship/regular/MonsLadenEngineer/what_do_you_want()
	return make_response(TRADER_WHAT_WANT)

/datum/trader/ship/regularMonsLadenEngineer/New()
	..()
	wanted_items = possible_wanted_items
	trading_items = possible_trading_items

/datum/trader/ship/regular/MonsLadenEngineer/tick()
	return 1

/////// А тут уже контрабандрые, стоит проб 25 на их выпадение.
/datum/trader/ship/contraband/MonsLadenContraband
	name = "Joe Hard"
	origin = "Some suspicious trader"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	typical_duration = 10

	possible_wanted_items = list(
							/obj/item/organ/internal                = TRADER_ALL,
							/obj/item/organ/external                = TRADER_ALL,
							/obj/item/gun/projectile/automatic      = TRADER_ALL,
							/obj/item/gun/projectile/bolt_action    = TRADER_ALL,
							/obj/item/gun/projectile/revolver       = TRADER_ALL,
							/obj/item/gun/projectile/pistol         = TRADER_ALL,
							/obj/item/gun/energy                    = TRADER_ALL,
							/obj/item/clothing/accessory/armorplate = TRADER_ALL,
							/obj/item/clothing/accessory/legguards  = TRADER_ALL,
							/obj/item/clothing/suit/armor           = TRADER_ALL
							)

	possible_trading_items = list(
							/obj/item/storage/toolbox/syndicate									= TRADER_THIS_TYPE,
							/obj/item/gun/projectile/automatic/as75 							= TRADER_THIS_TYPE,
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
		TRADER_HAIL_GENERIC       = "Чего тебе? По делу говори.",
		TRADER_HAIL_DENY          = "Ладно, похуй.",

		TRADER_TRADE_COMPLETE     = "Заебись, удачно вышло.",
		TRADER_NO_MONEY           = "Ты думаешь, я из благотворительности в этой сырости сижу? Иди найди денег.",
		TRADER_NOT_ENOUGH         = "На эту сумму я только пыль из фильтра могу тебе продать. И то с натяжкой.",
		TRADER_FOUND_UNWANTED     = "Это лучшее что ты смог притащить?",
		TRADER_HOW_MUCH           = "VALUE, всего-то. Решай быстрее!",
		TRADER_WHAT_WANT          = "Ищу необычные... комплектующие. Оружие, броня, органы — всё, что делает жизнь короче или, наоборот, продлевает её неестественным путём.",

		TRADER_COMPLEMENT_FAILURE = "Да пошёл ты. Оставь лесть при себе",
		TRADER_COMPLEMENT_SUCCESS = "Хех. Редко кто замечает. Обычно все смотрят сквозь меня, как сквозь породу. Ценю.",
		TRADER_INSULT_GOOD        = "Уважил. Теперь давай по делу.",
		TRADER_INSULT_BAD         = "Знаешь, ведь рано или поздно тебе улетать со станции. Как бы не случилось чего...",
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

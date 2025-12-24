#define UNIQUE_TRADER_PROB 25

SUBSYSTEM_DEF(trade)
	name = "Trade"
	wait = 1 MINUTE
	priority = SS_PRIORITY_TRADE
	//Initializes at default time

	var/list/traders = list()
	var/tmp/list/current_traders

/datum/controller/subsystem/trade/Initialize()
	. = ..()
	for(var/i in 1 to rand(1,3))
		generate_trader()
	add_trader_if_missing(/datum/trader/ship/MonsLadenCargo)

/datum/controller/subsystem/trade/fire(resumed = FALSE)
	if (!resumed)
		current_traders = traders.Copy()

	while(current_traders.len)
		var/datum/trader/T = current_traders[current_traders.len]
		current_traders.len--

		if(!T.tick())
			traders -= T
			qdel(T)
		if (MC_TICK_CHECK)
			return

	if(prob(100-traders.len*10))
		generate_trader()

/datum/controller/subsystem/trade/stat_entry()
	..("Traders: [traders.len]")

/datum/controller/subsystem/trade/proc/add_trader_if_missing(type)
	for(var/datum/trader/T in traders)
		if(istype(T, type))
			return
	traders += new type

/datum/controller/subsystem/trade/proc/generate_trader()
	var/list/possible = list()
	if(prob(UNIQUE_TRADER_PROB))
		possible += subtypesof(/datum/trader/ship/contraband)
	else
		possible += /datum/trader/ship/MonsLadenCargo

	// Фильтруем базовый тип /datum/trader/, который не должен появляться
	possible -= /datum/trader

	if(length(possible))
		for(var/i in 1 to 10)
			var/type = pick(possible)
			// Дополнительная проверка на базовый тип
			if(type == /datum/trader)
				continue
			var/bad = 0
			for(var/trader in traders)
				if(istype(trader, type))
					bad = 1
					break
			if(bad)
				continue
			traders += new type
			return
#undef UNIQUE_TRADER_PROB

/datum/space_level/fortuna_1
	path = 'fortuna-1.dmm'
	traits = list(
		ZTRAIT_STATION,
		ZTRAIT_CONTACT
	)
	travel_chance = 5
	exterior_atmosphere = list("oxygen" = 1.05 * MOLES_O2STANDARD, "nitrogen" = 1.05 * MOLES_N2STANDARD, "carbon_dioxide" = MOLES_CELLSTANDARD * 0.1)
	exterior_atmos_temp = -35 CELSIUS

/datum/space_level/fortuna_1/generate(z)
	new /datum/random_map/automata/cave_system/air(null, 1, 1, z, 256, 256)
	// Create the mining ore distribution map.
	new /datum/random_map/noise/ore(null, 1, 1, z, 256, 256)

/datum/space_level/fortuna_2
	path = 'fortuna-2.dmm'
	traits = list(
		ZTRAIT_STATION,
		ZTRAIT_CONTACT
	)
	travel_chance = 5
	exterior_atmosphere = list("oxygen" = MOLES_O2STANDARD, "nitrogen" = MOLES_N2STANDARD)
	exterior_atmos_temp = -40 CELSIUS

/datum/space_level/fortuna_3
	path = 'fortuna-3.dmm'
	traits = list(
		ZTRAIT_STATION,
		ZTRAIT_CONTACT
	)
	travel_chance = 5
	exterior_atmosphere = list("carbon_dioxide" = MOLES_CELLSTANDARD, "nitrogen" = MOLES_N2STANDARD)
	exterior_atmos_temp = -80 CELSIUS

/datum/space_level/fortuna_4
	path = 'fortuna-4.dmm'
	traits = list(
		ZTRAIT_CENTCOM,
		ZTRAIT_CONTACT,
		ZTRAIT_SEALED
	)

	travel_chance = 5

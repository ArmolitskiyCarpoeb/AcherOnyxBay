/datum/configuration_section/preload
	name = "preload"

	var/state

/datum/configuration_section/preload/load_data(list/data)
	CONFIG_LOAD_NUM(state, data["state"])

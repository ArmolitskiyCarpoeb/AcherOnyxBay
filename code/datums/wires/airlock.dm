// Wires for airlocks

/datum/wires/airlock/secure
	random = 1
	wire_count = 14
	window_y = 680

/datum/wires/airlock
	holder_type = /obj/machinery/door/airlock
	wire_count = 12
	window_y = 570
	var/list/current_user_wires = null
	var/mob/current_user = null

var/const/AIRLOCK_WIRE_IDSCAN = 1
var/const/AIRLOCK_WIRE_MAIN_POWER1 = 2
var/const/AIRLOCK_WIRE_MAIN_POWER2 = 4
var/const/AIRLOCK_WIRE_DOOR_BOLTS = 8
var/const/AIRLOCK_WIRE_BACKUP_POWER1 = 16
var/const/AIRLOCK_WIRE_BACKUP_POWER2 = 32
var/const/AIRLOCK_WIRE_OPEN_DOOR = 64
var/const/AIRLOCK_WIRE_AI_CONTROL = 128
var/const/AIRLOCK_WIRE_ELECTRIFY = 256
var/const/AIRLOCK_WIRE_SAFETY = 512
var/const/AIRLOCK_WIRE_SPEED = 1024
var/const/AIRLOCK_WIRE_LIGHT = 2048

/datum/wires/airlock/CanUse(mob/living/L)
	var/obj/machinery/door/airlock/A = holder
	if(!istype(L, /mob/living/silicon))
		if(A.isElectrified())
			if(A.shock(L, 100))
				return 0
	if(A.p_open)
		return 1
	return 0

/datum/wires/airlock/proc/GetWireDescription(index)
	switch(index)
		if(AIRLOCK_WIRE_IDSCAN) return "ID Scanner"
		if(AIRLOCK_WIRE_MAIN_POWER1) return "Main Power (1)"
		if(AIRLOCK_WIRE_MAIN_POWER2) return "Main Power (2)"
		if(AIRLOCK_WIRE_DOOR_BOLTS) return "Door Bolts"
		if(AIRLOCK_WIRE_BACKUP_POWER1) return "Backup Power (1)"
		if(AIRLOCK_WIRE_BACKUP_POWER2) return "Backup Power (2)"
		if(AIRLOCK_WIRE_OPEN_DOOR) return "Door Open"
		if(AIRLOCK_WIRE_AI_CONTROL) return "AI Control"
		if(AIRLOCK_WIRE_ELECTRIFY) return "Electrify"
		if(AIRLOCK_WIRE_SAFETY) return "Safety"
		if(AIRLOCK_WIRE_SPEED) return "Speed"
		if(AIRLOCK_WIRE_LIGHT) return "Light"
	return null

/datum/wires/airlock/proc/GenerateUserWires()
	var/list/user_wires = list()
	var/list/colours_to_pick = wireColours.Copy()
	var/list/indexes_to_pick = list()
	for(var/i = 1; i < (1 << wire_count); i += i)
		indexes_to_pick += i
	colours_to_pick.len = wire_count
	while(colours_to_pick.len && indexes_to_pick.len)
		var/colour = pick_n_take(colours_to_pick)
		var/index = pick_n_take(indexes_to_pick)
		user_wires[colour] = index
	return user_wires

/datum/wires/airlock/proc/GetUserWireMapping(mob/user)
	if(!user || !isliving(user))
		return wires
	var/mob/living/L = user
	if(L.skills && L.skills["engineering"] >= 25)
		return wires
	if(!current_user_wires || current_user != L)
		current_user_wires = GenerateUserWires()
		current_user = L
	return current_user_wires

/datum/wires/airlock/Interact(mob/living/user)
	if(!user)
		return
	var/html = null
	if(holder && CanUse(user))
		html = GetInteractWindow(user)
	if(html)
		user.set_machine(holder)
	else
		user.unset_machine()
		close_browser(user, "window=wires")
		return

	var/datum/browser/popup = new(user, "wires", holder.name, window_x, window_y)
	popup.set_content(html)
	popup.set_title_image(user.browse_rsc_icon(holder.icon, holder.icon_state))
	popup.open()

/datum/wires/airlock/GetInteractWindow(mob/user)
	var/obj/machinery/door/airlock/A = holder
	var/haspower = A.arePowerSystemsOn()

	var/list/display_wires = GetUserWireMapping(user)

	var/html = "<div class='block'>"
	html += "<h3>Exposed Wires</h3>"
	html += "<table[table_options]>"

	for(var/colour in display_wires)
		var/actual_index = display_wires[colour]
		var/is_cut = IsIndexCut(actual_index)
		html += "<tr>"
		html += "<td[row_options1]><font color='[colour]'>&#9724;</font>[capitalize(colour)]</td>"
		html += "<td[row_options2]>"
		html += "<A href='?src=\ref[src];action=1;cut=[colour]'>[is_cut ? "Mend" :  "Cut"]</A>"
		html += " <A href='?src=\ref[src];action=1;pulse=[colour]'>Pulse</A>"
		html += " <A href='?src=\ref[src];action=1;attach=[colour]'>[IsAttached(colour) ? "Detach" : "Attach"] Signaller</A></td></tr>"
	html += "</table>"
	html += "</div>"

	if(user && isliving(user))
		var/mob/living/L = user
		if(L.skills && L.skills["engineering"] >= 45)
			html += "<br><b>Wire Functions:</b><br>"
			html += "<table>"
			for(var/colour in display_wires)
				var/actual_index = display_wires[colour]
				var/desc = GetWireDescription(actual_index)
				if(desc)
					html += "<tr><td><font color='[colour]'>&#9724;</font>[capitalize(colour)]</td><td> - </td><td>[desc]</td></tr>"
			html += "</table>"

	if (random)
		html += "<i>\The [holder] appears to have tamper-resistant electronics installed.</i><br><br>"

	// Индикаторы состояния двери
	html += text("<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]",
	(A.locked ? "The door bolts have fallen!" : "The door bolts look up."),
	((A.lights && haspower) ? "The door bolt lights are on." : "The door bolt lights are off!"),
	((haspower) ? "The test light is on." : "The test light is off!"),
	((A.backup_power_lost_until) ? "The backup power light is off!" : "The backup power light is on."),
	((A.aiControlDisabled==0 && !A.emagged && haspower)? "The 'AI control allowed' light is on." : "The 'AI control allowed' light is off."),
	((A.safe==0 && haspower)? "The 'Check Wiring' light is on." : "The 'Check Wiring' light is off."),
	((A.normalspeed==0 && haspower)? "The 'Check Timing Mechanism' light is on." : "The 'Check Timing Mechanism' light is off."),
	((A.aiDisabledIdScanner==0 && haspower)? "The IDScan light is on." : "The IDScan light is off."))

	return html

/datum/wires/airlock/UpdateCut(index, mended)

	var/obj/machinery/door/airlock/A = holder
	switch(index)
		if(AIRLOCK_WIRE_IDSCAN)
			A.aiDisabledIdScanner = !mended
		if(AIRLOCK_WIRE_MAIN_POWER1, AIRLOCK_WIRE_MAIN_POWER2)

			if(!mended)
				//Cutting either one disables the main door power, but unless backup power is also cut, the backup power re-powers the door in 10 seconds. While unpowered, the door may be crowbarred open, but bolts-raising will not work. Cutting these wires may electocute the user.
				A.loseMainPower()
				A.shock(usr, 50)
			else
				A.regainMainPower()
				A.shock(usr, 50)

		if(AIRLOCK_WIRE_BACKUP_POWER1, AIRLOCK_WIRE_BACKUP_POWER2)

			if(!mended)
				//Cutting either one disables the backup door power (allowing it to be crowbarred open, but disabling bolts-raising), but may electocute the user.
				A.loseBackupPower()
				A.shock(usr, 50)
			else
				A.regainBackupPower()
				A.shock(usr, 50)

		if(AIRLOCK_WIRE_DOOR_BOLTS)

			if(!mended)
				//Cutting this wire also drops the door bolts, and mending it does not raise them. (This is what happens now, except there are a lot more wires going to door bolts at present)
				A.lock(1)
				A.update_icon()

		if(AIRLOCK_WIRE_AI_CONTROL)

			if(!mended)
				if(A.aiControlDisabled == 0)
					A.aiControlDisabled = 1
				else if(A.aiControlDisabled == -1)
					A.aiControlDisabled = 2
			else
				if(A.aiControlDisabled == 1)
					A.aiControlDisabled = 0
				else if(A.aiControlDisabled == 2)
					A.aiControlDisabled = -1

		if(AIRLOCK_WIRE_ELECTRIFY)
			if(!mended)
				A.electrify(-1)
			else
				A.electrify(0)
			return // Don't update the dialog.

		if (AIRLOCK_WIRE_SAFETY)
			A.safe = mended

		if(AIRLOCK_WIRE_SPEED)
			A.autoclose = mended
			if(mended)
				if(!A.density)
					A.close()

		if(AIRLOCK_WIRE_LIGHT)
			A.lights = mended
			A.update_icon()


/datum/wires/airlock/UpdatePulsed(index)

	var/obj/machinery/door/airlock/A = holder
	switch(index)
		if(AIRLOCK_WIRE_IDSCAN)
			if(A.arePowerSystemsOn() && A.density)
				A.do_animate("deny")
		if(AIRLOCK_WIRE_MAIN_POWER1, AIRLOCK_WIRE_MAIN_POWER2)
			A.loseMainPower()
		if(AIRLOCK_WIRE_DOOR_BOLTS)
			if(!A.locked)
				A.lock()
			else
				A.unlock()

		if(AIRLOCK_WIRE_BACKUP_POWER1, AIRLOCK_WIRE_BACKUP_POWER2)
			A.loseBackupPower()
		if(AIRLOCK_WIRE_AI_CONTROL)
			if(A.aiControlDisabled == 0)
				A.aiControlDisabled = 1
			else if(A.aiControlDisabled == -1)
				A.aiControlDisabled = 2

			spawn(10)
				if(A)
					if(A.aiControlDisabled == 1)
						A.aiControlDisabled = 0
					else if(A.aiControlDisabled == 2)
						A.aiControlDisabled = -1

		if(AIRLOCK_WIRE_ELECTRIFY)
			A.electrify(30)
		if(AIRLOCK_WIRE_OPEN_DOOR)
			if(A.emagged)	return
			if(!A.requiresID() || A.check_access(null))
				if(A.density)	A.open()
				else			A.close()
		if(AIRLOCK_WIRE_SAFETY)
			A.safe = !A.safe
			if(!A.density)
				A.close()

		if(AIRLOCK_WIRE_SPEED)
			A.normalspeed = !A.normalspeed

		if(AIRLOCK_WIRE_LIGHT)
			A.lights = !A.lights
			A.update_icon()

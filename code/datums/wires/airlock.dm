// Wires for airlocks

/datum/wires/airlock/secure
	random = 1
	wire_count = 14
	window_y = 680

/datum/wires/airlock
	holder_type = /obj/machinery/door/airlock
	wire_count = 12
	window_y = 570
	// Temporary wire mapping for current low-skill user interaction
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

/datum/wires/airlock/GetInteractWindow(mob/user)
	var/obj/machinery/door/airlock/A = holder
	var/haspower = A.arePowerSystemsOn() //If there's no power, then no lights will be on.

	// Get user-specific wire mapping if they have low engineering skill
	var/list/display_wires = wires
	if(user && isliving(user))
		var/mob/living/L = user
		if(L.skills && !L.skillcheck(L.skills["engineering"], 25, null, "engineering") && !L.newstatcheck(L.stats[STAT_IQ], 9, null, STAT_IQ)) // Low engineering skill threshold
			// Regenerate wires for low-skill users (randomizes each time they view)
			current_user_wires = GenerateUserWires()
			current_user = L
			display_wires = current_user_wires

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

	html += text("<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]<br>\n[]",
	(A.locked ? "The door bolts have fallen!" : "The door bolts look up."),
	((A.lights && haspower) ? "The door bolt lights are on." : "The door bolt lights are off!"),
	((haspower) ? "The test light is on." : "The test light is off!"),
	((A.backup_power_lost_until) ? "The backup power light is off!" : "The backup power light is on."),
	((A.aiControlDisabled==0 && !A.emagged && haspower)? "The 'AI control allowed' light is on." : "The 'AI control allowed' light is off."),
	((A.safe==0 && haspower)? "The 'Check Wiring' light is on." : "The 'Check Wiring' light is off."),
	((A.normalspeed==0 && haspower)? "The 'Check Timing Mechanism' light is on." : "The 'Check Timing Mechanism' light is off."),
	((A.aiDisabledIdScanner==0 && haspower)? "The IDScan light is on." : "The IDScan light is off."))

	if (random)
		html += "<i>\The [holder] appears to have tamper-resistant electronics installed.</i><br><br>"

	return html

/datum/wires/airlock/proc/GenerateUserWires()
	// Generate a randomized wire mapping for this user
	var/list/user_wires = list()
	var/list/colours_to_pick = wireColours.Copy()
	var/list/indexes_to_pick = list()

	// Generate our indexes (same as base wires)
	for(var/i = 1; i < (1 << wire_count); i += i)
		indexes_to_pick += i

	colours_to_pick.len = wire_count

	// Shuffle the mapping
	while(colours_to_pick.len && indexes_to_pick.len)
		var/colour = pick_n_take(colours_to_pick)
		var/index = pick_n_take(indexes_to_pick)
		user_wires[colour] = index

	return user_wires

/datum/wires/airlock/proc/GetUserWireMapping(mob/user)
	// Get the user's wire mapping, or return base wires if they have high skill
	if(!user || !isliving(user))
		return wires

	var/mob/living/L = user
	if(L.skills && L.skills["engineering"] >= 30)
		return wires // High skill users see real wires

	// Low skill users: if this is the same user and we have a current mapping, use it
	// Otherwise generate new randomized wires (happens on each cut/pulse action)
	if(current_user == L && current_user_wires)
		var/list/mapping = current_user_wires
		// Regenerate for next time
		current_user_wires = GenerateUserWires()
		return mapping

	// Generate new randomized wires
	current_user_wires = GenerateUserWires()
	current_user = L
	return current_user_wires

/datum/wires/airlock/CutWireColour(colour, mob/user)
	// Translate user's color to actual wire index
	var/list/user_wires = GetUserWireMapping(user)
	var/actual_index = user_wires[colour]
	if(!actual_index)
		// Fallback to base wires if color not found
		actual_index = GetIndex(colour)
	CutWireIndex(actual_index)

/datum/wires/airlock/PulseColour(colour, mob/user)
	// Translate user's color to actual wire index
	var/list/user_wires = GetUserWireMapping(user)
	var/actual_index = user_wires[colour]
	if(!actual_index)
		// Fallback to base wires if color not found
		actual_index = GetIndex(colour)
	PulseIndex(actual_index)

/datum/wires/airlock/Topic(href, href_list)
	..()
	if(in_range(holder, usr) && isliving(usr))
		var/mob/living/L = usr
		if(CanUse(L) && href_list["action"])
			var/obj/item/I = L.get_active_hand()
			holder.add_hiddenprint(L)
			if(href_list["cut"]) // Toggles the cut/mend status
				if(isWirecutter(I))
					var/colour = href_list["cut"]
					CutWireColour(colour, L)
				else
					to_chat(L, "<span class='error'>You need wirecutters!</span>")
			else if(href_list["pulse"])
				if(isMultitool(I))
					var/colour = href_list["pulse"]
					PulseColour(colour, L)
				else
					to_chat(L, "<span class='error'>You need a multitool!</span>")
			else if(href_list["attach"])
				var/colour = href_list["attach"]
				// Detach
				if(IsAttached(colour))
					var/obj/item/O = Detach(colour)
					if(O)
						L.pick_or_drop(O)
				// Attach
				else
					if(istype(I, /obj/item/device/assembly/signaler) && L.drop(I))
						Attach(colour, I)
					else
						to_chat(L, "<span class='error'>You need a remote signaller!</span>")

		// Update Window
		Interact(usr)

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
				//one wire for AI control. Cutting this prevents the AI from controlling the door unless it has hacked the door through the power connection (which takes about a minute). If both main and backup power are cut, as well as this wire, then the AI cannot operate or hack the door at all.
				//aiControlDisabled: If 1, AI control is disabled until the AI hacks back in and disables the lock. If 2, the AI has bypassed the lock. If -1, the control is enabled but the AI had bypassed it earlier, so if it is disabled again the AI would have no trouble getting back in.
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
				//Cutting this wire electrifies the door, so that the next person to touch the door without insulated gloves gets electrocuted.
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
			//Sending a pulse through flashes the red light on the door (if the door has power).
			if(A.arePowerSystemsOn() && A.density)
				A.do_animate("deny")
		if(AIRLOCK_WIRE_MAIN_POWER1, AIRLOCK_WIRE_MAIN_POWER2)
			//Sending a pulse through either one causes a breaker to trip, disabling the door for 10 seconds if backup power is connected, or 1 minute if not (or until backup power comes back on, whichever is shorter).
			A.loseMainPower()
		if(AIRLOCK_WIRE_DOOR_BOLTS)
			//one wire for door bolts. Sending a pulse through this drops door bolts if they're not down (whether power's on or not),
			//raises them if they are down (only if power's on)
			if(!A.locked)
				A.lock()
			else
				A.unlock()

		if(AIRLOCK_WIRE_BACKUP_POWER1, AIRLOCK_WIRE_BACKUP_POWER2)
			//two wires for backup power. Sending a pulse through either one causes a breaker to trip, but this does not disable it unless main power is down too (in which case it is disabled for 1 minute or however long it takes main power to come back, whichever is shorter).
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
			//one wire for electrifying the door. Sending a pulse through this electrifies the door for 30 seconds.
			A.electrify(30)
		if(AIRLOCK_WIRE_OPEN_DOOR)
			//tries to open the door without ID
			//will succeed only if the ID wire is cut or the door requires no access and it's not emagged
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

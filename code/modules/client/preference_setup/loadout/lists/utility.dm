// "Useful" items - I'm guessing things that might be used at work?
/datum/gear/utility
	sort_category = "Utility"

/datum/gear/utility/briefcase
	display_name = "briefcase"
	path = /obj/item/storage/briefcase

/datum/gear/utility/clipboard
	display_name = "clipboard"
	path = /obj/item/clipboard

/datum/gear/utility/folder
	display_name = "folders"
	path = /obj/item/folder

/datum/gear/utility/taperecorder
	display_name = "tape recorder"
	path = /obj/item/device/taperecorder

/datum/gear/utility/folder/New()
	..()
	var/folders = list()
	folders["blue folder"] = /obj/item/folder/blue
	folders["grey folder"] = /obj/item/folder
	folders["red folder"] = /obj/item/folder/red
	folders["white folder"] = /obj/item/folder/white
	folders["yellow folder"] = /obj/item/folder/yellow
	gear_tweaks += new /datum/gear_tweak/path(folders)

/datum/gear/utility/camera
	display_name = "camera"
	path = /obj/item/device/camera

/datum/gear/utility/music_tape_custom
	display_name = "music tape (custom)"
	description = {"
		A dusty tape, which can hold anything. Only what you need is blow the dust away and you will be able to play it again.
		<br><br>
		<b>Be careful!</b> Don't use it to play music/sounds which can be annoying for other players. Admins can erase your music if they consider it unacceptable or even ban you for abusing it.
	"}
	path = /obj/item/music_tape/custom
	cost = 3

/datum/gear/utility/boombox
	display_name = "boombox"
	description = {"
		A musical audio player station, also known as boombox or ghettobox. Very robust.
		<br><br>
		<b>Be careful!</b> Don't use it to play music/sounds which can be annoying for other players. Admins can delete your boombox if they consider your music unacceptable or even ban you for abusing it.
	"}
	path = /obj/item/music_player/boombox
	flags = GEAR_HAS_COLOR_SELECTION
	cost = 3

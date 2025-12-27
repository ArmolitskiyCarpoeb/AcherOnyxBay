// Pre-made cassetes
/obj/item/music_tape/title2
	name = "tape - \"Title 2\""
	track = new /datum/track("Title 2", 'sound/music/classic/title2.ogg')

/obj/item/music_tape/clouds
	name = "tape - \"Clouds\""
	track = new /datum/track("Clouds of Fire", 'sound/music/classic/clouds.s3m')

/obj/item/music_tape/syndie
	name = "Unsuspicious Music Tape"
	track = new /datum/track("Space Asshole", 'sound/music/space_asshole.ogg')

/obj/item/music_tape/random/aprovedmusic1  //Надо треков по ~10 добавить. Рандомно от 4 до 6 выбирается
	name = "Одобренные треки 1"
	desc = "Церковь одобрила эти треки. Да познает душа слушающих радость"
	tracklist = list(
		"Hishmaliin"					= 'sound/music/aprovedmusic1/Dvar_-_Hishmaliin.ogg',
		"Swallowed_Burning_Coals"		= 'sound/music/aprovedmusic1/EI_Tigr3_-_She_Swallowed_Burning_Coals.ogg',
		"Hot Plates"					= 'sound/music/aprovedmusic1/Judge Bitch — Hot Plates.ogg',
		"Unreleased Track"				= 'sound/music/aprovedmusic1/Squarepusher & Aphex Twin — Unreleased Track.ogg',
		"I Was Made For Lovin You"		= 'sound/music/aprovedmusic1/Kiss - I Was Made For Lovin You.ogg'
	)

/obj/item/music_tape/random/aprovedmusic2
	name = "Одобренные треки 2"
	desc = "Церковь одобрила эти треки. Да познает душа слушающих счастье"
	tracklist = list(
		"Army of the Night"				= 'sound/music/aprovedmusic2/Powerwolf - Army of the Night.ogg',
		"Take Me Down Below"			= 'sound/music/aprovedmusic2/Kiss - Take Me Down Below.ogg',
		"Main Theme"					= 'sound/music/aprovedmusic2/Max Payne - Main Theme.ogg',
		"Dragula"						= 'sound/music/aprovedmusic2/Rob Zombie - Dragula.ogg'
	)

/obj/item/music_tape/random/nonaprovedmusic
	name = "Не одобренные треки"
	tracklist = list(
		"At Doom's Gate"				= 'sound/music/nonaprovedmusic/At Doom Gate.ogg',
		"Hallo Spaceboy"				= 'sound/music/nonaprovedmusic/David Bowie - Hallo Spaceboy.ogg',
		"Decadence"						= 'sound/music/nonaprovedmusic/Disturbed - Decadence.ogg',
		"Hard Bass"						= 'sound/music/nonaprovedmusic/Hard Bass School.ogg',
		"Smells_Blood"					= 'sound/music/nonaprovedmusic/Kensuke_Ushio_-_Smells_Blood.ogg',
		"Nas ne dogonyat"				= 'sound/music/nonaprovedmusic/t.A.T.u․ - Нас не догонят.ogg',
		"Ich hasse Kinder"				= 'sound/music/nonaprovedmusic/Till Lindemann - Ich hasse Kinder.ogg',
		"Vse po plany"					= 'sound/music/nonaprovedmusic/Егор Летов - Всё идёт по плану.ogg',
		"Ispoved vampira"				= 'sound/music/nonaprovedmusic/Король и Шут - Исповедь вампира.ogg',
		"Mertviy anarhist"				= 'sound/music/nonaprovedmusic/Король и Шут - Мёртвый анархист.ogg',
		"Pohorony panka"				= 'sound/music/nonaprovedmusic/Король и Шут - Похороны панка.ogg',
		"Huarit tak chto ohyet"			= 'sound/music/nonaprovedmusic/ШЛЕМ - Хуярит так, что охуеть.ogg'
		// "   "							= 'sound/music/nonaprovedmusic/  .ogg',
		// "   "							= 'sound/music/nonaprovedmusic/  .ogg',
		// "   "							= 'sound/music/nonaprovedmusic/  .ogg'
	)

/obj/item/music_tape/random/newyear
	name = "Christmas Music Tape"
	tracklist = list(
		"Last Christmas"                = 'sound/music/newyear/christmasamb2.ogg',
		"We Wish You a Merry Christmas" = 'sound/music/newyear/christmasamb3.ogg',
		"Jingle Bells"                  = 'sound/music/newyear/christmasamb4.ogg',
		"Happy New Year"                = 'sound/music/newyear/happynewyear.ogg',
		"Steklovata"                    = 'sound/music/newyear/steklovata_newyear.ogg',
		"Zima-Holoda"                   = 'sound/music/newyear/zima_holoda.ogg',
		"Zima"                          = 'sound/music/newyear/zima.ogg'
	)
/obj/item/music_tape/random/jazz
	name = "Jazzy Jazz Tape"
	tracklist = list(
		"Booty Swing"              		= 'sound/music/jazz/booty_swing.ogg',
		"Fire In The Brain"            	= 'sound/music/jazz/fire_in_the_brain.ogg',
		"Fly Me To The Moon"            = 'sound/music/jazz/fly_me_to_the_moon.ogg',
		"Lone Digger" 					= 'sound/music/jazz/lonedigger.ogg',
		"Rush"                			= 'sound/music/jazz/rush.ogg',
		"Mr. Sandman"            	    = 'sound/music/jazz/sandman.ogg',
		"The Only Thing"            	= 'sound/music/jazz/the_only_thing.ogg',
		"What A Wonderful World"        = 'sound/music/jazz/wonderful_world.ogg'
	)

/obj/item/music_tape/random/frontier
	name = "NSS Frontier Tape"
	tracklist = list(
		"Don`t Bother Me"				= 'sound/music/frontier/dont_bother_me.ogg',
		"It`s The End Of The World"     = 'sound/music/frontier/end_of_the_world.ogg',
		"Piano Bar I" 					= 'sound/music/frontier/piano_bar.ogg',
		"Resonance"              	    = 'sound/music/frontier/resonance.ogg',
		"Rust"    						= 'sound/music/frontier/rust.ogg',
		"Split"                  	 	= 'sound/music/frontier/split.ogg',
		"The Man Who Sold The World"    = 'sound/music/frontier/the_man_who_sold_the_world.ogg'
	)

/obj/item/music_tape/random/exodus
	name = "NSS Exodus Tape"
	tracklist = list(
		"Any Special Order?"     		= 'sound/music/exodus/any_special_order.ogg',
		"Bluespace"     				= 'sound/music/exodus/bluespace.ogg',
		"Buy Something Will Ya?"     	= 'sound/music/exodus/buy_something.ogg',
		"Earth Trax"             		= 'sound/music/exodus/earth_trax.ogg',
		"Final Countdown"               = 'sound/music/exodus/final_countdown.ogg',
		"Sunshine" 						= 'sound/music/exodus/sunshine.ogg',
		"The Tale Of a Cruel World"     = 'sound/music/exodus/tale_of_a_cruel_world.ogg',
		"The Other Room"    			= 'sound/music/exodus/the_other_room.ogg',
		"Whirling Cafeteria"            = 'sound/music/exodus/whirling_cafeteria.ogg'
	)
/obj/item/music_tape/random/classic
	name = "Classic Music Tape"
	tracklist = list(
		"Prey"                          = 'sound/music/classic/prey.ogg',
		"Clouds of Fire"                = 'sound/music/classic/clouds.s3m',
		"D`Bert"                        = 'sound/music/classic/title2.ogg',
		"D`Fort"                        = 'sound/ambient/song_game.ogg',
		"Floating"                      = 'sound/music/classic/main.ogg',
		"Endless Space"                 = 'sound/music/classic/space.ogg',
		"Part A"                        = 'sound/music/classic/TestLoop1.ogg',
		"Scratch"                       = 'sound/music/classic/title1.ogg',
		"Trai`Tor"                      = 'sound/music/classic/traitor.ogg',
		"All That I Can See"            = 'sound/music/classic/all_that_i_can_see.ogg',
		"Delirium"                      = 'sound/music/classic/delirium.ogg',
		"End"                           = 'sound/music/classic/end.ogg',
		"Magicfly"                      = 'sound/music/classic/magicfly.ogg',
		"Self Justified Sacrifices"     = 'sound/music/classic/self_justified_sacrifices.ogg',
		"Reaper `n Blues"              = 'sound/music/classic/reapernblues.ogg',
		"Undead Man Walkin`"            = 'sound/music/classic/undeadwalking.ogg',
		"Space Oddity"                  = 'sound/music/classic/space_oddity.ogg',
		"Crockett's Theme"              = 'sound/music/classic/crokett_39_s_theme.ogg'
	)

/obj/item/music_tape/random/valhalla
	name = "Cyber Bar Tape"
	tracklist = list(
		"A New Frontier"                          = 'sound/music/valhalla/a_new_frontier.ogg',
		"A Star Pierces The Darkness"             = 'sound/music/valhalla/a_star_pierces_the_darkness.ogg',
		"Base Of The Titans"                      = 'sound/music/valhalla/base_of_the_titans.ogg',
		"Follow The Trail"                        = 'sound/music/valhalla/follow_the_trail.ogg',
		"Good For Health, Bad For Education"      = 'sound/music/valhalla/good_for_health.ogg',
		"Heart Of The Sity"                       = 'sound/music/valhalla/heart_of_the_sity.ogg',
		"Meet The Staff"                          = 'sound/music/valhalla/meet_the_staff.ogg',
		"Skyline"                                 = 'sound/music/valhalla/skyline.ogg',
		"Snowfall"                                = 'sound/music/valhalla/snowfall.ogg',
		"Strictly Business"                       = 'sound/music/valhalla/strictly_business.ogg',
		"Underground Club"                        = 'sound/music/valhalla/underground_club.ogg',
		"Who Was I"                               = 'sound/music/valhalla/who_was_i.ogg',
		"You`ve Got Me"                           = 'sound/music/valhalla/youve_got_me.ogg',
	)

/obj/item/music_tape/random/halloween
	name = "Halloween Tape"
	// This literally suggested githubCopilot, so let that be
	tracklist = list(
		"Ghostbusters"                          = 'sound/music/halloween/ghostbusters.ogg',
		"Monster Mash"                          = 'sound/music/halloween/monster_mash.ogg',
		"Thriller"                              = 'sound/music/halloween/thriller.ogg',
		"Spooky Scary Skeletons"                = 'sound/music/halloween/spooky_scary_skeletons.ogg',
		"Zombie"                                = 'sound/music/halloween/zombie.ogg',
		"This Is Halloween"                     = 'sound/music/halloween/this_is_halloween.ogg',
		"Somebody`s Watching Me"                = 'sound/music/halloween/somebodys_watching_me.ogg',
		"Ghost Fight"                           = 'sound/music/halloween/ghost_fight.ogg'
	)

/obj/item/music_tape/random/retrojazz
	name = "Retro Jazz Tape"
	tracklist = list(
		"All For You"                         = 'sound/music/retrojazz/all_for_you.ogg',
		"Cold, Cold Heart"                    = 'sound/music/retrojazz/cold_cold_heart.ogg',
		"Hair of Gold, Eyes of Blue"          = 'sound/music/retrojazz/hair_of_gold_eyes_of_blue.ogg',
		"Hello! My Baby"                      = 'sound/music/retrojazz/hello_ma_baby.ogg',
		"I Can't Begin To Tell You"           = 'sound/music/retrojazz/i_cant_begin_to_tell_you.ogg',
		"I Don't Care If It Rains All Night"  = 'sound/music/retrojazz/i_dont_care_if_it_rains_all_night.ogg',
		"I Wanna Be Loved By You"             = 'sound/music/retrojazz/i_wanna_be_loved_by_you.ogg',
		"We'll Meet Again"                    = 'sound/music/retrojazz/well_meet_again.ogg'
	)

/obj/item/music_tape/custom
	name = "dusty tape"
	desc = "A dusty tape, which can hold anything. Only what you need is blow the dust away and you will be able to play it again."

/obj/item/music_tape/custom/attack_self(mob/user)
	if(!ruined && !track)
		if(setup_tape(user))
			log_and_message_admins("uploaded new sound <a href='?_src_=holder;listen_tape_sound=\ref[track.GetTrack()]'>(preview)</a> in <a href='?_src_=holder;adminplayerobservefollow=\ref[src]'>\the [src]</a> with track name \"[track.title]\". <A HREF='?_src_=holder;wipe_tape_data=\ref[src]'>Wipe</A> data.")
		return
	..()

/obj/item/music_tape/custom/proc/setup_tape(mob/user)
	var/new_sound = input(user, "Select sound to upload. You can use mp3, ogg and other audio formats which are supported by BYOND.", "Song Reminiscence: File") as null|sound
	if(isnull(new_sound))
		return FALSE

	var/new_name = input(user, "Name \the [src]:", "Song Reminiscence: Name", "Untitled") as null|text
	if(isnull(new_name))
		return FALSE

	new_name = sanitizeSafe(new_name)

	SetName("tape - \"[new_name]\"")

	if(new_sound && new_name && !track)
		track = new /datum/track(new_name, new_sound)
		uploader_ckey = user.ckey
		return TRUE
	return FALSE

/obj/item/music_tape/custom/ruin()
	QDEL_NULL(track)
	..()

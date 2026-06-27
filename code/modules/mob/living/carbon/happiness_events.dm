/datum/happiness_event
	var/description
	var/happiness = 0
	var/timeout = 0
	var/group = null

///For descriptions, use the span classes bold info, info, none, warning and boldwarning in order from great to horrible.

//SEX

/datum/happiness_event/cum
	description = "<span class='info'>Я кончил!</span>\n"
	happiness = 15
	timeout = 15 MINUTES

/datum/happiness_event/raped
	description = "<span class='danger'>Меня изнасиловали.</span>\n"
	happiness = -15
	timeout = 15 MINUTES

//SLEEP

/datum/happiness_event/sleep/sleeped
	description = "<span class='info'>Поспал!</span>\n"
	happiness = 5
	timeout = 600
	group = "sleep"

/datum/happiness_event/sleep/cryo
	description = "<span class='danger'>Было не очень приятно находиться в металлическом гробу так долго.</span>\n"
	happiness = -5
	timeout = 600
	group = "sleep"

//thirst
/datum/happiness_event/thirst/filled
	description = "<span class='info'>Напился воды!</span>\n"
	happiness = 10
	group = "thirst"

/datum/happiness_event/thirst/watered
	description = "<span class='info'>Недавно попил.</span>\n"
	happiness = 5
	group = "thirst"

/datum/happiness_event/thirst/thirsting
	description = "<span class='danger'>Не отказался бы от воды.</span>\n"
	happiness = -1
	group = "thirst"

/datum/happiness_event/thirst/thirsty
	description = "<span class='danger'>Хочется попить...</span>\n"
	happiness = -3
	group = "thirst"

/datum/happiness_event/thirst/verythirsty
	description = "<span class='danger'>Как же хочется пить!</span>\n"
	happiness = -5
	group = "thirst"

/datum/happiness_event/thirst/dehydrated
	description = "<span class='danger'>ВОДЫ!!! ВОДЫ!!!</span>\n"
	happiness = -20
	group = "thirst"

//nutrition
/datum/happiness_event/nutrition/fat
	description = "<span class='danger'><B>Я жирный...</B></span>\n" //muh fatshaming
	happiness = -4

/datum/happiness_event/nutrition/wellfed
	description = "<span class='info'>Как же я наелся!</span>\n"
	happiness = 10
	group = "nutrition"

/datum/happiness_event/nutrition/fed
	description = "<span class='info'>Недавно покушал.</span>\n"
	happiness = 5
	group = "nutrition"

/datum/happiness_event/nutrition/lilhungry
	description = "<span class='danger'>Перекус не повредит.</span>\n"
	happiness = -1
	group = "nutrition"

/datum/happiness_event/nutrition/hungry
	description = "<span class='danger'>Покушать бы...</span>\n"
	happiness = -3
	group = "nutrition"

/datum/happiness_event/nutrition/veryhungry
	description = "<span class='danger'>Как же хочется кушать!</span>\n"
	happiness = -5
	group = "nutrition"

/datum/happiness_event/nutrition/starving
	description = "<span class='danger'>ЖРАТЬ ХОЧУ!!!</span>\n"
	happiness = -20
	group = "nutrition"


//Hygiene
/datum/happiness_event/hygiene/clean
	description = "<span class='info'>I feel so clean!\n"
	happiness = 5

/datum/happiness_event/hygiene/smelly
	description = "<span class='danger'>I smell like shit.\n"
	happiness = -5

/datum/happiness_event/hygiene/vomitted
	description = "<span class='danger'>Ugh, I've vomitted.\n"
	happiness = -5
	timeout = 1800

/datum/happiness_event/hygiene/shower
	description = "<span class='info'>I had a nice hot shower!\n"
	happiness = 5
	timeout = 1800

/datum/happiness_event/disgust/nocutlery
	description = "<span class='danger'>Did I really have to eat without any utensils?\n"
	happiness = -5
	timeout = 1800

//Dirty
/datum/happiness_event/dirty/dirty_slight
	description = "<span class='danger'>Что-то тут грязновато.</span>\n"
	happiness = -1
	//timeout = 1800
	group = "dirty"

/datum/happiness_event/dirty/dirty_medium
	description = "<span class='danger'>Тут действительно нужно прибраться...</span>\n"
	happiness = -3
	//timeout = 1800
	group = "dirty"

/datum/happiness_event/dirty/dirty_heavy
	description = "<span class='danger'>ВЕЗДЕ МУСОР И ГРЯЗЬ!</span>\n"
	happiness = -7
	//timeout = 1800
	group = "dirty"

//Disgust
/datum/happiness_event/disgust/gross
	description = "<span class='danger'>That was gross.</span>\n"
	happiness = -2
	timeout = 1800
	group = "disgust"

/datum/happiness_event/disgust/verygross
	description = "<span class='danger'>I think I'm going to puke...</span>\n"
	happiness = -5
	timeout = 1800
	group = "disgust"

/datum/happiness_event/disgust/disgusted
	description = "<span class='danger'>Oh god that's disgusting...</span>\n"
	happiness = -10
	timeout = 1800
	group = "disgust"

//Generic events
/datum/happiness_event/favorite_food
	description = "<span class='info'>I really liked eating that.</span>\n"
	happiness = 5
	timeout = 2400

/datum/happiness_event/nice_shower
	description = "<span class='info'>I had a nice shower.</span>\n"
	happiness = 5
	timeout = 1800

/datum/happiness_event/handcuffed
	description = "<span class='danger'>I guess my antics finally caught up with me..</span>\n"
	happiness = -1

/datum/happiness_event/hot_food //Hot food feels good!
	description = "<span class='info'>I've eaten something warm.</span>\n"
	happiness = 5
	timeout = 1800

/datum/happiness_event/cold_drink //Cold drinks feel good!
	description = "<span class='info'>I've had something refreshing.</span>\n"
	happiness = 5
	timeout = 1800

//Embarassment
/datum/happiness_event/hygiene/shit
	description = "<span class='danger'>I shit myself. How embarassing.\n"
	happiness = -10
	timeout = 1800

/datum/happiness_event/hygiene/pee
	description = "<span class='danger'>I pissed myself. How embarassing.\n"
	happiness = -10
	timeout = 1800

//For when you get branded.
/datum/happiness_event/humiliated
	description = "<span class='danger'>I've been humiliated, and I am embarrassed.</span>\n"
	happiness = -10
	timeout = 1800

//And when you've seen someone branded
/datum/happiness_event/punished_heretic
	description = "<span class='info'>I've seen a punished heretic.</span>\n"
	happiness = 10
	timeout = 1800

//When you fulfill an AI request
/datum/happiness_event/request_fulfilled
	description = "<span class='info'>My god is pleased with me!</span>\n"
	happiness = 10
	timeout = 1800

//When you fulfill an AI request
/datum/happiness_event/request_failed
	description = "<span class='danger'>My god is disappointed with me!</span>\n"
	happiness = -20
	timeout = 1800

/datum/happiness_event/disturbing
	description = "<span class='danger'>I recently saw something disturbing.</span>\n"
	happiness = -10

/datum/happiness_event/clown
	description = "<span class='info'>Недавно видел смешного клоуна!</span>\n"
	happiness = 5

/datum/happiness_event/cloned_corpse
	description = "<span class='danger'>I recently saw my own corpse...</span>\n"
	happiness = -5

/datum/happiness_event/surgery
	description = "<span class='danger'>HE'S CUTTING ME OPEN!!</span>\n"
	happiness = -10

/datum/happiness_event/bleedingout
	description = "<span class='danger'>I feel that I am bleeding out...</span>\n"
	happiness = -5
	timeout = 1800
	group = "bleed"

/datum/happiness_event/bleedingouthard
	description = "<span class='danger'>I REALLY NEED TO STOP THIS BLEEDING!</span>\n"
	happiness = -15
	timeout = 1800
	group = "bleed"

/datum/happiness_event/verymildpain
	description = "<span class='danger'>Болит...</span>\n"
	happiness = -2
	timeout = 1800
	group = "pain"

/datum/happiness_event/mildpain
	description = "<span class='danger'>Очень... больно!</span>\n"
	happiness = -5
	timeout = 1800
	group = "pain"

/datum/happiness_event/pain
	description = "<span class='danger'>КАК ЖЕ БОЛЬНО!!!</span>\n"
	happiness = -12
	timeout = 1800
	group = "pain"

//For when you see someone die and you're not hardcore.
/datum/happiness_event/dead
	description = "<span class='danger'>О НАУКА, Я ВИДЕЛ СМЕРТЬ ЧЕЛОВЕКА!</span>\n"
	happiness = -10
	timeout = 10 MINUTES

/datum/happiness_event/overdose
	description = "<span class='danger'>I shouldn't have taken so much drugs!</span>\n"
	happiness = -10
	timeout = 1800

// Addiction Events

//OPIUM LOMKA

/datum/happiness_event/addiction/opium/withdrawal_small
	description = "<span class='danger'>Вмазаться хочу.</span>\n"
	happiness = -2
	timeout = FALSE
	group = "opium_addiction"

/datum/happiness_event/addiction/opium/withdrawal_medium
	description = "<span class='danger'>Грустненько без дозы!</span>\n"
	happiness = -7
	timeout = FALSE
	group = "opium_addiction"

/datum/happiness_event/addiction/opium/withdrawal_large
	description = "<span class='danger'>Как же хочется ДОЗУУУ!</span>\n"
	happiness = -10
	timeout = FALSE
	group = "opium_addiction"

/datum/happiness_event/addiction/opium/withdrawal_extreme
	description = "<span class='danger'>ЛОМКАЛОМКАЛОМКАЛОМКАЛОМКА!!!</span>\n"
	happiness = -15
	timeout = FALSE
	group = "opium_addiction"

// КУРИТЬ ОХОТА

/datum/happiness_event/addiction/cig/withdrawal_small
	description = "<span class='danger'>Не хватает сигаретки.</span>\n"
	happiness = -2
	timeout = FALSE
	group = "cig_addiction"

/datum/happiness_event/addiction/cig/withdrawal_medium
	description = "<span class='danger'>Почему я не курю!?</span>\n"
	happiness = -7
	timeout = FALSE
	group = "cig_addiction"

/datum/happiness_event/addiction/cig/withdrawal_large
	description = "<span class='danger'>Курить ХОЧУ!!!</span>\n"
	happiness = -10
	timeout = FALSE
	group = "cig_addiction"

/datum/happiness_event/addiction/cig/withdrawal_extreme
	description = "<span class='danger'>ОТСОСУ ЗА СИГАРЕТУ!!</span>\n"
	happiness = -15
	timeout = FALSE
	group = "cig_addiction"

// АЛКОЛОМКА

/datum/happiness_event/addiction/alco/withdrawal_small
	description = "<span class='danger'>Выпить бы чего покрепче.</span>\n"
	happiness = -2
	timeout = FALSE
	group = "alco_addiction"

/datum/happiness_event/addiction/alco/withdrawal_medium
	description = "<span class='danger'>Как обидно без водки!</span>\n"
	happiness = -7
	timeout = FALSE
	group = "alco_addiction"

/datum/happiness_event/addiction/alco/withdrawal_large
	description = "<span class='danger'>Напиться до потери сознания ХОЧУ!!!</span>\n"
	happiness = -10
	timeout = FALSE
	group = "alco_addiction"

/datum/happiness_event/addiction/alco/withdrawal_extreme
	description = "<span class='danger'>ПОЧЕМУ Я НЕ ПЬЯН?!?!</span>\n"
	happiness = -15
	timeout = FALSE
	group = "alco_addiction"

/datum/happiness_event/high
	description = "<span class='info'>Под кайфом!</span>\n"
	happiness = 100
	group = "opium_addiction"

/datum/happiness_event/relaxed
	description = "<span class='info'>Хорошая сигаретка.</span>\n"
	happiness = 15
	timeout = 0
	group = "cig_addiction"

/datum/happiness_event/booze
	description = "<span class='info'>Алкоголь делает этот мир капельку светлее.</span>\n"
	happiness = 15
	timeout = 0
	group = "alco_addiction"

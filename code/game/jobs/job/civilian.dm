//Food
/datum/job/bartender
	title = "Bartender"
	department = "Service"
	description = "Твоя святая обазанность - напоить персонал, выслушать их нытьё и взять деньги за напитки. Ты станешь душой этой станции, твой бар будут любить и посещать."
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 2
	supervisors = "Капитан и Корпорация"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender
	wage = WAGE_MEDIUM

/datum/job/bartender/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.add_mutation(MUTATION_BARTENDER)
		H.newgeneratestats(9,10,9,11,8,11,9,10)
		H.generate_skills()
		H.skills["cooking"] = rand(35, 66)
		H.skills["melee"] = rand(15, 35)
		H.skills["ranged"] = rand(35, 50)
		H.skills["gardening"] = rand(15, 55)
		H.body_build_stats(H)

/datum/job/chef
	title = "Chef"
	description = "У тебя большой выбор специй для твоего супа - мышиный помёт, тараканы, мухи, древняя пыль и крошки со стола. Накорми бедных работяг и не забудь приготовить что-нибудь действительно вкусное для капитана."
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 2
	economic_modifier = 1.3
	supervisors = "Капитан и Корпорация"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef
	wage = WAGE_MEDIUM

/datum/job/chef/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(8,10,9,12,7,12,7,12)
		H.generate_skills()
		H.skills["cooking"] = rand(50, 85)
		H.skills["melee"] = rand(15, 35)
		H.skills["gardening"] = rand(35, 55)
		H.body_build_stats(H)

/datum/job/barmonkey
	title = "Waiter"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	no_latejoin = TRUE
	supervisors = "the bartender"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar)
	outfit_type = /decl/hierarchy/outfit/job/service/barmonkey
	preview_override = list("preview", 'icons/mob/human_races/monkeys/r_monkey.dmi')

/datum/job/barmonkey/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/new_name = (H.gender == FEMALE ? "Mrs. Deempisi" : "Mr. Deempisi")
		H.fully_replace_character_name(new_name)
		H.dna.real_name = new_name
		H.mind?.name = new_name
		H.flavor_text = ""
		H.add_mutation(MUTATION_BARTENDER)
		for(var/thing in H.flavor_texts)
			H.flavor_texts[thing] = null

/datum/job/hydro
	title = "Hydroponist"
	description = "Главный ботаник этой станции. Копай картошку, расти бананы! Без тебя повару будет грустно, а экипаж может остаться голодным."
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 2
	economic_modifier = 1.3
	supervisors = "Капитан и Корпорация"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_maint_tunnels, access_hydroponics)
	outfit_type = /decl/hierarchy/outfit/job/service/gardener
	wage = WAGE_MEDIUM

/datum/job/hydro/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(8,10,7,14,9,14,9,11)
		H.generate_skills()
		H.skills["gardening"] = rand(50, 85)
		H.skills["cooking"] = rand(15, 55)
		H.body_build_stats(H)


/datum/job/qm
	title = "Quartermaster"
	description = "Только лучшие становятся начальниками этого отдела. А ты лучший из лучших. На тебе шахта, гидропонная ферма и бар. Ассистенты, шахтёры и грузчики, даже повар и садовод твои пешки, помыкай ими! Время заработать немного деньжат"
	department = "Supply"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	supervisors = "Капитан, корпорация и личные амбиции"
	selection_color = "#5e4324"
	economic_modifier = 5
	access = list(access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_merchant,
			access_bar, access_construction, access_kitchen, access_hydroponics, access_janitor, access_tech_storage,
			access_heads, access_hop, access_RC_announce, access_keycard_auth, access_sec_doors, access_eva, access_maint_tunnels, access_external_airlocks, access_change_ids, access_teleporter)
	minimal_access = list(access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_merchant,
			access_bar, access_construction, access_kitchen, access_hydroponics, access_janitor, access_tech_storage,
			access_heads, access_hop, access_RC_announce, access_keycard_auth, access_sec_doors, access_eva, access_maint_tunnels, access_external_airlocks, access_change_ids, access_teleporter)
	minimal_player_age = 0
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm
	wage = WAGE_VERY_HIGH

/datum/job/qm/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(10,13,9,13,10,15,9,12)
		H.generate_skills()
		H.skills["melee"] = rand(20, 50)
		H.skills["ranged"] = rand(20, 40)
		H.skills["crafting"] = rand(35, 60)
		H.skills["gardening"] = rand(25, 45)
		H.skills["cooking"] = rand(25, 45)
		H.body_build_stats(H)

/datum/job/cargo_tech
	title = "Cargo Technician"
	description = "Завхоз не может тратить свои силы на таскание ящиков. Поэтому ты и существуешь. Бери ящики и таскай. Такая у тебя работа."
	department = "Supply"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	supervisors = "Капитан и Корпорация"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech
	wage = WAGE_LOW

/datum/job/cargo_tech/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(10,12,8,12,7,10,10,11)
		H.generate_skills()
		H.skills["melee"] = rand(25, 35)
		H.skills["crafting"] = rand(25, 40)
		H.skills["ranged"] = rand(15, 50)
		H.body_build_stats(H)

/datum/job/mining
	title = "Shaft Miner"
	department = "Supply"
	department_flag = SUP
	description = "Ты простой человек, который был привлечён лозунгами типа 'захватывающий риск, захватывающая оплата, захватывающие приключения', и теперь копаешь руду. Ты ещё можешь всё изменить, но надо ли оно тебе?"
	total_positions = 12
	spawn_positions = 6
	supervisors = "Капитан и Корпорация"
	selection_color = "#515151"
	economic_modifier = 1.2
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_mining, access_mining_station, access_mailsorting)
	//alt_titles = list("Drill Technician","Prospector")
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining
	wage = WAGE_LOW
	sex_lock = MALE

/datum/job/mining/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(10,12,8,12,6,10,9,13)
		H.generate_skills()
		H.skills["melee"] = rand(35, 50)
		H.skills["crafting"] = rand(25, 50)
		H.skills["ranged"] = rand(25, 45)
		H.body_build_stats(H)

/datum/job/janitor
	title = "Janitor"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	minimal_access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	alt_titles = list("Custodian","Sanitation Technician")
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

//More or less assistants
/datum/job/librarian
	title = "Librarian"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the heads of staff"
	selection_color = "#515151"
	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)
	alt_titles = list("Journalist")
	outfit_type = /decl/hierarchy/outfit/job/librarian

/datum/job/iaa
	title = "Internal Affairs Agent"
	department = "Support"
	department_flag = SPT
	total_positions = 2
	spawn_positions = 2
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#515151"
	economic_modifier = 7
	faction_restricted = TRUE
	access = list(access_iaa, access_security, access_maint_tunnels, access_heads)
	minimal_access = list(access_iaa, access_security, access_heads)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/internal_affairs_agent

/datum/job/iaa/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

/datum/job/lawyer
	title = "Lawyer"
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of security"
	selection_color = "#515151"
	economic_modifier = 3
	access = list(access_lawyer, access_security)
	minimal_access = list(access_lawyer)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/lawyer

/datum/job/clown
	title = "Clown"
	description = "Твоё истинное лицо будет скрыто за смешной маской, ибо никто не хочет его увидеть. Всем нужны твои шутки, приколы, розыгрыши, анекдоты. Ты просто обязан рассмешить всех, не подведи экипаж."
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "настроение экипажа"
	selection_color = "#ff72d0"
	access = list(access_maint_tunnels, access_clown)
	minimal_access = list(access_maint_tunnels, access_clown)
	minimal_player_age = 1
	outfit_type = /decl/hierarchy/outfit/job/clown
	sex_lock = MALE
	wage = WAGE_LOW

/datum/job/clown/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.add_mutation(MUTATION_CLUMSY)
		H.rename_self("clown")
		H.newgeneratestats(7,13,7,13,7,13,7,13)
		H.generate_skills()
		H.body_build_stats(H)

/datum/job/mime
	title = "Mime"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the sound of silence"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_mime)
	minimal_access = list(access_maint_tunnels, access_mime)
	minimal_player_age = 10
	outfit_type = /decl/hierarchy/outfit/job/mime

/datum/job/mime/equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind.changeling)
		return
	if(.)
		H.silent += 86400
		H.rename_self("mime")
	// Add "Invisible wall" spell
	H.add_spell(new /datum/spell/aoe_turf/conjure/forcewall/mime, "grey_spell_ready")

/datum/job/merchant
	title = "Merchant"
	description = "Тобою движет жажда наживы. Больше денег. Бабки, бабки, сука, бабки. Наполнить свои карманы сладко шуршащими купюрами. Увидеть шестизначное число на своём счету."
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	availablity_chance = 99
	supervisors = "Невидимая рука Рынка"
	selection_color = "#515151"
	ideal_character_age = 30
	minimal_player_age = 0
	create_record = 0
	outfit_type = /decl/hierarchy/outfit/job/merchant
	latejoin_at_spawnpoints = 1
	access = list(access_merchant)
	announced = FALSE
	can_be_hired = FALSE
	off_station = TRUE
	wage = WAGE_NONE

/datum/job/merchant/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(9,11,9,12,7,12,9,11)
		H.generate_skills()
		H.skills["ranged"] = rand(25, 90)
		H.skills["melee"] = rand(10, 90)
		H.skills["engineering"] = rand(10, 90)
		H.skills["crafting"] = rand(10, 90)
		H.skills["cooking"] = rand(10, 90)
		H.skills["medical"] = rand(10, 90)
		H.skills["surgery"] = rand(10, 90)
		H.skills["gardening"] = rand(10, 90)
		H.body_build_stats(H)

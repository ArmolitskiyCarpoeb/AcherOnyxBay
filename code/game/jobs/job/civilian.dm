//Food
/datum/job/bartender
	title = "Bartender"
	department = "Service"
	description = "Готовь коктейли, барыжь наркотиками, бери с клиентов деньги."
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "кардиналом и завхозом"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender

/datum/job/bartender/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.add_mutation(MUTATION_BARTENDER)
		H.newgeneratestats(5,15,5,15,5,15,5,15)
		H.generate_skills()
		H.skills["cooking"] = rand(35, 50)

/datum/job/chef
	title = "Chef"
	description = "У тебя большой выбор специй для твоего супа - мышиный помёт, тараканы, мухи, древняя пыль и крошки со стола. Накорми работяг."
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 1
	supervisors = "кардиналом и завхозом"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef

/datum/job/chef/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,15,5,15,5,15,5,15)
		H.generate_skills()
		H.skills["cooking"] = rand(50, 85)

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
	description = "Главный ботаник этой станции. Копай картошку, расти бананы!"
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 1
	supervisors = "кардиналом и завхозом"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_maint_tunnels, access_hydroponics)
	outfit_type = /decl/hierarchy/outfit/job/service/gardener

/datum/job/hydro/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,15,5,15,5,15,5,15)
		H.generate_skills()
		H.skills["gardening"] = rand(50, 85)

//Cargo
/datum/job/qm
	title = "Quartermaster"
	description = "Денежные потоки колонии в твоих руках. Работяги будут тянуться к тебе за лучшей долей. Гоняй этих оболтусов по поручениям, заставь копать руду, мыть кровь в коридоре или что-то ещё. Ну или продай на органы... Деньги это власть, пока в твою дверь настойчиво не постучат."
	department = "Supply"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	supervisors = "кардиналом и корпорацией"
	selection_color = "#5e4324"
	economic_modifier = 2
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_merchant)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_merchant)
	minimal_player_age = 7
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm

/datum/job/qm/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(5,13,7,12,9,15,5,15)
		H.generate_skills()

/datum/job/cargo_tech
	title = "Cargo Technician"
	department = "Supply"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech

/datum/job/mining
	title = "Shaft Miner"
	department = "Supply"
	department_flag = SUP
	description = "Простой человек, который был привлечён лозунгами типа 'захватывающий риск, захватывающая оплата, захватывающие приключения' и прилетел сюда копать руду."
	total_positions = 6
	spawn_positions = 4
	supervisors = "кардиналом и завхозом"
	selection_color = "#515151"
	economic_modifier = 0.9
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_mining, access_mining_station, access_mailsorting)
	//alt_titles = list("Drill Technician","Prospector")
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining

/datum/job/mining/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.newgeneratestats(10,16,6,14,5,12,6,14)
		H.generate_skills()
		H.skills["melee"] = rand(25, 60)

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
	supervisors = "the head of personnel"
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
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "uncommon sense"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_clown)
	minimal_access = list(access_maint_tunnels, access_clown)
	minimal_player_age = 10
	outfit_type = /decl/hierarchy/outfit/job/clown

/datum/job/clown/equip(mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.add_mutation(MUTATION_CLUMSY)
		H.rename_self("clown")

/datum/job/mime
	title = "Mime"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
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
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	availablity_chance = 40
	supervisors = "the invisible hand of the market"
	selection_color = "#515151"
	ideal_character_age = 30
	minimal_player_age = 7
	create_record = 0
	outfit_type = /decl/hierarchy/outfit/job/merchant
	latejoin_at_spawnpoints = 1
	access = list(access_merchant)
	announced = FALSE
	can_be_hired = FALSE
	off_station = TRUE

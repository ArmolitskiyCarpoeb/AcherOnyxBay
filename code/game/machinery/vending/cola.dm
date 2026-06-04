
/obj/machinery/vending/cola
	name = "Robust Softdrinks"
	desc = "A softdrink vendor provided by Robust Industries, LLC."

	icon = 'icons/obj/machines/vending/cola.dmi'
	icon_state = "Cola_Machine"
	light_color = "#EC2F2F"

	idle_power_usage = 211 WATTS //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.

	vend_delay = 11
	use_vend_state = TRUE
	product_slogans = "Robust Softdrinks: More robust than a toolbox to the head!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 1 million drinks sold!;Thirsty? Why not cola?;Please, have a drink!;Drink up!;The best drinks in space."

	vending_sound = SFX_VENDING_CANS

	component_types = list(
		/obj/item/vending_cartridge/cola
		)

	legal = list(
		/obj/item/reagent_containers/vessel/can/cola = 5,
		/obj/item/reagent_containers/vessel/can/colavanilla = 5,
		/obj/item/reagent_containers/vessel/can/colacherry = 5,
		/obj/item/reagent_containers/vessel/can/space_mountain_wind = 5,
		/obj/item/reagent_containers/vessel/can/dr_gibb = 5,
		/obj/item/reagent_containers/vessel/can/starkist = 5,
		/obj/item/reagent_containers/vessel/plastic/waterbottle = 5,
		/obj/item/reagent_containers/vessel/can/space_up = 5,
		/obj/item/reagent_containers/vessel/can/iced_tea = 5,
		/obj/item/reagent_containers/vessel/can/grape_juice = 5,
		/obj/item/reagent_containers/vessel/can/startrucks = 5,
		/obj/item/reagent_containers/vessel/can/red_mule = 2
		)

	illegal = list(
		/obj/item/reagent_containers/vessel/can/thirteenloko = 2,
		/obj/item/reagent_containers/vessel/can/dopecola = 2,
		/obj/item/reagent_containers/food/liquidfood = 2
		)

	premium = list(
		/obj/item/reagent_containers/vessel/plastic/waterbottle/fi4i = 2
		)

	prices = list(
		/obj/item/reagent_containers/vessel/can/cola = 50,
		/obj/item/reagent_containers/vessel/can/colavanilla = 80,
		/obj/item/reagent_containers/vessel/can/colacherry = 80,
		/obj/item/reagent_containers/vessel/can/space_mountain_wind = 50,
		/obj/item/reagent_containers/vessel/can/dr_gibb = 50,
		/obj/item/reagent_containers/vessel/can/starkist = 50,
		/obj/item/reagent_containers/vessel/plastic/waterbottle = 30,
		/obj/item/reagent_containers/vessel/can/space_up = 50,
		/obj/item/reagent_containers/vessel/can/iced_tea = 80,
		/obj/item/reagent_containers/vessel/can/grape_juice = 50,
		/obj/item/reagent_containers/vessel/can/startrucks = 100,
		/obj/item/reagent_containers/vessel/can/red_mule = 150
		)

/obj/item/vending_cartridge/cola
	icon_state = "refill_cola"
	build_path = /obj/machinery/vending/cola

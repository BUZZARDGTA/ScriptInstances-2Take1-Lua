-- Author: IB_U_Z_Z_A_R_Dl
-- Description: Formerly created by NotYourDope on PS3 and Xbox 360 (https://playersquared.com/threads/nyd-projects-collection-v3.3255/), here implemented on PC in Lua for 2Take1 menu.
-- GitHub Repository: https://github.com/Illegal-Services/ScriptInstances-2Take1-Lua


-- Globals START
---- Global variables START
local scriptExitEventListener
local scriptsListThread
---- Global variables END

---- Global constants 1/3 START
local SCRIPT_NAME <const> = "ScriptInstances.lua"
local SCRIPT_TITLE <const> = "Script Instances"
local SCRIPT_SETTINGS__PATH <const> = "scripts\\ScriptInstances\\Settings.ini"
local NATIVES <const> = require("lib\\natives2845")
local HOME_PATH <const> = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
local RE_SCRITPS_NAME_PATTERN <const> = Regex("^([a-z0-9_]{1,35})$")
local TRUSTED_FLAGS <const> = {
    { name = "LUA_TRUST_STATS", menuName = "Trusted Stats", bitValue = 1 << 0, isRequiered = false },
    { name = "LUA_TRUST_SCRIPT_VARS", menuName = "Trusted Globals / Locals", bitValue = 1 << 1, isRequiered = false },
    { name = "LUA_TRUST_NATIVES", menuName = "Trusted Natives", bitValue = 1 << 2, isRequiered = true },
    { name = "LUA_TRUST_HTTP", menuName = "Trusted Http", bitValue = 1 << 3, isRequiered = false },
    { name = "LUA_TRUST_MEMORY", menuName = "Trusted Memory", bitValue = 1 << 4, isRequiered = false }
}
-- [26/06/2024] These *.ysc scripts were scraped from OpenIV's path: "GTAV\update\update2.rpf\x64\levels\gta5\script\script_rel.rpf\".
local SCRIPTS_LIST <const> = {
    "abigail1",
    "abigail2",
    "achievement_controller",
    "activity_creator_prototype_launcher",
    "act_cinema",
    "af_intro_t_sandy",
    "agency_heist1",
    "agency_heist2",
    "agency_heist3a",
    "agency_heist3b",
    "agency_prep1",
    "agency_prep2amb",
    "aicover_test",
    "ainewengland_test",
    "altruist_cult",
    "ambientblimp",
    "ambient_diving",
    "ambient_mrsphilips",
    "ambient_solomon",
    "ambient_sonar",
    "ambient_tonya",
    "ambient_tonyacall",
    "ambient_tonyacall2",
    "ambient_tonyacall5",
    "ambient_ufos",
    "am_agency_suv",
    "am_airstrike",
    "am_ammo_drop",
    "am_arena_shp",
    "am_armwrestling",
    "am_armwrestling_apartment",
    "am_armybase",
    "am_backup_heli",
    "am_beach_washup_cinematic",
    "am_boat_taxi",
    "am_bru_box",
    "am_car_mod_tut",
    "am_casino_limo",
    "am_casino_luxury_car",
    "am_casino_peds",
    "am_challenges",
    "am_contact_requests",
    "am_cp_collection",
    "am_crate_drop",
    "am_criminal_damage",
    "am_darts",
    "am_darts_apartment",
    "am_dead_drop",
    "am_destroy_veh",
    "am_distract_cops",
    "am_doors",
    "am_ferriswheel",
    "am_gang_call",
    "am_ga_pickups",
    "am_heist_int",
    "am_heli_taxi",
    "am_hi_plane_land_cinematic",
    "am_hi_plane_take_off_cinematic",
    "am_hold_up",
    "am_hot_property",
    "am_hot_target",
    "am_hs4_isd_take_vel",
    "am_hs4_lsa_land_nimb_arrive",
    "am_hs4_lsa_land_vel",
    "am_hs4_lsa_take_vel",
    "am_hs4_nimb_isd_lsa_leave",
    "am_hs4_nimb_lsa_isd_arrive",
    "am_hs4_nimb_lsa_isd_leave",
    "am_hs4_vel_lsa_isd",
    "am_hunt_the_beast",
    "am_imp_exp",
    "am_island_backup_heli",
    "am_joyrider",
    "am_kill_list",
    "am_king_of_the_castle",
    "am_launcher",
    "am_lester_cut",
    "am_lowrider_int",
    "am_lsia_take_off_cinematic",
    "am_luxury_showroom",
    "am_mission_launch",
    "am_mp_acid_lab",
    "am_mp_arcade",
    "am_mp_arcade_claw_crane",
    "am_mp_arcade_fortune_teller",
    "am_mp_arcade_love_meter",
    "am_mp_arcade_peds",
    "am_mp_arcade_strength_test",
    "am_mp_arc_cab_manager",
    "am_mp_arena_box",
    "am_mp_arena_garage",
    "am_mp_armory_aircraft",
    "am_mp_armory_truck",
    "am_mp_auto_shop",
    "am_mp_bail_office",
    "am_mp_biker_warehouse",
    "am_mp_boardroom_seating",
    "am_mp_bunker",
    "am_mp_business_hub",
    "am_mp_carwash_launch",
    "am_mp_car_meet_property",
    "am_mp_car_meet_sandbox",
    "am_mp_casino",
    "am_mp_casino_apartment",
    "am_mp_casino_nightclub",
    "am_mp_casino_valet_garage",
    "am_mp_creator_aircraft",
    "am_mp_creator_trailer",
    "am_mp_defunct_base",
    "am_mp_drone",
    "am_mp_fixer_hq",
    "am_mp_garage_control",
    "am_mp_hacker_truck",
    "am_mp_hangar",
    "am_mp_ie_warehouse",
    "am_mp_island",
    "am_mp_juggalo_hideout",
    "am_mp_multistorey_garage",
    "am_mp_music_studio",
    "am_mp_nightclub",
    "am_mp_orbital_cannon",
    "am_mp_peds",
    "am_mp_property_ext",
    "am_mp_property_int",
    "am_mp_rc_vehicle",
    "am_mp_salvage_yard",
    "am_mp_shooting_range",
    "am_mp_simeon_showroom",
    "am_mp_smoking_activity",
    "am_mp_smpl_interior_ext",
    "am_mp_smpl_interior_int",
    "am_mp_social_club_garage",
    "am_mp_solomon_office",
    "am_mp_submarine",
    "am_mp_vehicle_organization_menu",
    "am_mp_vehicle_reward",
    "am_mp_vehicle_weapon",
    "am_mp_vinewood_premium_garage",
    "am_mp_vinewood_premium_modshop",
    "am_mp_warehouse",
    "am_mp_yacht",
    "am_npc_invites",
    "am_pass_the_parcel",
    "am_penned_in",
    "am_penthouse_peds",
    "am_pi_menu",
    "am_plane_takedown",
    "am_prison",
    "am_prostitute",
    "am_rollercoaster",
    "am_rontrevor_cut",
    "am_taxi",
    "am_vehicle_spawn",
    "animal_controller",
    "apartment_minigame_launcher",
    "apparcadebusiness",
    "apparcadebusinesshub",
    "appavengeroperations",
    "appbailoffice",
    "appbikerbusiness",
    "appbroadcast",
    "appbunkerbusiness",
    "appbusinesshub",
    "appcamera",
    "appchecklist",
    "appcontacts",
    "appcovertops",
    "appemail",
    "appextraction",
    "appfixersecurity",
    "apphackertruck",
    "apphs_sleep",
    "appimportexport",
    "appinternet",
    "appjipmp",
    "appmedia",
    "appmpbossagency",
    "appmpemail",
    "appmpjoblistnew",
    "apporganiser",
    "appprogresshub",
    "apprepeatplay",
    "appsecurohack",
    "appsecuroserv",
    "appsettings",
    "appsidetask",
    "appsmuggler",
    "apptextmessage",
    "apptrackify",
    "appvinewoodmenu",
    "appvlsi",
    "appzit",
    "arcade_seating",
    "arena_box_bench_seats",
    "arena_carmod",
    "arena_workshop_seats",
    "armenian1",
    "armenian2",
    "armenian3",
    "armory_aircraft_carmod",
    "assassin_bus",
    "assassin_construction",
    "assassin_hooker",
    "assassin_multi",
    "assassin_rankup",
    "assassin_valet",
    "atm_trigger",
    "audiotest",
    "autosave_controller",
    "auto_shop_seating",
    "bailbond1",
    "bailbond2",
    "bailbond3",
    "bailbond4",
    "bailbond_launcher",
    "bail_office_seating",
    "barry1",
    "barry2",
    "barry3",
    "barry3a",
    "barry3c",
    "barry4",
    "base_carmod",
    "base_corridor_seats",
    "base_entrance_seats",
    "base_heist_seats",
    "base_lounge_seats",
    "base_quaters_seats",
    "base_reception_seats",
    "basic_creator",
    "beach_exterior_seating",
    "benchmark",
    "bigwheel",
    "bj",
    "blackjack",
    "blimptest",
    "blip_controller",
    "bootycallhandler",
    "bootycall_debug_controller",
    "buddydeathresponse",
    "bugstar_mission_export",
    "buildingsiteambience",
    "building_controller",
    "business_battles",
    "business_battles_defend",
    "business_battles_sell",
    "business_hub_carmod",
    "business_hub_garage_seats",
    "cablecar",
    "camera_test",
    "camhedz_arcade",
    "cam_coord_sender",
    "candidate_controller",
    "carmod_shop",
    "carsteal1",
    "carsteal2",
    "carsteal3",
    "carsteal4",
    "carwash1",
    "carwash2",
    "car_meet_carmod",
    "car_meet_exterior_seating",
    "car_meet_interior_seating",
    "car_roof_test",
    "casinoroulette",
    "casino_bar_seating",
    "casino_exterior_seating",
    "casino_interior_seating",
    "casino_lucky_wheel",
    "casino_main_lounge_seating",
    "casino_nightclub_seating",
    "casino_penthouse_seating",
    "casino_slots",
    "celebrations",
    "celebration_editor",
    "cellphone_controller",
    "cellphone_flashhand",
    "charactergoals",
    "charanimtest",
    "cheat_controller",
    "chinese1",
    "chinese2",
    "chop",
    "clothes_shop_mp",
    "clothes_shop_sp",
    "code_controller",
    "combat_test",
    "comms_controller",
    "completionpercentage_controller",
    "component_checker",
    "context_controller",
    "controller_ambientarea",
    "controller_races",
    "controller_taxi",
    "controller_towing",
    "controller_trafficking",
    "coordinate_recorder",
    "country_race",
    "country_race_controller",
    "creation_startup",
    "creator",
    "custom_config",
    "cutscenemetrics",
    "cutscenesamples",
    "cutscene_test",
    "darts",
    "debug",
    "debug_app_select_screen",
    "debug_clone_outfit_testing",
    "debug_launcher",
    "debug_ped_data",
    "degenatron_games",
    "density_test",
    "dialogue_handler",
    "director_mode",
    "docks2asubhandler",
    "docks_heista",
    "docks_heistb",
    "docks_prep1",
    "docks_prep2b",
    "docks_setup",
    "dont_cross_the_line",
    "dreyfuss1",
    "drf1",
    "drf2",
    "drf3",
    "drf4",
    "drf5",
    "drunk",
    "drunk_controller",
    "dynamixtest",
    "email_controller",
    "emergencycall",
    "emergencycalllauncher",
    "epscars",
    "epsdesert",
    "epsilon1",
    "epsilon2",
    "epsilon3",
    "epsilon4",
    "epsilon5",
    "epsilon6",
    "epsilon7",
    "epsilon8",
    "epsilontract",
    "epsrobes",
    "error_listener",
    "error_thrower",
    "event_controller",
    "exile1",
    "exile2",
    "exile3",
    "exile_city_denial",
    "extreme1",
    "extreme2",
    "extreme3",
    "extreme4",
    "fairgroundhub",
    "fake_interiors",
    "fameorshame_eps",
    "fameorshame_eps_1",
    "fame_or_shame_set",
    "family1",
    "family1taxi",
    "family2",
    "family3",
    "family4",
    "family5",
    "family6",
    "family_scene_f0",
    "family_scene_f1",
    "family_scene_m",
    "family_scene_t0",
    "family_scene_t1",
    "fanatic1",
    "fanatic2",
    "fanatic3",
    "fbi1",
    "fbi2",
    "fbi3",
    "fbi4",
    "fbi4_intro",
    "fbi4_prep1",
    "fbi4_prep2",
    "fbi4_prep3",
    "fbi4_prep3amb",
    "fbi4_prep4",
    "fbi4_prep5",
    "fbi5a",
    "finalea",
    "finaleb",
    "finalec1",
    "finalec2",
    "finale_choice",
    "finale_credits",
    "finale_endgame",
    "finale_heist1",
    "finale_heist2a",
    "finale_heist2b",
    "finale_heist2_intro",
    "finale_heist_prepa",
    "finale_heist_prepb",
    "finale_heist_prepc",
    "finale_heist_prepd",
    "finale_heist_prepeamb",
    "finale_intro",
    "fixer_hq_carmod",
    "fixer_hq_seating",
    "fixer_hq_seating_op_floor",
    "fixer_hq_seating_pq",
    "floating_help_controller",
    "flowintrotitle",
    "flowstartaccept",
    "flow_autoplay",
    "flow_controller",
    "flow_help",
    "flyunderbridges",
    "fmmc_contentquicklauncher",
    "fmmc_launcher",
    "fmmc_playlist_controller",
    "fm_bj_race_controler",
    "fm_capture_creator",
    "fm_content_acid_lab_sell",
    "fm_content_acid_lab_setup",
    "fm_content_acid_lab_source",
    "fm_content_ammunation",
    "fm_content_armoured_truck",
    "fm_content_auto_shop_delivery",
    "fm_content_bank_shootout",
    "fm_content_bar_resupply",
    "fm_content_bicycle_time_trial",
    "fm_content_bike_shop_delivery",
    "fm_content_bounty_targets",
    "fm_content_business_battles",
    "fm_content_cargo",
    "fm_content_cerberus",
    "fm_content_chop_shop_delivery",
    "fm_content_clubhouse_contracts",
    "fm_content_club_management",
    "fm_content_club_odd_jobs",
    "fm_content_club_source",
    "fm_content_convoy",
    "fm_content_crime_scene",
    "fm_content_daily_bounty",
    "fm_content_dispatch_work",
    "fm_content_drug_lab_work",
    "fm_content_drug_vehicle",
    "fm_content_export_cargo",
    "fm_content_ghosthunt",
    "fm_content_golden_gun",
    "fm_content_gunrunning",
    "fm_content_hsw_setup",
    "fm_content_hsw_time_trial",
    "fm_content_island_dj",
    "fm_content_island_heist",
    "fm_content_metal_detector",
    "fm_content_movie_props",
    "fm_content_mp_intro",
    "fm_content_parachuter",
    "fm_content_payphone_hit",
    "fm_content_phantom_car",
    "fm_content_pizza_delivery",
    "fm_content_possessed_animals",
    "fm_content_robbery",
    "fm_content_security_contract",
    "fm_content_sightseeing",
    "fm_content_skydive",
    "fm_content_slasher",
    "fm_content_smuggler_ops",
    "fm_content_smuggler_plane",
    "fm_content_smuggler_resupply",
    "fm_content_smuggler_sell",
    "fm_content_smuggler_trail",
    "fm_content_source_research",
    "fm_content_stash_house",
    "fm_content_taxi_driver",
    "fm_content_test",
    "fm_content_tow_truck_work",
    "fm_content_tuner_robbery",
    "fm_content_ufo_abduction",
    "fm_content_vehicle_list",
    "fm_content_vehrob_arena",
    "fm_content_vehrob_cargo_ship",
    "fm_content_vehrob_casino_prize",
    "fm_content_vehrob_disrupt",
    "fm_content_vehrob_police",
    "fm_content_vehrob_prep",
    "fm_content_vehrob_scoping",
    "fm_content_vehrob_submarine",
    "fm_content_vehrob_task",
    "fm_content_vip_contract_1",
    "fm_content_xmas_mugger",
    "fm_content_xmas_truck",
    "fm_deathmatch_controler",
    "fm_deathmatch_creator",
    "fm_hideout_controler",
    "fm_hold_up_tut",
    "fm_horde_controler",
    "fm_impromptu_dm_controler",
    "fm_intro",
    "fm_intro_cut_dev",
    "fm_lts_creator",
    "fm_maintain_cloud_header_data",
    "fm_maintain_transition_players",
    "fm_main_menu",
    "fm_mission_controller",
    "fm_mission_controller_2020",
    "fm_mission_creator",
    "fm_race_controler",
    "fm_race_creator",
    "fm_street_dealer",
    "fm_survival_controller",
    "fm_survival_creator",
    "forsalesigns",
    "fps_test",
    "fps_test_mag",
    "franklin0",
    "franklin1",
    "franklin2",
    "freemode",
    "freemode_clearglobals",
    "freemode_creator",
    "freemode_init",
    "friendactivity",
    "friends_controller",
    "friends_debug_controller",
    "fullmap_test",
    "fullmap_test_flow",
    "game_server_test",
    "gb_airfreight",
    "gb_amphibious_assault",
    "gb_assault",
    "gb_bank_job",
    "gb_bellybeast",
    "gb_biker_bad_deal",
    "gb_biker_burn_assets",
    "gb_biker_contraband_defend",
    "gb_biker_contraband_sell",
    "gb_biker_contract_killing",
    "gb_biker_criminal_mischief",
    "gb_biker_destroy_vans",
    "gb_biker_driveby_assassin",
    "gb_biker_free_prisoner",
    "gb_biker_joust",
    "gb_biker_last_respects",
    "gb_biker_race_p2p",
    "gb_biker_rescue_contact",
    "gb_biker_rippin_it_up",
    "gb_biker_safecracker",
    "gb_biker_search_and_destroy",
    "gb_biker_shuttle",
    "gb_biker_stand_your_ground",
    "gb_biker_steal_bikes",
    "gb_biker_target_rival",
    "gb_biker_unload_weapons",
    "gb_biker_wheelie_rider",
    "gb_carjacking",
    "gb_cashing_out",
    "gb_casino",
    "gb_casino_heist",
    "gb_casino_heist_planning",
    "gb_collect_money",
    "gb_contraband_buy",
    "gb_contraband_defend",
    "gb_contraband_sell",
    "gb_data_hack",
    "gb_deathmatch",
    "gb_delivery",
    "gb_finderskeepers",
    "gb_fivestar",
    "gb_fortified",
    "gb_fragile_goods",
    "gb_fully_loaded",
    "gb_gangops",
    "gb_gang_ops_planning",
    "gb_gunrunning",
    "gb_gunrunning_defend",
    "gb_gunrunning_delivery",
    "gb_headhunter",
    "gb_hunt_the_boss",
    "gb_ie_delivery_cutscene",
    "gb_illicit_goods_resupply",
    "gb_infiltration",
    "gb_jewel_store_grab",
    "gb_ploughed",
    "gb_point_to_point",
    "gb_ramped_up",
    "gb_rob_shop",
    "gb_salvage",
    "gb_security_van",
    "gb_sightseer",
    "gb_smuggler",
    "gb_stockpiling",
    "gb_target_pursuit",
    "gb_terminate",
    "gb_transporter",
    "gb_vehicle_export",
    "gb_velocity",
    "gb_yacht_rob",
    "general_test",
    "ggsm_arcade",
    "globals_fmmcstruct2_registration",
    "globals_fmmc_struct_registration",
    "golf",
    "golf_ai_foursome",
    "golf_ai_foursome_putting",
    "golf_mp",
    "gpb_andymoon",
    "gpb_baygor",
    "gpb_billbinder",
    "gpb_clinton",
    "gpb_griff",
    "gpb_jane",
    "gpb_jerome",
    "gpb_jesse",
    "gpb_mani",
    "gpb_mime",
    "gpb_pameladrake",
    "gpb_superhero",
    "gpb_tonya",
    "gpb_zombie",
    "grid_arcade_cabinet",
    "gtest_airplane",
    "gtest_avoidance",
    "gtest_boat",
    "gtest_divingfromcar",
    "gtest_divingfromcarwhilefleeing",
    "gtest_helicopter",
    "gtest_nearlymissedbycar",
    "gunclub_shop",
    "gunfighttest",
    "gunslinger_arcade",
    "hacker_truck_carmod",
    "hairdo_shop_mp",
    "hairdo_shop_sp",
    "hangar_carmod",
    "hao1",
    "headertest",
    "heatmap_test",
    "heatmap_test_flow",
    "heist_ctrl_agency",
    "heist_ctrl_docks",
    "heist_ctrl_finale",
    "heist_ctrl_jewel",
    "heist_ctrl_rural",
    "heist_island_planning",
    "heli_gun",
    "heli_streaming",
    "hud_creator",
    "hunting1",
    "hunting2",
    "hunting_ambient",
    "idlewarper",
    "ingamehud",
    "initial",
    "item_ownership_output",
    "jewelry_heist",
    "jewelry_prep1a",
    "jewelry_prep1b",
    "jewelry_prep2a",
    "jewelry_setup1",
    "josh1",
    "josh2",
    "josh3",
    "josh4",
    "juggalo_hideout_carmod",
    "juggalo_hideout_seating",
    "lamar1",
    "landing_pre_startup",
    "laptop_trigger",
    "launcher_abigail",
    "launcher_barry",
    "launcher_basejumpheli",
    "launcher_basejumppack",
    "launcher_carwash",
    "launcher_darts",
    "launcher_dreyfuss",
    "launcher_epsilon",
    "launcher_extreme",
    "launcher_fanatic",
    "launcher_golf",
    "launcher_hao",
    "launcher_hunting",
    "launcher_hunting_ambient",
    "launcher_josh",
    "launcher_maude",
    "launcher_minute",
    "launcher_mrsphilips",
    "launcher_nigel",
    "launcher_offroadracing",
    "launcher_omega",
    "launcher_paparazzo",
    "launcher_pilotschool",
    "launcher_racing",
    "launcher_rampage",
    "launcher_range",
    "launcher_stunts",
    "launcher_tennis",
    "launcher_thelastone",
    "launcher_tonya",
    "launcher_triathlon",
    "launcher_yoga",
    "lester1",
    "lesterhandler",
    "letterscraps",
    "line_activation_test",
    "liverecorder",
    "localpopulator",
    "locates_tester",
    "luxe_veh_activity",
    "magdemo",
    "magdemo2",
    "main",
    "maintransition",
    "main_install",
    "main_persistent",
    "martin1",
    "maude1",
    "maude_postbailbond",
    "me_amanda1",
    "me_jimmy1",
    "me_tracey1",
    "mg_race_to_point",
    "michael1",
    "michael2",
    "michael3",
    "michael4",
    "michael4leadout",
    "minigame_ending_stinger",
    "minigame_stats_tracker",
    "minute1",
    "minute2",
    "minute3",
    "missioniaaturret",
    "mission_race",
    "mission_repeat_controller",
    "mission_stat_alerter",
    "mission_stat_watcher",
    "mission_triggerer_a",
    "mission_triggerer_b",
    "mission_triggerer_c",
    "mission_triggerer_d",
    "mmmm",
    "mpstatsinit",
    "mptestbed",
    "mp_awards",
    "mp_bed_high",
    "mp_fm_registration",
    "mp_gameplay_menu",
    "mp_menuped",
    "mp_player_damage_numbers",
    "mp_prop_global_block",
    "mp_prop_special_global_block",
    "mp_registration",
    "mp_save_game_global_block",
    "mp_skycam_stuck_wiggler",
    "mp_unlocks",
    "mp_weapons",
    "mrsphilips1",
    "mrsphilips2",
    "multistorey_garage_ext_seating",
    "multistorey_garage_seating",
    "murdermystery",
    "music_studio_seating",
    "music_studio_seating_external",
    "music_studio_smoking",
    "navmeshtest",
    "net_activity_creator_ui",
    "net_apartment_activity",
    "net_apartment_activity_light",
    "net_bot_brain",
    "net_bot_simplebrain",
    "net_cloud_mission_loader",
    "net_combat_soaktest",
    "net_freemode_debug_2023",
    "net_freemode_debug_stat_2023",
    "net_jacking_soaktest",
    "net_session_soaktest",
    "net_test_drive",
    "net_tunable_check",
    "nigel1",
    "nigel1a",
    "nigel1b",
    "nigel1c",
    "nigel1d",
    "nigel2",
    "nigel3",
    "nightclubpeds",
    "nightclub_ground_floor_seats",
    "nightclub_office_seats",
    "nightclub_vip_seats",
    "nodemenututorial",
    "nodeviewer",
    "ob_abatdoor",
    "ob_abattoircut",
    "ob_airdancer",
    "ob_bong",
    "ob_cashregister",
    "ob_drinking_shots",
    "ob_foundry_cauldron",
    "ob_franklin_beer",
    "ob_franklin_tv",
    "ob_franklin_wine",
    "ob_huffing_gas",
    "ob_jukebox",
    "ob_mp_bed_high",
    "ob_mp_bed_low",
    "ob_mp_bed_med",
    "ob_mp_shower_med",
    "ob_mp_stripper",
    "ob_mr_raspberry_jam",
    "ob_poledancer",
    "ob_sofa_franklin",
    "ob_sofa_michael",
    "ob_telescope",
    "ob_tv",
    "ob_vend1",
    "ob_vend2",
    "ob_wheatgrass",
    "offroad_races",
    "omega1",
    "omega2",
    "paparazzo1",
    "paparazzo2",
    "paparazzo3",
    "paparazzo3a",
    "paparazzo3b",
    "paparazzo4",
    "paradise",
    "paradise2",
    "pausemenu",
    "pausemenucareerhublaunch",
    "pausemenu_example",
    "pausemenu_map",
    "pausemenu_multiplayer",
    "pausemenu_sp_repeat",
    "pb_busker",
    "pb_homeless",
    "pb_preacher",
    "pb_prostitute",
    "personal_carmod_shop",
    "photographymonkey",
    "photographywildlife",
    "physics_perf_test",
    "physics_perf_test_launcher",
    "pickuptest",
    "pickupvehicles",
    "pickup_controller",
    "pilot_school",
    "pilot_school_mp",
    "pi_menu",
    "placeholdermission",
    "placementtest",
    "planewarptest",
    "player_controller",
    "player_controller_b",
    "player_scene_ft_franklin1",
    "player_scene_f_lamgraff",
    "player_scene_f_lamtaunt",
    "player_scene_f_taxi",
    "player_scene_mf_traffic",
    "player_scene_m_cinema",
    "player_scene_m_fbi2",
    "player_scene_m_kids",
    "player_scene_m_shopping",
    "player_scene_t_bbfight",
    "player_scene_t_chasecar",
    "player_scene_t_insult",
    "player_scene_t_park",
    "player_scene_t_tie",
    "player_timetable_scene",
    "playthrough_builder",
    "pm_defend",
    "pm_delivery",
    "pm_gang_attack",
    "pm_plane_promotion",
    "pm_recover_stolen",
    "postkilled_bailbond2",
    "postrc_barry1and2",
    "postrc_barry4",
    "postrc_epsilon4",
    "postrc_nigel3",
    "profiler_registration",
    "prologue1",
    "prop_drop",
    "public_mission_creator",
    "puzzle",
    "racetest",
    "rampage1",
    "rampage2",
    "rampage3",
    "rampage4",
    "rampage5",
    "rampage_controller",
    "randomchar_controller",
    "range_modern",
    "range_modern_mp",
    "rcpdata",
    "replay_controller",
    "rerecord_recording",
    "respawn_controller",
    "restrictedareas",
    "re_abandonedcar",
    "re_accident",
    "re_armybase",
    "re_arrests",
    "re_atmrobbery",
    "re_bikethief",
    "re_border",
    "re_burials",
    "re_bus_tours",
    "re_cartheft",
    "re_chasethieves",
    "re_crashrescue",
    "re_cultshootout",
    "re_dealgonewrong",
    "re_domestic",
    "re_drunkdriver",
    "re_duel",
    "re_gangfight",
    "re_gang_intimidation",
    "re_getaway_driver",
    "re_hitch_lift",
    "re_homeland_security",
    "re_lossantosintl",
    "re_lured",
    "re_monkey",
    "re_mountdance",
    "re_muggings",
    "re_paparazzi",
    "re_prison",
    "re_prisonerlift",
    "re_prisonvanbreak",
    "re_rescuehostage",
    "re_seaplane",
    "re_securityvan",
    "re_shoprobbery",
    "re_snatched",
    "re_stag_do",
    "re_yetarian",
    "rng_output",
    "road_arcade",
    "rollercoaster",
    "rural_bank_heist",
    "rural_bank_prep1",
    "rural_bank_setup",
    "salvage_yard_seating",
    "savegame_bed",
    "save_anywhere",
    "scaleformgraphictest",
    "scaleformminigametest",
    "scaleformprofiling",
    "scaleformtest",
    "scene_builder",
    "sclub_front_bouncer",
    "scripted_cam_editor",
    "scriptplayground",
    "scripttest1",
    "scripttest2",
    "scripttest3",
    "scripttest4",
    "script_metrics",
    "scroll_arcade_cabinet",
    "sctv",
    "sc_lb_global_block",
    "selector",
    "selector_example",
    "selling_short_1",
    "selling_short_2",
    "shooting_camera",
    "shoprobberies",
    "shop_controller",
    "shot_bikejump",
    "shrinkletter",
    "sh_intro_f_hills",
    "sh_intro_m_home",
    "simeon_showroom_seating",
    "smoketest",
    "social_controller",
    "solomon1",
    "solomon2",
    "solomon3",
    "spaceshipparts",
    "spawn_activities",
    "speech_reverb_tracker",
    "spmc_instancer",
    "spmc_preloader",
    "sp_dlc_registration",
    "sp_editor_mission_instance",
    "sp_menuped",
    "sp_pilotschool_reg",
    "standard_global_init",
    "standard_global_reg",
    "startup",
    "startup_install",
    "startup_locationtest",
    "startup_positioning",
    "startup_smoketest",
    "stats_controller",
    "stock_controller",
    "streaming",
    "stripclub",
    "stripclub_drinking",
    "stripclub_mp",
    "stripperhome",
    "stunt_plane_races",
    "tasklist_1",
    "tattoo_shop",
    "taxilauncher",
    "taxiservice",
    "taxitutorial",
    "taxi_clowncar",
    "taxi_cutyouin",
    "taxi_deadline",
    "taxi_followcar",
    "taxi_gotyounow",
    "taxi_gotyourback",
    "taxi_needexcitement",
    "taxi_procedural",
    "taxi_takeiteasy",
    "taxi_taketobest",
    "tempalpha",
    "temptest",
    "tennis",
    "tennis_ambient",
    "tennis_family",
    "tennis_network_mp",
    "test_startup",
    "thelastone",
    "three_card_poker",
    "timershud",
    "title_update_registration",
    "title_update_registration_2",
    "tonya1",
    "tonya2",
    "tonya3",
    "tonya4",
    "tonya5",
    "towing",
    "traffickingsettings",
    "traffickingteleport",
    "traffick_air",
    "traffick_ground",
    "train_create_widget",
    "train_tester",
    "trevor1",
    "trevor2",
    "trevor3",
    "trevor4",
    "triathlonsp",
    "tunables_registration",
    "tuneables_processing",
    "tuner_planning",
    "tuner_property_carmod",
    "tuner_sandbox_activity",
    "turret_cam_script",
    "ufo",
    "ugc_global_registration",
    "ugc_global_registration_2",
    "underwaterpickups",
    "utvc",
    "vehiclespawning",
    "vehicle_ai_test",
    "vehicle_force_widget",
    "vehicle_gen_controller",
    "vehicle_plate",
    "vehicle_stealth_mode",
    "vehrob_planning",
    "veh_play_widget",
    "vinewood_premium_garage_carmod",
    "walking_ped",
    "wardrobe_mp",
    "wardrobe_sp",
    "weapon_audio_widget",
    "wizard_arcade",
    "wp_partyboombox",
    "xml_menus",
    "yoga",
}
---- Global constants 1/2 END

---- Global functions 1/2 START
local function rgb_to_int(R, G, B, A)
    A = A or 255
    return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

local function get_max_lenth_in_str_scripts_list(strings_list)
    local max_length = 0
    for _, str in ipairs(strings_list) do
        if #str > max_length then
            max_length = #str
        end
    end
    return max_length
end
---- Global functions 1/2 END

---- Global constants 2/2 START
local COLOR <const> = {
    RED = rgb_to_int(255, 0, 0, 255),
    ORANGE = rgb_to_int(255, 165, 0, 255),
    GREEN = rgb_to_int(0, 255, 0, 255)
}
local MAX_STR_LENTH_IN_SCRIPTS_LIST <const> = get_max_lenth_in_str_scripts_list(SCRIPTS_LIST)
---- Global constants 2/2 END

---- Global functions 2/2 START
local function pluralize(word, count)
    if count > 1 then
        return word .. "s"
    else
        return word
    end
end

local function ends_with_newline(str)
    if string.sub(str, -1) == "\n" then
        return true
    end
    return false
end

function read_file(file_path)
    local file, err = io.open(file_path, "r")
    if err then
        return nil, err
    end

    local content = file:read("*a")

    file:close()

    return content, nil
end

local function get_collection_custom_value(collection, inputKey, inputValue, outputKey)
    --[[
    This function retrieves a specific value (or checks existence) from a collection based on a given input key-value pair.

    Parameters:
    collection (table): The collection to search within.
    inputKey (string): The key within each item of the collection to match against `inputValue`.
    inputValue (any): The value to match against `inputKey` within the collection.
    outputKey (string or nil): Optional. The key within the matched item to retrieve its value.
                                If nil, function returns true if item is found; false otherwise.

    Returns:
    If `outputKey` is provided and the item is resolved, it returns its value or nil;
    otherwise, it returns true or false depending on whether the item was found within the collection.
    ]]
    for _, item in ipairs(collection) do
        if item[inputKey] == inputValue then
            if outputKey == nil then
                return true
            else
                return item[outputKey]
            end
        end
    end

    if outputKey == nil then
        return false
    else
        return nil
    end
end

local function create_tick_handler(handler)
    return menu.create_thread(function()
        while true do
            handler()
            system.yield()
        end
    end)
end

local function is_thread_runnning(threadId)
    if threadId and not menu.has_thread_finished(threadId) then
        return true
    end

    return false
end

local function remove_event_listener(eventType, listener)
    if listener and event.remove_event_listener(eventType, listener) then
        return
    end

    return listener
end

local function delete_thread(threadId)
    if threadId and menu.delete_thread(threadId) then
        return nil
    end

    return threadId
end

local function handle_script_exit(params)
    params = params or {}
    if params.clearAllNotifications == nil then
        params.clearAllNotifications = false
    end
    if params.hasScriptCrashed == nil then
        params.hasScriptCrashed = false
    end

    scriptExitEventListener = remove_event_listener("exit", scriptExitEventListener)

    if is_thread_runnning(scriptsListThread) then
        scriptsListThread = delete_thread(scriptsListThread)
    end

    -- This will delete notifications from other scripts too.
    -- Suggestion is open: https://discord.com/channels/1088976448452304957/1092480948353904752/1253065431720394842
    if params.clearAllNotifications then
        menu.clear_all_notifications()
    end

    if params.hasScriptCrashed then
        menu.notify("Oh no... Script crashed:(\nYou gotta restart it manually.", SCRIPT_NAME, 6, COLOR.RED)
    end

    menu.exit()
end

local function save_settings(params)
    params = params or {}
    if params.wasSettingsCorrupted == nil then
        params.wasSettingsCorrupted = false
    end

    local file, err = io.open(SCRIPT_SETTINGS__PATH, "w")
    if err then
        handle_script_exit({ hasScriptCrashed = true })
        return
    end

    local settingsContent = ""

    for _, setting in ipairs(ALL_SETTINGS) do
        settingsContent = settingsContent .. setting.key .. "=" .. tostring(setting.feat.on) .. "\n"
    end

    file:write(settingsContent)

    file:close()

    if params.wasSettingsCorrupted then
        menu.notify("Settings file were corrupted but have been successfully restored and saved.", SCRIPT_TITLE, 6, COLOR.ORANGE)
    else
        menu.notify("Settings successfully saved.", SCRIPT_TITLE, 6, COLOR.GREEN)
    end
end

local function load_settings(params)
    local function custom_str_to_bool(string, only_match_against)
        --[[
        This function returns the boolean value represented by the string for lowercase or any case variation;
        otherwise, nil.

        Args:
            string (str): The boolean string to be checked.
            (optional) only_match_against (bool | None): If provided, the only boolean value to match against.
        ]]
        local need_rewrite_current_setting = false
        local resolved_value = nil

        if string == nil then
            return nil, true -- Input is not a valid string
        end

        local string_lower = string:lower()

        if string_lower == "true" then
            resolved_value = true
        elseif string_lower == "false" then
            resolved_value = false
        end

        if resolved_value == nil then
            return nil, true -- Input is not a valid boolean value
        end

        if (
            only_match_against ~= nil
            and only_match_against ~= resolved_value
        ) then
            return nil, true -- Input does not match the specified boolean value
        end

        if string ~= tostring(resolved_value) then
            need_rewrite_current_setting = true
        end

        return resolved_value, need_rewrite_current_setting
    end

    params = params or {}
    if params.settings_to_load == nil then
        params.settings_to_load = {}

        for _, setting in ipairs(ALL_SETTINGS) do
            params.settings_to_load[setting.key] = setting.feat
        end
    end
    if params.isScriptStartup == nil then
        params.isScriptStartup = false
    end

    local settings_loaded = {}
    local areSettingsLoaded = false
    local hasResetSettings = false
    local needRewriteSettings = false
    local settingFileExisted = false

    if utils.file_exists(SCRIPT_SETTINGS__PATH) then
        settingFileExisted = true

        local settings_content, err = read_file(SCRIPT_SETTINGS__PATH)
        if err then
            menu.notify("Settings could not be loaded.", SCRIPT_TITLE, 6, COLOR.RED)
            handle_script_exit({ hasScriptCrashed = true })
            return areSettingsLoaded
        end

        for line in settings_content:gmatch("[^\r\n]+") do
            local key, value = line:match("^(.-)=(.*)$")
            if key then
                if get_collection_custom_value(ALL_SETTINGS, "key", key) then
                    if params.settings_to_load[key] ~= nil then
                        settings_loaded[key] = value
                    end
                else
                    needRewriteSettings = true
                end
            else
                needRewriteSettings = true
            end
        end

        if not ends_with_newline(settings_content) then
            needRewriteSettings = true
        end

        areSettingsLoaded = true
    else
        hasResetSettings = true

        if not params.isScriptStartup then
            menu.notify("Settings file not found.", SCRIPT_TITLE, 6, COLOR.RED)
        end
    end

    for setting, _ in pairs(params.settings_to_load) do
        local resolvedSettingValue = get_collection_custom_value(ALL_SETTINGS, "key", setting, "defaultValue")

        local settingLoadedValue, needRewriteCurrentSetting = custom_str_to_bool(settings_loaded[setting])
        if settingLoadedValue ~= nil then
            resolvedSettingValue = settingLoadedValue
        end
        if needRewriteCurrentSetting then
            needRewriteSettings = true
        end

        params.settings_to_load[setting].on = resolvedSettingValue
    end

    if not params.isScriptStartup then
        if hasResetSettings then
            menu.notify("Settings have been loaded and applied to their default values.", SCRIPT_TITLE, 6, COLOR.ORANGE)
        else
            menu.notify("Settings successfully loaded and applied.", SCRIPT_TITLE, 6, COLOR.GREEN)
        end
    end

    if needRewriteSettings then
        local wasSettingsCorrupted = settingFileExisted or false
        save_settings({ wasSettingsCorrupted = wasSettingsCorrupted })
    end

    return areSettingsLoaded
end
---- Global functions 2/2 END

---- Global event listeners START
scriptExitEventListener = event.add_event_listener("exit", function(f)
    handle_script_exit({ clearAllNotifications = true })
end)
---- Global event listeners END
-- Globals END


local unnecessaryPermissions = {}
local missingPermissions = {}

for _, flag in ipairs(TRUSTED_FLAGS) do
    if menu.is_trusted_mode_enabled(flag.bitValue) then
        if not flag.isRequiered then
            table.insert(unnecessaryPermissions, flag.menuName)
        end
    else
        if flag.isRequiered then
            table.insert(missingPermissions, flag.menuName)
        end
    end
end

if #unnecessaryPermissions > 0 then
    local unnecessaryPermissionsMessage = "You do not require the following " .. pluralize("permission", #unnecessaryPermissions) .. ":\n"
    for _, permission in ipairs(unnecessaryPermissions) do
        unnecessaryPermissionsMessage = unnecessaryPermissionsMessage .. permission .. "\n"
    end
    menu.notify(unnecessaryPermissionsMessage, SCRIPT_NAME, 6, COLOR.ORANGE)
end

if #missingPermissions > 0 then
    local missingPermissionsMessage = "You need to enable the following " .. pluralize("permission", #missingPermissions) .. ":\n"
    for _, permission in ipairs(missingPermissions) do
        missingPermissionsMessage = missingPermissionsMessage .. permission .. "\n"
    end
    menu.notify(missingPermissionsMessage, SCRIPT_NAME, 6, COLOR.RED)

    handle_script_exit()
end


-- === Main Menu Features === --
local myRootMenu = menu.add_feature(SCRIPT_TITLE, "parent", 0)

local exitScript = menu.add_feature("#FF0000DD#Stop Script#DEFAULT#", "action", myRootMenu.id, function()
    handle_script_exit({ clearAllNotifications = true })
end)
exitScript.hint = 'Stop "' .. SCRIPT_NAME .. '"'

local rootDividerMenu = menu.add_feature("       " .. string.rep(" -", 23), "action", myRootMenu.id)

local scriptsListMenu = menu.add_feature("Scripts List", "parent", myRootMenu.id)
scriptsListMenu.hint = "An alphabetically sorted list of all Rockstar scripts, displaying the number of instances for each."

local showInactiveScripts = menu.add_feature("Show Inactive Scripts", "toggle", scriptsListMenu.id)
showInactiveScripts.hint = "When enabled, displays both active and inactive scripts."

menu.add_feature(" " .. string.rep(" -", 23), "action", scriptsListMenu.id)

local filterSearch = menu.add_feature("  Filter: <None>", "action", scriptsListMenu.id, function(f)
    local r, s
    repeat
        r, s = input.get("Enter search query:", "", MAX_STR_LENTH_IN_SCRIPTS_LIST, 0)
        if r == 2 then return HANDLER_POP end
        system.wait(0)
    until r == 0

    if s == "" then
        f.data = nil
    else
        local matches = RE_SCRITPS_NAME_PATTERN:search(s)
        if matches.count > 0 then
            f.data = s
        else
            menu.notify("Input doesn't match Regular Expression:\n" .. tostring("^([a-z0-9_]{1,35})$"), SCRIPT_NAME, 6, COLOR.RED)
        end
    end
end)
filterSearch.hint = "Filter only scripts containing this pattern."

menu.add_feature(" " .. string.rep(" -", 23), "action", scriptsListMenu.id)

local settingsMenu = menu.add_feature("Settings", "parent", myRootMenu.id)
settingsMenu.hint = "Options for logging script activity and display settings."

local logResultsInToastNotifications = menu.add_feature("Log Results in Toast Notificaitons", "toggle", settingsMenu.id)
logResultsInToastNotifications.hint = "Logs found and lost scripts in 2Take1's Toast Notifications."

local logResultsInConsoleOutput = menu.add_feature("Log Results in Console Output", "toggle", settingsMenu.id)
logResultsInConsoleOutput.hint = "Logs found and lost scripts in 2Take1's Console Output."

menu.add_feature("       " .. string.rep(" -", 23), "action", settingsMenu.id)

ALL_SETTINGS = {
    {key = "showInactiveScripts", defaultValue = false, feat = showInactiveScripts},
    {key = "logResultsInToastNotifications", defaultValue = true, feat = logResultsInToastNotifications},
    {key = "logResultsInConsoleOutput", defaultValue = true, feat = logResultsInConsoleOutput}
}

local loadSettings = menu.add_feature('Load Settings', "action", settingsMenu.id, function()
    load_settings()
end)
loadSettings.hint = 'Load saved settings from your file: "' .. HOME_PATH .. "\\" .. SCRIPT_SETTINGS__PATH .. '".\n\nDeleting this file will apply the default settings.'

local saveSettings = menu.add_feature('Save Settings', "action", settingsMenu.id, function()
    save_settings()
end)
saveSettings.hint = 'Save your current settings to the file: "' .. HOME_PATH .. "\\" .. SCRIPT_SETTINGS__PATH .. '".'


load_settings({ isScriptStartup = true })


-- === Main Loop Initialization === --
local scripts_table = {}
for _, scriptName in ipairs(SCRIPTS_LIST) do
    scripts_table[scriptName] = {
        instances = 0,
        feat = menu.add_feature(scriptName, "action_value_i", scriptsListMenu.id)
    }

    local script = scripts_table[scriptName]
    script.feat.mod = 0
    script.feat.min = script.instances
    script.feat.max = script.instances
    script.feat.value = script.instances
    script.feat.hidden = true
end

local activeScriptCounter = 0
local inactiveScriptCounter = #SCRIPTS_LIST
local isFirstLoopIteration = true

-- === Main Loop === --
scriptsListThread = create_tick_handler(function()
    local function generate_found_instance_message(scriptName, currentScriptInstances)
        return '"' .. scriptName .. '"' .. " is active with " .. currentScriptInstances .. " " .. pluralize("instance", currentScriptInstances)
    end

    local function generate_instance_lost_message(scriptName)
        return '"' .. scriptName .. '"' .. " is no longer active"
    end

    local hiddenScriptCounter = 0

    for _, scriptName in ipairs(SCRIPTS_LIST) do
        local script = scripts_table[scriptName]

        local scriptLost = false
        local scriptFound = false
        local scriptAltered = false
        local scriptFiltered = false
        local scriptShowInactive = false
        local scriptHiddenVeridict = false

        local currentScriptInstances = NATIVES.SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(gameplay.get_hash_key(scriptName))

        if filterSearch.data and not string.find(scriptName, filterSearch.data) then
            scriptFiltered = true
        end

        if currentScriptInstances == 0 and script.instances >= 1 then
            scriptLost = true
        elseif currentScriptInstances >= 1 and script.instances == 0 then
            scriptFound = true
        elseif currentScriptInstances ~= script.instances then
            scriptAltered = true
        end

        script.instances = currentScriptInstances

        if scriptFound or scriptLost or scriptAltered then
            script.feat.min = script.instances
            script.feat.max = script.instances
            script.feat.value = script.instances

            local text
            if scriptFound or scriptAltered then
                if scriptFound then
                    inactiveScriptCounter = inactiveScriptCounter - 1
                    activeScriptCounter = activeScriptCounter + 1
                end
                text = generate_found_instance_message(scriptName, script.instances)
            elseif scriptLost then
                activeScriptCounter = activeScriptCounter - 1
                inactiveScriptCounter = inactiveScriptCounter + 1
                text = generate_instance_lost_message(scriptName)
            end

            if logResultsInConsoleOutput.on then
                print(text)
            end
            if logResultsInToastNotifications.on and not isFirstLoopIteration then
                menu.notify(text, SCRIPT_NAME)
            end
        end

        if script.instances <= 0 and not showInactiveScripts.on then
            scriptShowInactive = true
        end

        if scriptFiltered then
            scriptHiddenVeridict = true
        elseif scriptLost or scriptFound or scriptAltered then
            scriptHiddenVeridict = false
        elseif scriptShowInactive then
            scriptHiddenVeridict = scriptShowInactive
        end

        script.feat.hidden = scriptHiddenVeridict

        if scriptFiltered or scriptShowInactive then
            hiddenScriptCounter = hiddenScriptCounter + 1
        end
    end

    filterSearch.name = "  Filter: <" .. (filterSearch.data or "None") .. "> (" .. #SCRIPTS_LIST - hiddenScriptCounter .. ")"

    if isFirstLoopIteration then
        isFirstLoopIteration = false
    end
end)

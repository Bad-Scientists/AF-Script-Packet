func void Startup_InsertVobCatalogue_G1__VobTransport () {
	var int vobPtr;

	var float pos[3];
	var float at[3];
	var float up[3];
	var float right[3];

	var int trafo[16];
	NewTrafo(_@(trafo));

//--

	pos[0] = 0.0; pos[1] = 1000000.0; pos[2] = 0.0;
	at[0] = -0.515039; at[1] = 0.000000; at[2] = 0.857167;
	up[0] = 0.000000; up[1] = 1.000000; up[2] = 0.000000;
	right[0] = 0.857167; right[1] = 0.000000; right[2] = 0.515039;

	vectorPosToTrf (_@f (pos), _@ (trafo));
	zMAT4_SetAtVector (_@ (trafo), _@f (at));
	zMAT4_SetUpVector (_@ (trafo), _@f (up));
	zMAT4_SetRightVector (_@ (trafo), _@f (right));

//--	[VOBs]
//--	Planks and pieces of wood

	vobPtr = InsertObject ("zCVob", "VOB_BUY_BEAM_G", "beam_g.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BEAM_ML", "beam_ml.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BEAM_MS", "beam_ms.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BEAM_T", "beam_t.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_HANDRAIL_V1", "min_lob_handrail_1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_HANDRAIL_V2", "min_lob_handrail_2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_HANDRAIL_V3", "min_lob_handrail_3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKS_2X3M", "min_lob_planks_2x3m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKS_2X4M", "min_lob_planks_2x4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKS_2X5M", "min_lob_planks_2x5m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKS_3X7M", "min_lob_planks_3x7m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKS_3X11M", "min_lob_planks_3x11m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_HOUSEPLANKS", "nc_lob_houseplanks.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_LOG_V1", "nc_lob_log1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_LOG_V2", "nc_lob_log2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_LOG_V3", "nc_lob_log3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_PLANKS_V1", "nc_planks_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARONSLEDGE_V1", "oc_baronsledge_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DUNGEON_PLANKS", "oc_dungeon_planks.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANK_INDOOR", "oc_lob_plank_indoor.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANK_INDOOR_BIG", "oc_lob_plank_indoor_big.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANK_INDOOR_LARGE", "oc_lob_plank_indoor_large.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKBROKEN_SMALL", "oc_lob_plankbroken_small.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKBROKEN_SMALL2", "oc_lob_plankbroken_small2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_MOB_BRAKER", "oc_mob_braker.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STABLE_PLANKS", "oc_stable_planks.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_PLANKS_2X3M", "orc_planks_2x3m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SQUAREPLANKS_2X3M", "orc_squareplanks_2x3m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FENCE_V1", "ow_lob_fence_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FENCE_V2", "ow_lob_fence_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FENCE_V3", "ow_lob_fence_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WOODPLANKS_V1", "ow_lob_woodplanks_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WOODPLANKS_V2", "ow_lob_woodplanks_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WOODPLANKS_V3", "ow_lob_woodplanks_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WOODPLANKS_V4", "ow_lob_woodplanks_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WOODPLANKS_V5", "ow_lob_woodplanks_v5.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORETRAIL_PLANK_V1", "ow_oretrail_plank_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORETRAIL_PLANK_V2", "ow_oretrail_plank_v02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PALISSADE", "ow_palissade.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TROLLPALISSADE", "ow_trollpalissade.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TUNNELCOVER", "ow_tunnelcover.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_LOG_V1", "pc_lob_log1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_LOG_V2", "pc_lob_log2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_STANDINGWORKPLANK_5X7M", "min_lob_standingworkplank_5x7m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WINKELSTEG", "min_lob_winkelsteg.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WORKPLANK_4X6M", "min_lob_workplank_4x6m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WORKPLANK_5X7M", "min_lob_workplank_5x7m.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_COVER_4X7M", "min_lob_cover_4x7m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_MELTER", "min_lob_melter.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_OREHEAP", "nc_oreheap.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_OREHEAP_PFX", "nc_oreheap_pfx.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OREHEAP_SMALL_01", "om_oreheap_small_01.3ds", _@ (trafo), 0);

//--	Structures

	vobPtr = InsertObject ("zCVob", "VOB_BUY_SOLDIERSHUT", "min_lob_soldiershut.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OLDSAWHOUSE_V1", "oc_oldsawhouse_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_TOWER_V1", "orc_tower_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BROKENHUT", "ow_brokenhut.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_LONEHUT", "ow_lonehut.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_LOOKOUT", "ow_lookout.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_LAKEHUT", "ow_o_lakehut.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_PLANKHUTII", "ow_plankhutii.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHIPWRECK_BUG", "ow_shipwreck_bug.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHIPWRECK_TAIL", "ow_shipwreck_tail.3ds", _@ (trafo), 0);

//--	Furniture

	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_BED_V1", "dt_bed_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_BOOKS_V1", "dt_books_01.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_CARPET_ROUND_01", "dt_carpet_round_01.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_CHAINBOX", "dt_chainbox.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_CRATE_V1", "dt_crate_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_CRATE_V2", "dt_crate_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_FIREPLACE_V1", "dt_fireplace_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_FIREPLACE_V2", "dt_fireplace_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_SHELF_V1", "dt_shelf_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_TABLE_V1", "dt_table_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_TABLE_V2", "dt_table_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_TABLE_V3", "dt_table_v3.3ds", _@ (trafo), 0);



	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_BAR_TABLE_V1", "nc_lob_bar_table1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NICE_V1", "nc_lob_nice.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NICE_V2", "nc_lob_nice2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_TABLE_V1", "nc_lob_table1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_TABLE_V2", "nc_lob_table2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECOWALL_V1", "oc_decowall_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECOWALL_V2", "oc_decowall_02.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREPLACE_HUGE", "oc_lob_fireplace_huge.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHELF_V1", "oc_lob_shelf_1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TABLE_EBA", "oc_lob_table_eba.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TABLE_HEAVY", "oc_lob_table_heavy.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TABLE_HEAVY_LONG", "oc_lob_table_heavy_long.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DESK", "oc_mob_desk.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHELVES_BIG", "oc_mob_shelves_big.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHELVES_MEDIUM", "oc_mob_shelves_medium.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SHELVES_SMALL", "oc_mob_shelves_small.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TABLE_NORMAL_DEFECT", "oc_mob_table_normal_defect.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_PICTURE_V1", "oc_picture_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_PICTURE_V2", "oc_picture_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SHELF_V1", "oc_shelf_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SHELF_V2", "oc_shelf_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SHELF_V3", "oc_shelf_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SHELF_V4", "oc_shelf_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_TABLE_V1", "oc_table_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_TABLE_V1_DESTR", "oc_table_v1_destroyed.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_TABLE_V2", "oc_table_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_TABLE_V2_DESTR", "oc_table_v2_destroyed.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_TABLE_V3", "oc_table_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_THRONE_GROUND", "oc_throne_ground.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ARMORHOLDER", "oc_weapon_armorholder.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ARMORSHOES", "oc_weapon_armorshoes.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_V1", "oc_weapon_shelf_empty_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_V2", "oc_weapon_shelf_empty_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_NEW_V1", "oc_weapon_shelf_new_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_NEW_V2", "oc_weapon_shelf_new_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_OLD_V1", "oc_weapon_shelf_old_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WSE_OLD_V2", "oc_weapon_shelf_old_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_WALLARMOR", "oc_weapon_wallarmor.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORETABLE", "om_oretable.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_BED_V1", "orc_bed_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_E_BED", "orc_e_bed.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_VASE_V1", "orc_vase_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_FIREPLACE", "pc_fireplace.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_TABLE_V1", "pc_lob_table1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_TABLE_V2", "pc_lob_table2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_SHOP_V1", "pc_shop_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_DECOHEAD_V1", "tpl_decohead_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_DOORDECO_V1", "tpl_doordeco_v1.3ds", _@ (trafo), 0);

//--	Skeletons

	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_SKELETON_V01", "dt_skeleton_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_SKELETON_V01_HEAD", "dt_skeleton_v01_head.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_SKELETON_V02", "dt_skeleton_v02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_BIRDFRIGHTENER", "nc_birdfrightener.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GALGEN", "oc_lob_galgen.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GALGEN_V2", "oc_lob_galgen_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_E_DEKO_02", "orc_e_deko_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKELETON_V1", "orc_skeleton_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKELETON_V2", "orc_skeleton_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKELETON_V3", "orc_skeleton_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKELETON_V4", "orc_skeleton_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKULLSONFLOOR", "orc_skullsonfloor.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_SKULLSONSTAFF", "orc_skullsonstaff.3ds", _@ (trafo), 0);

//--	Bridges

	vobPtr = InsertObject ("zCVob", "VOB_BUY_FMC_BRIDGE_BOTTOM", "fmc_bridge_bottom.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FMC_BRIDGE_TOP", "fmc_bridge_top.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGE_30M", "min_lob_bridge_30m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGE_4X4M", "min_lob_bridge_4x4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGE_ANGEL_4M", "min_lob_bridge_angel_4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGERAMP", "min_lob_bridgeramp.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGESTAND", "min_lob_bridgestand.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGESTAND_02", "min_lob_bridgestand_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BRIDGE_3X4M", "orc_e_bridge_3x4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BIGBRIDGE", "ow_o_bigbridge.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BIGBRIDGEMIDDLE", "ow_o_bigbridgemiddle.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_V1", "pc_bridge_1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_V2", "pc_bridge_2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_V3", "pc_bridge_3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_V4", "pc_bridge_4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_ROOF_1", "pc_bridge_roof_1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_LOB_BRIDGE", "pc_lob_bridge.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_LOB_BRIDGE2", "pc_lob_bridge2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_LOB_BRIDGE3", "pc_lob_bridge3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_PLANK_BIG", "pc_lob_bridge_plank_big.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_PLANK_HUGE", "pc_lob_bridge_plank_huge.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_PLANK_MINI", "pc_lob_bridge_plank_mini.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_BRIDGE_PLANK_SMALL", "pc_lob_bridge_plank_small.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGE_V1", "tpl_bridge_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGE_V2", "tpl_bridge_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGEBROKEN_V1", "tpl_evt_bridgebroken_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGEFUNCTIONAL_V1", "tpl_evt_bridgefunctional_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGESTONE_V1", "tpl_evt_bridgestone_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGESTONE_V2", "tpl_evt_bridgestone_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_BRIDGEWHEEL_V1", "tpl_evt_bridgewheel_01.3ds", _@ (trafo), 0);

//--	Plants

	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSHES_V1", "ow_bushes_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_REED_V1", "ow_lob_bush_reed_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V1", "ow_lob_bush_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V2", "ow_lob_bush_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V4", "ow_lob_bush_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V5", "ow_lob_bush_v5.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V7", "ow_lob_bush_v7.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_V8", "ow_lob_bush_v8.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BUSH_WATER_V1", "ow_lob_bush_water_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DEADTREE_07", "ow_lob_deadtree_07.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PSIBUSHES_V1", "ow_lob_psibushes_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_RICEPLANT_COUPLE", "ow_lob_riceplant_couple.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_RICEPLANT_ONE", "ow_lob_riceplant_one.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_MUSHROOM_V1", "ow_mushroom_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_MUSHROOM_V2", "ow_mushroom_v2.3ds", _@ (trafo), 0);

//--	Trees and roots

	vobPtr = InsertObject ("zCVob", "VOB_BUY_HANGHIM_TREE_V3", "ow_forest_hanghim_tree_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DEADTREE_04", "ow_lob_deadtree_04.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DEADTREE_06", "ow_lob_deadtree_06.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DEADTREE_07", "ow_lob_deadtree_07.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_DESTROYED_V2", "ow_lob_tree_destroyed_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_ROOT_V1", "ow_lob_tree_root_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_ROOT_V2", "ow_lob_tree_root_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V13", "ow_lob_tree_v13.3ds", _@ (trafo), 0);


	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOREST_TREE_V1", "ow_forest_tree_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOREST_TREE_V2", "ow_forest_tree_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOREST_TREE_V3", "ow_forest_tree_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOREST_TREE_V4", "ow_forest_tree_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOREST_TREE_V5", "ow_forest_tree_v5.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V2", "ow_lob_tree_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V3", "ow_lob_tree_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V4", "ow_lob_tree_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V5", "ow_lob_tree_v5.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V6", "ow_lob_tree_v6.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V8", "ow_lob_tree_v8.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V9", "ow_lob_tree_v9.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V10", "ow_lob_tree_v10.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V11", "ow_lob_tree_v11.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREE_V12", "ow_lob_tree_v12.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREEGROUP_V1", "ow_lob_treegroup_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREEGROUP_V2", "ow_lob_treegroup_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TREEGROUP_V3", "ow_lob_treegroup_v3.3ds", _@ (trafo), 0);

//-- Decorative objects

	vobPtr = InsertObject ("zCVob", "VOB_BUY_COLDUMMY", "coldummy.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OPENEGG", "cr_di_openegg.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_SLIME", "cr_di_slime.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREPLACE_V1", "dt_fireplace_v1.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_E_WALL_V1", "orc_e_wall.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_E_WALL_V2", "orc_e_wall_02.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_MASTERTHRONE", "orc_masterthrone.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CAVEWEBS_V1", "ow_cavewebs_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CAVEWEBS_V2", "ow_cavewebs_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOCUS_V1", "ow_focus_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOCUS_V2", "ow_focus_v02.3ds", _@ (trafo), 0);


	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARRELHOLDER_V1", "oc_barrelholder_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARREL_V1", "oc_barrel_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARREL_V1_DESTROYED", "oc_barrel_v1_destroyed.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARREL_V2", "oc_barrel_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARREL_V2_DESTROYED", "oc_barrel_v2_destroyed.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARRELS_REIHE", "oc_barrels_reihe.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BARRELS_STRUBBELIG", "oc_barrels_strubbelig.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHICKENSTICK_CHICKEN_V1", "oc_chickenstick_chicken_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHICKENSTICK_V1", "oc_chickenstick_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHICKENSTICK_V2", "oc_chickenstick_v02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHIMNEY_V1", "oc_chimney_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHIMNEY_V2", "oc_chimney_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECORATE_V1", "oc_decorate_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECORATE_V2", "oc_decorate_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECORATE_V3", "oc_decorate_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECORATE_V4", "oc_decorate_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECORATE_V5", "oc_decorate_v5.3ds", _@ (trafo), 0);


	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECOROOF_V1", "oc_decoroof_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_DECOROOF_V2", "oc_decoroof_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_FIREPLACE_V1", "oc_fireplace_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_FIREPLACE_V2", "oc_fireplace_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_FIREPLACE_V3", "oc_fireplace_v3.3ds", _@ (trafo), 0);
	//there is no V4 file
	//vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_FIREPLACE_V4", "oc_fireplace_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_FIREPLACE_V5", "oc_fireplace_v5.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREPLACEBIG_V1", "oc_fireplacebig_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREPLACEBIG_CHICKEN_V1", "oc_fireplacebig_v01_chicken_v01.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREWOOD_V1", "oc_firewood_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREWOOD_V2", "oc_firewood_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FIREWOOD_V3", "oc_firewood_v3.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_GARBAGE_V1", "oc_garbage_v1.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_KITCHENSTUFF_V1", "oc_kitchenstuff_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_LEATHERSTAND_V1", "oc_leatherstand_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BOWTRAIN", "oc_lob_bowtrain.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHAIN", "oc_lob_chain.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CHAIN_ALONE", "oc_lob_chain_alone.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_FLAG_SMALL", "oc_lob_flag_small.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_WASTER", "oc_lob_waster.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SACK_V1", "oc_sack_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SACK_V2", "oc_sack_v02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SACK_V3", "oc_sack_v03.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SAECKE_V1", "oc_saecke_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_SAECKE_V2", "oc_saecke_02.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_WELL_V1", "oc_well_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OREBOX_01", "om_orebox_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BROKENCART", "orc_brokencart.3ds", _@ (trafo), 0);


	vobPtr = InsertObject ("zCVob", "VOB_BUY_FOCUSPLATTFORM", "ow_focusplattform.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_PENTAGRAM_V1", "dt_2nd_floor_bannkreis.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PENTAGRAM_V2", "dt_2nd_floor_bannkreis_02.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_LIGHTER_PENTAGRAM", "dt_lighter_pentagramm.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DT_TORCH_V1", "dt_torch_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_LIGHTER", "nc_lob_lighter.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_BIGLIGHTER_V1", "oc_biglighter_01.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TORCHHOLDER_FILLED", "oc_lob_torchholder_filled.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_LIGHTER_HUGE3", "oc_lob_lighter_huge3.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V1", "orc_fireplace_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V2", "orc_fireplace_v2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V3", "orc_fireplace_v3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V4", "orc_fireplace_v4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V5", "orc_fireplace_v5.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_FIREPLACE_V6", "orc_fireplace_v6.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_STANDING_LAMP", "orc_standing_lamp.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_STANDING_LAMP_LARGE", "orc_standing_lamp_large.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_WALL_FIRE_V1", "orc_wall_fire_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_WALL_FIRE_V2", "orc_wall_fire_02.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_MAGICSTAFF_V1", "ow_magicstaff_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_CRYSTALLIGHT_V2", "pc_crystallight_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_FIREBOWL", "pc_lob_firebowl.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_LIGHTER_V1", "tpl_lighter_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_LIGHTER_V2", "tpl_lighter_v2.3ds", _@ (trafo), 0);

//--	Stones and ores

	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V1_10", "min_cob_stone_v1_10.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V2_10", "min_cob_stone_v2_10.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V3_10", "min_cob_stone_v3_10.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_COUPLESTONES", "min_lob_couplestones.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STOMPERSTAND", "min_lob_stomperstand.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V1_30", "min_lob_stone_v1_30.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V2_30", "min_lob_stone_v2_30.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V3_30", "min_lob_stone_v3_30.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V3_40", "min_lob_stone_v3_40.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V3_50", "min_lob_stone_v3_50.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V1_20", "min_mob_stone_v1_20.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V2_20", "min_mob_stone_v2_20.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_STONE_V3_20", "min_mob_stone_v3_20.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORE_BIG_V1", "min_ore_big_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORE_BIG_V2", "min_ore_big_v2.3ds", _@ (trafo), 0);

//--	Statues and processed stone

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_STATUE_V1", "orc_statue_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_STATUE_V2", "orc_statue_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_STATUE_V3", "orc_statue_03.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OSTA_AXE2", "osta_axe2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_E_COLUMN", "orc_e_column.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_SLEEPER_V2", "pc_lob_sleeper2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_SLEEPER_V3", "pc_lob_sleeper3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_PC_SLEEPER_V4", "pc_lob_sleeper4.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_ORCSTATUE", "tpl_orcstatue.3ds", _@ (trafo), 0);

	//--

	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_FLOOR_V1", "evt_castel_floor_1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_FLOOR_V2", "evt_castel_floor_2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_FLOOR_V3", "evt_castel_floor_3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_FLOOR_V4", "evt_castel_floor_4.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_FLOOR_V5", "evt_castel_floor_5.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_PLATE", "evt_castel_plate.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_LIFT_V1", "evt_castle_lift_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_LIFT_V2", "evt_castle_lift_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_CASTLE_LIFT_V3", "evt_castle_lift_03.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DECOSTONE_01_DAEMON", "evt_tpl_decostone_01_daemon.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DECOSTONE_01_DOORS_V1", "evt_tpl_decostone_01_doors_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DECOSTONE_01_DOORS_V2", "evt_tpl_decostone_01_doors_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DECOSTONE_01_MUMMY", "evt_tpl_decostone_01_mummy.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_DECOSTONE_01_TARGET", "evt_tpl_decostone_01_target.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PILLAR_V1", "evt_tpl_pillar_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_STONECEILING_V1", "evt_tpl_stoneceiling_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STONE", "oc_lob_stone.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STONEBROKEN", "oc_lob_stonebroken.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_BROKEN_COLUMN", "orc_broken_column.3ds", _@ (trafo), 0);


	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_MOVER_01_3X5XM", "orc_mover_01_3x5xm.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_MOVER_01_5X9M", "orc_mover_01_5x9m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_ELEVATOR_V1", "tpl_evt_elevator_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_ELEVATORSTONE_1X1M", "tpl_evt_elevatorstone_1x1m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_HINT_V1", "tpl_evt_hint_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_HINT_V2", "tpl_evt_hint_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_JUMPPLATE_V1", "tpl_evt_jumpplate_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_NORMALSTONE_1X1M", "tpl_evt_normalstone_1x1m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PLATEFIRE_V1", "tpl_evt_platefire_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PLATEMOON_V1", "tpl_evt_platemoon_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PLATESUN_V1", "tpl_evt_platesun_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PLATEWATER_V1", "tpl_evt_platewater_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_PURPURSKULLSTONE_1X1M", "tpl_evt_purpurskullstone_1x1m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_SECRETSTONE_V1", "tpl_evt_secretstone_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_SECRETWALL_V1", "tpl_evt_secretwall_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_SECRETWALL_V2", "tpl_evt_secretwall_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_TPL_TARGETSTONE_V1", "tpl_evt_targetstone_01.3ds", _@ (trafo), 0);

//--	Metal cages & grids

	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_MAINGATE01", "evt_nc_maingate01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE01_V1", "evt_oc_maingate01_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE01_V2", "evt_oc_maingate01_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE01_V3", "evt_oc_maingate01_03.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE02_V1", "evt_oc_maingate02_01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE02_V2", "evt_oc_maingate02_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_MAINGATE02_V3", "evt_oc_maingate02_03.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_GITTERKAEFIG_4X4M", "evt_tpl_gitterkaefig_4x4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_GITTERKAEFIG_4X5M", "evt_tpl_gitterkaefig_4x5m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_OREHEAP_FENCE", "nc_oreheap_fence.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_KITCHEN", "oc_gate_kitchen.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_WELL", "oc_gate_well.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_CAGE", "oc_lob_cage.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_CAGE2", "oc_lob_cage2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_BIG", "oc_lob_gate_big.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_SMALL", "oc_lob_gate_small.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_SMALL2", "oc_lob_gate_small2.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_GATE_SMALL3", "oc_lob_gate_small3.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ORC_GATE_5X5M", "orc_gate_5x5m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OW_ARENA_FENCE", "ow_arena_fence.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_METALTHORNS_2X2X05M", "evt_tpl_metalthorns_2x2x05m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_METALTHORNS_4X4X4M", "evt_tpl_metalthorns_4x4x4m.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_METALTHORNS_DEADLY", "evt_tpl_metalthorns_deadly.3ds", _@ (trafo), 0);

//--	Others

	vobPtr = InsertObject ("zCVob", "VOB_BUY_ARCH_V1", "dt_2nd_floor_gewoelbe.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_ARCH_V2", "dt_3rd_floor_gewoelbe.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BOOKSHELF_V1", "dt_bookshelf_v1.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_BOOKSHELF_V2", "dt_bookshelf_v2.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_NC_STAIRS_V1", "nc_stairs_v01.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STAIRS_V1", "oc_stairs_v01.3ds", _@ (trafo), 0);

	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STAIRS_V2", "oc_lob_stairs_02.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STAIRS_V3", "oc_lob_stairs_03.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STAIRS_V5", "oc_lob_stairs_05.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_STAIRS_V10", "oc_lob_stairs_10.3ds", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_OC_LOB_STAIRS_ROUND", "oc_lob_stairs_round.3ds", _@ (trafo), 0);


//--	[MOBs]

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_GROUND", "FIREPLACE_GROUND.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CAMP");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_LARGE.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_GROUND2", "FIREPLACE_GROUND2.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CAMP");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_LARGE.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_HIGH", "FIREPLACE_HIGH.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_MEDIUM.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_HIGH2", "FIREPLACE_HIGH2.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_MEDIUM.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_MIDDLE", "FIREPLACE_MIDDLE.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_NCSTONE", "FIREPLACE_NCSTONE.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_NCSTONE2", "FIREPLACE_NCSTONE2.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_PCHIGH", "FIREPLACE_PCHIGH.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_PCHIGH2", "FIREPLACE_PCHIGH2.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_FIREPLACE_ORCSTAND", "FIREPLACE_ORCSTAND.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_TORCH");
	oCMobInter_SetUseWithItem (vobPtr, "ITLSTORCHBURNING");
//	oCMobInter_SetSceme (vobPtr, "FIREPLACE");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_SMALL.ZEN");

	vobPtr = InsertMobFire ("VOB_BUY_CRYSTALLIGHT", "PC_CRYSTALLIGHT_02.3DS", _@ (trafo));
	//oCMobInter_SetSceme (vobPtr, "PC");
	oCMobFire_SetFireSlot (vobPtr, "BIP01 FIRE");
	oCMobFire_SetFireVobtreeName (vobPtr, "FIRETREE_PSI_MEDIUM.ZEN");




	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_2", "LADDER_2.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_3", "LADDER_3.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_4", "LADDER_4.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_5", "LADDER_5.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_6", "LADDER_6.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_7", "LADDER_7.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_8", "LADDER_8.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_9", "LADDER_9.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	vobPtr = InsertObject ("oCMobLadder", "VOB_BUY_LADDER_10", "LADDER_10.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LADDER");
//	oCMobInter_SetSceme (vobPtr, "LADDER");

	//oCMobInter
	vobPtr = InsertObject ("oCMobWheel", "VOB_BUY_WHEEL", "VWHEEL_1_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_WHEEL");
//	oCMob_SetOwnerStr (vobPtr, "", "GIL_GRD ");
//	oCMobInter_SetSceme (vobPtr, "VWHEEL");
//	oCMobInter_SetConditionFunc (vobPtr, "WHEEL_INTRO_COND");
//	oCMobInter_SetOnStateFuncName (vobPtr, "WHEEL_INTRO_STATE");

	vobPtr = InsertMobContainer ("VOB_BUY_CRATE_V1", "CHESTSMALL_OCCRATESMALL.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CRATE");
//	oCMobInter_SetSceme (vobPtr, "CHESTSMALL");

	vobPtr = InsertMobContainer ("VOB_BUY_CRATE_V2", "CHESTSMALL_OCCRATESMALLLOCKED.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CRATE");
//	oCMobInter_SetSceme (vobPtr, "CHESTSMALL");

	vobPtr = InsertMobContainer ("VOB_BUY_CRATE_V3", "CHESTBIG_OCCRATELARGE.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CRATE");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_CRATE_V4", "CHESTBIG_OCCRATELARGELOCKED.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CRATE");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V5", "CHESTSMALL_OCCHESTSMALL.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTSMALL");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V6", "CHESTSMALL_OCCHESTSMALLLOCKED.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTSMALL");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V7", "CHESTBIG_OCCHESTMEDIUM.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V8", "CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V9", "CHESTBIG_OCCHESTLARGE.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_CHEST_V10", "CHESTBIG_OCCHESTLARGELOCKED.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_CHEST");
//	oCMobInter_SetSceme (vobPtr, "CHESTBIG");

	vobPtr = InsertMobContainer ("VOB_BUY_ORC_MUMMY", "CHESTBIG_ORCMUMMY.ASC", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_ORC_MUMMY");
	oCMobInter_SetSceme (vobPtr, "CHESTBIG");


	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_1_OC", "CHAIR_1_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_1_NC", "CHAIR_1_NC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_1_PC", "CHAIR_1_PC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_2_OC", "CHAIR_2_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_2_NC", "CHAIR_2_NC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_3_OC", "CHAIR_3_OC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_3_PC", "CHAIR_3_PC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CHAIR");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CHAIR_THRONE", "CHAIR_THRONE.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_THRONE");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BENCH_THRONE", "BENCH_THRONE.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_THRONE");
//	oCMobInter_SetSceme (vobPtr, "CHAIR");

	//Beds are actually oCMobDoor objects - and have to be oCMobDoor objects !
	//vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BED_V1", "LOVEBED_OC.ASC", _@ (trafo), 0);
	vobPtr = InsertMobDoor ("VOB_BUY_BED_V1", "BED_1_OC.ASC", _@ (trafo));
	//vobPtr = InsertMobDoor ("VOB_BUY_BED_V1", "BED_1_OC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BED_V1", "BED_1_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
        oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BED_V2", "BED_2_OC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BED_V2", "BED_2_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
        oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDHIGH_1_OC", "BEDHIGH_1_OC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDHIGH_1_OC", "BEDHIGH_1_OC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDHIGH_2_OC", "BEDHIGH_2_OC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDHIGH_2_OC", "BEDHIGH_2_OC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDHIGH_PC", "BEDHIGH_PC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDHIGH_PC", "BEDHIGH_PC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDHIGH_PSI", "BEDHIGH_PSI.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDHIGH_PSI", "BEDHIGH_PSI.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDLOW_NC", "BEDLOW_NC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDLOW_NC", "BEDLOW_NC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDLOW_OC", "BEDLOW_OC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDLOW_OC", "BEDLOW_OC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDLOW_PC", "BEDLOW_PC.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDLOW_PC", "BEDLOW_PC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertMobDoor ("VOB_BUY_BEDLOW_PSI", "BEDLOW_PSI.ASC", _@ (trafo));
	//vobPtr = InsertObject ("oCMobBed", "VOB_BUY_BEDLOW_PSI", "BEDLOW_PSI.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BED");
//	oCMobInter_SetSceme (vobPtr, "BED");
	oCMobInter_SetOnStateFuncName (vobPtr, "SLEEPABIT");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GRINDSTONE", "BSSHARP_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_GRINDSTONE");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiSwordblade");
//	oCMobInter_SetSceme (vobPtr, "BSSHARP");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Sharp_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_CAULDRON", "CAULDRON_OC.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_CAULDRON");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiScoop");
//	oCMobInter_SetSceme (vobPtr, "CAULDRON");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_ANVIL", "BSANVIL_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_ANVIL");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiSwordrawhot");
//	oCMobInter_SetSceme (vobPtr, "BSANVIL");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Anvil_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BSFIRE", "BSFIRE_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_FORGE");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiSwordraw");
//	oCMobInter_SetSceme (vobPtr, "BSFIRE");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Forge_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BSCOOL", "BSCOOL_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BUCKET");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiSwordbladehot");
//	oCMobInter_SetSceme (vobPtr, "BSCOOL");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BENCH_OC_V1", "BENCH_1_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BENCH");
//	oCMobInter_SetSceme (vobPtr, "BENCH");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BENCH_OC_V2", "BENCH_2_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BENCH");
//	oCMobInter_SetSceme (vobPtr, "BENCH");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BENCH_OC_V3", "BENCH_3_OC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BENCH");
//	oCMobInter_SetSceme (vobPtr, "BENCH");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BENCH_NC_V1", "BENCH_1_NC.ASC", _@ (trafo), 0);
        oCMob_SetMobName (vobPtr, "MOBNAME_BENCH");
//	oCMobInter_SetSceme (vobPtr, "BENCH");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_REPAIR_PLANK", "REPAIR_PLANK.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_REPAIR");
	oCMobInter_SetUseWithItem (vobPtr, "ItMiHammer");
//	oCMobInter_SetSceme (vobPtr, "REPAIR");

	vobPtr = InsertMobDoor ("VOB_BUY_DOOR_WOODEN", "DOOR_WOODEN.MDS", _@ (trafo));
	oCMob_SetMobName (vobPtr, "MOBNAME_DOOR");
//	oCMob_SetOwnerStr (vobPtr, "", "GIL_GRD");
//	oCMobInter_SetSceme (vobPtr, "DOOR");
//	oCMobLockable_SetPickLockStr (vobPtr, "LLRRLRL");
	oCMobDoor_SetAddName (vobPtr, "FRONT");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BARBQ_SCAV", "BARBQ_SCAV.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BARBQ_SCAV");
	oCMobInter_SetSceme (vobPtr, "BARBQ");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_PAN", "PAN_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_PAN");
//	oCMobInter_SetSceme (vobPtr, "PAN");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Pan_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_LAB_PSI", "LAB_PSI.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_LAB");
//	oCMobInter_SetSceme (vobPtr, "LAB");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Alchemy_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BOOKSTAND", "BOOK_BLUE.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BOOK");
//	oCMobInter_SetSceme (vobPtr, "BOOK");
//	oCMobInter_SetOnStateFuncName (vobPtr, "OC_BOOKSTAND_CORRISTO_A");


	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_HERB_PSI", "HERB_PSI.MDS", _@ (trafo), 0);
	oCMobInter_SetUseWithItem (vobPtr, "ITMISTOMPER");
//	oCMobInter_SetSceme (vobPtr, "HERB");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_ORE_GROUND", "ORE_GROUND.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_ORE");
//	oCMobInter_SetSceme (vobPtr, "ORE");
//	oCMobInter_SetOnStateFuncName (vobPtr, "Mining_Dialog");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_STOMPER", "STOMPER_OM.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_STOMPER");
//	oCMobInter_SetSceme (vobPtr, "STOMPER");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_STONEMILL", "STONEMILL_OM.MDS", _@ (trafo), 0);
	oCMobInter_SetSceme (vobPtr, "STONEMILL");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BELLOW_MINE", "BELLOW_MINE.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_BELLOW");
//	oCMobInter_SetSceme (vobPtr, "BELLOW");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_EXCALIBUR_1", "EXCALIBUR_1.ASC", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_SWORDSTONE");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_PRIESTGRAVE_OT", "PRIESTGRAVE_OT.MDS", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_SPORTAL_SLEEPER", "SPORTAL_SLEEPER.MDS", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_TOUCHPLATE_STONE", "TOUCHPLATE_STONE.MDS", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_SMOKE_WATERPIPE", "SMOKE_WATERPIPE.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_WATERPIPE");

	//oCMobSwitch:oCMobInter:oCMOB:zCVob
	//TURNSWITCH_BLOCK.MDS

	//oCMobWheel:oCMobInter:oCMOB:zCVob
	//OC_THRONE_BIG
	//THRONE_BIG.ASC
	//BaronsThrone

	vobPtr = InsertObject ("oCMobSwitch", "VOB_BUY_TURNSWITCH_BLOCK", "TURNSWITCH_BLOCK.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_SWITCH");

	vobPtr = InsertObject ("oCMobSwitch", "VOB_BUY_LEVER", "LEVER_1_OC.MDS", _@ (trafo), 0);
	oCMob_SetMobName (vobPtr, "MOBNAME_SWITCH");
//	oCMobInter_SetTriggerTarget (vobPtr, "CAGEDOORS");
//	oCMobInter_SetSceme (vobPtr, "LEVER");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_ORCDRUM_1", "ORCDRUM_1.ASC", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BATHTUB_WOODEN", "BATHTUB_WOODEN.ASC", _@ (trafo), 0);
	//oCMobInter_SetSceme (vobPtr, "BATHTUB");

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BABEBED_1", "BABEBED_1.ASC", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_LOVEBED_OC", "LOVEBED_OC.ASC", _@ (trafo), 0);

	vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BARRELO_OC", "BARRELO_OC.ASC", _@ (trafo), 0);

	//vobPtr = InsertObject ("oCMobInter", "VOB_BUY_HOUSE_01", "HOUSETEST.ASC", _@ (trafo), 0);
	vobPtr = InsertObject ("zCVob", "VOB_BUY_HOUSE_01", "HOUSETEST.ASC", _@ (trafo), 0);

/*
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BACKPACK_1", "BACKPACK_1.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BARREL_1_OC", "BARREL_1_OC.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BARREL_2_OC", "BARREL_2_OC.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BARRELMOUNTED_OC", "BARRELMOUNTED_OC.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_BASKET_RICE", "BASKET_RICE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_ROPEWAY_OW", "ROPEWAY_OW.ASC", _@ (trafo), 0);

vobPtr = InsertObject ("oCMobInter", "VOB_BUY_DRUM_IE", "DRUM_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_M2PIPE_IE", "M2PIPE_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MCELLO_IE", "MCELLO_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MDRUMSCHEIT_IE", "MDRUMSCHEIT_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MHARP_IE", "MHARP_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MLUTE_IE", "MLUTE_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MPIPE_IE", "MPIPE_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_PAUKE_IE", "PAUKE_IE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MOB_GONG", "MOB_GONG.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_MOB_PAUKE", "MOB_PAUKE.ASC", _@ (trafo), 0);

vobPtr = InsertObject ("oCMobInter", "VOB_BUY_FIREPLACE_GROUND_USE", "FIREPLACE_GROUND_USE.MDS", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GRAVE_ORC_1", "GRAVE_ORC_1.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GRAVE_ORC_2", "GRAVE_ORC_2.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GRAVE_ORC_3", "GRAVE_ORC_3.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GRAVE_ORC_4", "GRAVE_ORC_4.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_GROUND_SLOT", "GROUND_SLOT.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_IDOL_SLEEPER3_PC", "IDOL_SLEEPER3_PC.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_IDOL_PILLAR_7M", "PILLAR_7M.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_IDOL_PILLAR_ORC", "PILLAR_ORC.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_PUSH_STONE", "PUSH_STONE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_PUSH_STONE_M01", "PUSH_STONE_M01.MDS", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_SCAV_MEAT", "SCAV_MEAT.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_SECRETDOOR_STONE", "SECRETDOOR_STONE.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_THRONE_BIG", "THRONE_BIG.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_VOBBOX_1", "VOBBOX_1.ASC", _@ (trafo), 0);
vobPtr = InsertObject ("oCMobInter", "VOB_BUY_WASH_SLOT", "WASH_SLOT.MDS", _@ (trafo), 0);
*/
};

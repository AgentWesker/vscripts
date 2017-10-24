//===================================\\
// Entity Cleaner script by Luffaren  (STEAM_0:1:22521282)
// ***********************************
// This script is made to clean up all entities in the map
// Could be useful for OnRoundEnd in order to lower the general edict count
// 
// [NOTE]
// To clean all entities, call CleanEntities(); 
// It will clean all entities except for permanent ones, game-breaking ones, weapons and !self
// It will also ignore all entities by pre-template targetnames, fill in the list below
// It is suggested to use a game_weapon_manager separately to keep weapons cleaned
// 
//===================================\\

ignored_targetnames <- [
"skybox_s6_slide",
"g_rain",
"i_rain",
"skybox_cloud",
"skybox_s6_mountain",
"skybox_s1_sea",
"skybox_s3_land",
"skybox_s2_land",
"skybox_s6_tower",
"g_spawnmodelprop",
"skybox_s2_sea",
"skybox_s2_land2",
"skybox_s1_monster",
"skybox_s3_tower",
"event_math",
"event_relay_case",
"event_case_zm",
"event_case_s1",
"event_case_s2",
"event_case_s3",
"event_case_s4",
"event_case_s5",
"event_case_s6",
"event_case_s7",
"event_case_math",
"event_relay_targettrigger",
"fireuserfix",
"characterdamagefilter",
"game_winning_zwarning",
"game_winning_relay",
"music_win_relay",
"HURT_ALL",
"CLEAR_ALL",
"stage_win_1",
"stage_win_2",
"stage_win_3",
"stage_win_4",
"stage_win_5",
"stage_win_6",
"stage_win_",
"stage_win_",
"game_winning_trigger_ctcheck",
"wincheck_trigger",
"skybox_s6_towertop",
"skybox_skybox",
"s3_tower_model",
"s6_chapeltop",
"s6_chapeltop_slide",
"s1_boat_human",
"s1_boat_zombie",
"i_boar_coll",
"i_boar_model",
"elevator_model",
"elevator_collision",
"boss_phys",
"boss_gaibon_model",
"boss_slogra_model",
"boss_ogre_model",
"boss_swampmonster_model",
"boss_spiderqueen_model",
"boss_snowtitan_model"];

function CleanEntities()
{
	local h = Entities.First();
	while(null!=(h=Entities.Next(h)))
	{
		local cn = h.GetClassname();
		local ignore = false;
		local nn = h.GetPreTemplateName();
		for(local ll=0;ll<ignored_targetnames.len();ll+=1)
		{if(nn==ignored_targetnames[ll]){ignore=true;break;}}
		local isweapon = false;
		if(cn.len()>6&&cn.slice(0,7)=="weapon_")isweapon = true;
		if(h!=null&&h.IsValid()&&h!=self&&!isweapon&&!ignore
		&&cn!="func_brush"
		&&cn!="info_target"
		&&cn!="player"
		&&cn!="logic_auto"
		&&cn!="worldspawn"
		&&cn!="cs_team_manager"
		&&cn!="cs_player_manager"
		&&cn!="game_round_end"
		&&cn!="func_illusionary"
		&&cn!="env_fog_controller"
		&&cn!="env_tonemap_controller"
		&&cn!="sky_camera"
		&&cn!="func_buyzone"
		&&cn!="info_player_terrorist"
		&&cn!="info_player_counterterrorist"
		&&cn!="func_areaportalwindow"
		&&cn!="info_teleport_destination"
		&&cn!="player_speedmod"
		&&cn!="func_areaportal"
		&&cn!="info_player_start"
		&&cn!="game_player_equip"
		&&cn!="logic_measure_movement"
		&&cn!="point_servercommand"
		&&cn!="point_clientcommand"
		&&cn!="env_cubemap"
		&&cn!="soundent"
		&&cn!="cs_gamerules"
		&&cn!="vote_controller"
		&&cn!="water_lod_control"
		&&cn!="point_template"
		&&cn!="filter_activator_team"
		&&cn!="filter_activator_name"
		&&cn!="filter_activator_class"
		&&cn!="filter_multi"
		&&cn!="skybox_swapper"
		&&cn!="func_clip_vphysics"
		&&cn!="ai_network"
		&&cn!="env_cascade_light"
		&&cn!="predicted_viewmodel"
		&&cn!="scene_manager"
		&&cn!="wearable_item"
		&&cn!="weaponworldmodel"
		&&cn!="game_weapon_manager")
			EntFireByHandle(h,"Kill","",0.00,null,null);
	}
}


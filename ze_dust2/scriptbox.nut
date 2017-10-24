level <- 0;
extreme <- 0;

function NukeZombies() {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
		if (ent.GetTeam() == 2) {
			EntFireByHandle(ent, "SetHealth", "1", 0.0, null, null);
			EntFireByHandle(ent, "AddOutput", "targetname Hurt", 0.0, null, null);
			//EntFireByHandle(ent, "AddOutput", "max_health 9999", 0.0, null, null);
		}
	}
	EntFire("hurtentity", "Hurt", 0);
	//EntFire("command", "Command", "say Nuked", 0);
}

function NukeHumans() {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
		if (ent.GetTeam() == 3) {
			EntFireByHandle(ent, "SetHealth", "1", 0.0, null, null);
			EntFireByHandle(ent, "AddOutput", "targetname Hurt", 0.0, null, null);
		}
	}
	EntFire("hurtentity", "Hurt", 0);
}

function ResetPlayers() {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
			EntFireByHandle(ent, "AddOutput", "targetname default", 0.0, null, null);
			EntFireByHandle(ent, "AddOutput", "gravity 1", 0.0, null, null);
			DoEntFire("speed", "ModifySpeed", "1", 0.0, ent, ent);
	}
}

function SetGravity(grav) {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
			EntFireByHandle(ent, "AddOutput", "gravity " + grav, 0.0, null, null);
	}
}

function SetSpeed(speed) {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
			DoEntFire("speed", "ModifySpeed", "" + speed, 0.0, ent, ent);
	}
}

function TeleportLeftovers() {
	local ent=null;
	while((ent = Entities.FindByClassname(ent,"player")) != null)
	{
		if (ent.GetName() == "Human") {
			EntFireByHandle(ent, "AddOutput", "targetname default", 0.0, null, null);
			continue;
		}
		ent.SetOrigin(Vector(-1500.0, -984.0, 147.0));
		EntFireByHandle(ent, "AddOutput", "targetname default", 0.0, null, null);
	}
}

function SetLevel(num) {
	level = num;
}

function GetLevel() {
	if (level == 0) {
		EntFire("ze_*", "kill", "", 0.0);
		EntFire("command", "Command", "say ...", 10.0);
		EntFire("command", "Command", "say ...wtf, why are we playing dust2?", 15.0);
		EntFire("command", "Command", "say **Switching map in 10 seconds**", 25.0);
		EntFire("scriptbox", "RunScriptCode", "NukeZombies();", 35.0);
		EntFire("scriptbox", "RunScriptCode", "SetLevel(1);", 35.0);
	} else if (level == 1) {
		EntFire("ze_*", "kill", "", 0.0);
		EntFire("scriptbox", "RunScriptCode", "SpawnZMProps();", 0.0);
		EntFire("command", "Command", "say **Switching map failed...**", 0.0);
		EntFire("command", "Command", "say **Survive for 120 seconds**", 5.0);
		EntFire("scriptbox", "RunScriptCode", "NukeZombies();", 125.0);
		EntFire("scriptbox", "RunScriptCode", "SetLevel(2);", 125.0);
	} else if (level == 2) {
		EntFire("scriptbox", "RunScriptCode", "SpawnZEProps();", 0.0);
		EntFire("command", "Command", "say **Let's try escaping this time!**", 1.0);
		EntFire("command", "Command", "say **Maybe there is a boss with lasers at the end!**", 2.0);
	} else if (level == 3) {
		EntFire("ze_*", "kill", "", 0.0);
		EntFire("scriptbox", "RunScriptCode", "SpawnZMProps();", 0.0);
		EntFire("command", "Command", "say **Survival part 2...**", 2.0);
		EntFire("command", "Command", "say **Survive for 120 seconds**", 5.0);
		EntFire("scriptbox", "RunScriptCode", "NukeZombies();", 125.0);
		EntFire("scriptbox", "RunScriptCode", "SetLevel(4);", 125.0);
	} else if (level == 4) {
		EntFire("ze_*", "kill", "", 0.0);
		EntFire("scriptbox", "RunScriptCode", "SpawnZMProps();", 0.0);
		EntFire("command", "Command", "say **Final Level**", 0.0);
		EntFire("scriptbox", "RunScriptCode", "SetLevel(2);", 20.0);
		
		EntFire("scriptbox", "RunScriptCode", "SetGravity(0.3);", 3.0);
		EntFire("scriptbox", "RunScriptCode", "SetSpeed(1.2);", 3.0);
		
		EntFire("scriptbox", "RunScriptCode", "SetGravity(0.3);", 10.0);
		EntFire("scriptbox", "RunScriptCode", "SetSpeed(1.2);", 10.0);
		
		EntFire("scriptbox", "RunScriptCode", "SetGravity(0.3);", 20.0);
		EntFire("scriptbox", "RunScriptCode", "SetSpeed(1.2);", 20.0);
		
		EntFire("scriptbox", "RunScriptCode", "SetGravity(0.3);", 30.0);
		EntFire("scriptbox", "RunScriptCode", "SetSpeed(2.0);", 30.0);
		
		EntFire("scriptbox", "RunScriptCode", "SetGravity(0.3);", 40.0);
		EntFire("scriptbox", "RunScriptCode", "SetSpeed(2.0);", 40.0);
		EntFire("scriptbox", "RunScriptCode", "NukeZombies();", 80.0);
	}
	
	if (extreme > 0) {
		local worldspawn = null;
		worldspawn = Entities.FindByClassname(null, "worldspawn");
		worldspawn.__KeyValueFromString("skyname", "embassy");
		EntFire("env_sun", "TurnOff", "", 0.0);
		EntFire("ze_a_rocks1", "kill", "", 1.0);
		EntFire("ze_a_door_off", "AddOutput", "targetname ze_a_door_extreme", 1.0);
		EntFire("ze_mid_rocks1", "AddOutput", "targetname ze_a_door_extreme", 1.0);
		EntFire("env_tonemap_controller", "SetBloomScale", "0", 0.0);
		EntFire("env_tonemap_controller", "SetTonemapPercentBrightPixels", "0", 0.0);
		EntFire("env_tonemap_controller", "SetTonemapMinAvgLum", "0", 0.0);
		EntFire("postprocess_controller", "SetFadeToBlackStrength", "0.3", 0.0);
		EntFire("env_fog_controller", "SetStartDist", "100.0", 0.0);
		EntFire("env_fog_controller", "SetEndDist", "900.0", 0.0);
		EntFire("env_fog_controller", "TurnOn", "", 0.0);
		EntFire("env_fog_controller", "SetColor", "155 155 155", 0.0);
		EntFire("env_fog_controller", "SetFarZ", "-1", 0.0);
		EntFire("env_fog_controller", "AddOutput", "fogmaxdensity 1.0", 0.0);
		EntFire("command", "Command", "say **EXTREME mode activated**", 1.0);
		EntFire("extreme_logic", "RunScriptCode", "RunLogic();", 10.0);
	}
	
	EntFire("prop_dynamic_override", "DisableShadow", "", 0.4);
}

function SetExtreme(num) {
	extreme = num;
}

precache <- 0;

function PrecacheModels() {
	if (precache == 0) {
		self.PrecacheModel("models/props_wasteland/rock_cliff01.mdl");
		self.PrecacheModel("models/props_fortifications/concrete_wall001_96_reference.mdl");
		self.PrecacheModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
		self.PrecacheModel("models/props/gg_vietnam/stairfenceshort.mdl");
		self.PrecacheModel("models/props_interiors/table_picnic.mdl");
		self.PrecacheModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
		self.PrecacheModel("models/props_mill/freightelevatorbutton01.mdl");
		self.PrecacheModel("models/props_mill/freightelevatorbutton02.mdl");
		self.PrecacheModel("models/props_unique/wooden_barricade.mdl");
		self.PrecacheModel("models/props/de_aztec/statue01.mdl");
		self.PrecacheModel("models/props_wasteland/exterior_fence002c.mdl"); 
		self.PrecacheModel("models/props/gg_vietnam/stairfenceshort_wood.mdl");
		
		precache = 1;
	}
}

function SpawnZMProps() {
	local ent = null;
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_wall1");
	ent.__KeyValueFromString("renderamt", "255");
	ent.__KeyValueFromString("rendercolor", "255 255 255");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_fortifications/concrete_wall001_96_reference.mdl");
	ent.SetOrigin(Vector(632.0, 400.0, -0.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_wall2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_fortifications/concrete_wall001_96_reference.mdl");
	ent.SetOrigin(Vector(578.0, 522.0, -0.0));
	ent.SetAngles(0.0, 270.0, 0.0);

	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb_picnic");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_interiors/table_picnic.mdl");
	ent.SetOrigin(Vector(808.0, 995.0, 20.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(743.0, 1012.0, 70.0));
	ent.SetAngles(90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(743.0, 1092.0, 70.0));
	ent.SetAngles(-90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(871.0, 1012.0, 70.0));
	ent.SetAngles(90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(871.0, 1092.0, 70.0));
	ent.SetAngles(-90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climb3");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(807.0, 1092.0, 107.0));
	ent.SetAngles(-90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climbbarrier");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(889.0, 1154.0, 122.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_climbbarrier");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "750");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_nuke/hr_nuke/nuke_concrete_barrier/nuke_concrete_barrier.mdl");
	ent.SetOrigin(Vector(730.0, 1154.0, 122.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_doors_platform1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(1439.0, 320.0, 69.0));
	ent.SetAngles(90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_a_platform1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(792.0, 2177.0, 125.0));
	ent.SetAngles(-90.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_a_platform2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(792.0, 2175.0, 130.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_b_wall1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(-1911.0, 2767.0, 30.0));
	ent.SetAngles(0.0, 339.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_b_wall2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(-1562.0, 1981.0, 5.0));
	ent.SetAngles(0.0, 100.5, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_spawn_platform1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(-1724.0, 123.0, 156.0));
	ent.SetAngles(70.0, 180.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_spawn_platform2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(-1605.0, 123.0, 152.0));
	ent.SetAngles(90.0, 0.0, -180.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_mid_climb0");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/exterior_fence002c.mdl");
	ent.SetOrigin(Vector(-442.0, 1266.0, 65.0));
	ent.SetAngles(-90.0, 180.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_mid_climb1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/exterior_fence002c.mdl");
	ent.SetOrigin(Vector(-442.0, 1395.0, 65.0));
	ent.SetAngles(-90.0, 180.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "zm_mid_climb2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/exterior_fence002c.mdl");
	ent.SetOrigin(Vector(-442.0, 1524.0, 65.0));
	ent.SetAngles(-90.0, 180.0, 0.0);

}

function SpawnZEProps() {
	local ent = null;
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_spawn_rocks");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(-780.0, -796.0, 360.0));
	ent.SetAngles(0.0, 270.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_spawn_rocks2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(-415.0, -183.0, 238.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_spawn_rocks3");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(4.0, 298.0, 232.0));
	ent.SetAngles(0.0, 43.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_doors_door");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "600");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_unique/wooden_barricade.mdl");
	ent.SetOrigin(Vector(652.0, 763.0, 0.0));
	ent.SetAngles(0.0, 334.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_doors_rocks1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(1210.0, 895.0, 60.0));
	ent.SetAngles(0.0, 270.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_doors_rocks2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(1692.0, 672.0, 34.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_doors_door2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort_wood.mdl");
	ent.SetOrigin(Vector(1438.0, 1390.0, 0.0));
	ent.SetAngles(0.0, 270.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_doors_door2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort_wood.mdl");
	ent.SetOrigin(Vector(1428.0, 1396.0, 75.0));
	ent.SetAngles(-13.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_rocks1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(1150.0, 2396.0, 215.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_rocks2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(877.0, 2396.0, 150.0));
	ent.SetAngles(-10.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_wall1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/gg_vietnam/stairfenceshort.mdl");
	ent.SetOrigin(Vector(530.0, 2224.0, 130.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_door");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_aztec/statue01.mdl");
	ent.SetOrigin(Vector(-135.0, 2098.0, -153.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_door");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_aztec/statue01.mdl");
	ent.SetOrigin(Vector(-167.0, 2173.0, -153.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_door_off");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_aztec/statue01.mdl");
	ent.SetOrigin(Vector(190.0, 1489.0, 0.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_a_door_off");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "1200");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_aztec/statue01.mdl");
	ent.SetOrigin(Vector(191.0, 1397.0, 0.0));
	ent.SetAngles(0.0, 0.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_mid_rocks1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(-419.0, 1680.0, 74.0));
	ent.SetAngles(0.0, 180.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_mid_rocks2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/rock_cliff01.mdl");
	ent.SetOrigin(Vector(-238.0, 900.0, 75.0));
	ent.SetAngles(0.0, 229.5, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_hall_fence1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props_wasteland/exterior_fence002c.mdl");
	ent.SetOrigin(Vector(-1663.0, 973.0, 108.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-1910.0, -913.0, 271.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall1");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-3142.0, -913.0, 271.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall2");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-677.0, -725.0, 271.0));
	ent.SetAngles(0.0, 270.0, 0.0);

	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall22");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-1910.0, -666.0, 271.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall3");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-1909.0, -725.0, 271.0));
	ent.SetAngles(0.0, 270.0, 0.0);

	ent = Entities.CreateByClassname("prop_dynamic_override");
	ent.__KeyValueFromString("targetname", "ze_boss_wall33");
	ent.__KeyValueFromString("fademindist", "-1");
	ent.__KeyValueFromString("fademaxdist", "2500");
	ent.__KeyValueFromString("solid", "6");
	ent.SetModel("models/props/de_train/hr_t/wall_relief_a/wall_relief_a.mdl");
	ent.SetOrigin(Vector(-3142.0, -666.0, 271.0));
	ent.SetAngles(0.0, 90.0, 0.0);
	
}
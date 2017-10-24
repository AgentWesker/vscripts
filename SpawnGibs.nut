function SpawnWoodDebris(pos, ang){
	ent <- CreateProp("prop_dynamic_override", pos, "models/lotr/minas_madera_exp_GO.mdl", 0);
	ent.SetAngles(ang.x, ang.y, ang.z);
	ent.SetAbsOrigin(pos);
	EntFireByHandle(ent, "Break", "", 0.02, null, null);
}

function SpawnBrickDebris(pos, ang){
	ent <- CreateProp("prop_dynamic_override", pos, "models/lotr/debris_group_blocks_GO.mdl", 0);
	ent.SetAngles(ang.x, ang.y, ang.z);
	ent.SetAbsOrigin(pos);
	EntFireByHandle(ent, "Break", "", 0.02, null, null);
}

function SpawnWallDebris(pos, ang){
	ent <- CreateProp("prop_dynamic_override", pos, "models/lotr/minas_muralla_1_br_GO.mdl", 0);
	ent.SetAngles(ang.x, ang.y, ang.z);
	ent.SetAbsOrigin(pos);
	EntFireByHandle(ent, "Break", "", 0.02, null, null);
}


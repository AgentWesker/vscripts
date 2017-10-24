//===================================\\
// script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

function Start(dists,fires)
{
	if(caller==null||!caller.IsValid())return;
	local p = null;while(null != (p = Entities.FindInSphere(p,caller.GetOrigin(),dists+maxdist)))
	{
		if(p.GetClassname()=="prop_dynamic" ||
		p.GetClassname()=="prop_physics" ||
		p.GetClassname()=="func_physbox" ||
		p.GetClassname()=="func_physbox_multiplayer" ||
		p.GetClassname()=="func_button" ||
		p.GetClassname()=="func_breakable")
		FireHit(p,fires,dists);
	}
}

function FireHit(e,fire,dist)
{
	local ofs = GetOffset(e);if(ofs==null)return;
	local ofsz = e.GetOrigin();
	ofsz.z += ofs.y;
	local ds = GetDistanceByVector(caller.GetOrigin(), ofsz);
	if(ds <= (dist+ofs.x))
	{
		for(local i=0;i<fire.len();i+=1)
		{
			EntFireByHandle(e, "FireUser"+fire[i], "", 0.00, caller, caller);
		}
	}
}

function GetDistanceByVector(vector1, vector2)
{
	return sqrt((vector1.x-vector2.x)*(vector1.x-vector2.x) + 
				(vector1.y-vector2.y)*(vector1.y-vector2.y) + 
				(vector1.z-vector2.z)*(vector1.z-vector2.z));
}

//---------------------------------------------------------------------------------------\\
//KEEP THIS UPDATED WHEN CHANGING THE LIST BELOW!
maxdist <- 540;	//TODO: set/update this to the largest "ofs.x" value from the list below!!!

function GetOffset(e)
{
	local en = e.GetPreTemplateName();
	if(en == "g_hitdetect")						return Vector(384,0,0);
	else if(en=="boss_phys_32_1")				return Vector(24,0,0);
	else if(en=="boss_phys_32_2")				return Vector(24,0,0);
	else if(en=="boss_phys_32_3")				return Vector(24,0,0);
	else if(en=="boss_phys_32_4")				return Vector(24,0,0);
	else if(en=="boss_phys_64_5")				return Vector(48,0,0);
	else if(en=="boss_phys_64_4")				return Vector(48,0,0);
	else if(en=="boss_phys_64_3")				return Vector(48,0,0);
	else if(en=="boss_phys_64_2")				return Vector(48,0,0);
	else if(en=="boss_phys_64_1")				return Vector(48,0,0);
	else if(en=="boss_phys_128_1")				return Vector(196,0,0);
	else if(en=="s6_snowbreak")					return Vector(350,0,0);
	else if(en=="i_boar_detect")				return Vector(40,0,0);
	else if(en=="i_b_civhouse2_modelcoll")		return Vector(500,280,0);
	else if(en=="i_b_stable_modelcoll")			return Vector(320,100,0);
	else if(en=="i_b_civhouse1_modelcoll")		return Vector(540,192,0);
	else if(en=="i_b_guardtower_modelcoll")		return Vector(192,128,0);
	else if(en=="i_seamtent_detector")			return Vector(540,0,0);
	else if(en=="npc_phys")						return Vector(64,48,0);
	else if(en=="i_candle")						return Vector(12,0,0);
	else if(en=="i_tr_dragonhead")				return Vector(32,44,0);
	else if(en=="i_tr_tripwire")				return Vector(128,0,0);
	else if(en=="i_tr_shroom")					return Vector(40,0,0);
	else if(en=="i_rubble_button")				return Vector(192,0,0);
	else if(en=="i_tr_woodholder")				return Vector(100,0,0);
	else if(en=="i_tr_tntstash")				return Vector(124,44,0);
	else if(en=="i_tr_arrowdispenser")			return Vector(100,48,0);
	else if(en=="i_tr_oilbarrel")				return Vector(52,48,0);
	else if(en=="i_tr_logstand")				return Vector(120,32,0);
	else if(en=="i_tr_logstand_break")			return Vector(100,0,0);
	else if(en=="i_tr_chandileerfake")			return Vector(140,-128,0);
	else if(en=="i_tr_lamp")					return Vector(40,52,0);
	else if(en=="i_pr_shack")					return Vector(264,0,0);
	else if(en=="i_pr_breakblock")				return Vector(68,0,0);
	else if(en=="i_pr_stone")					return Vector(320,0,0);
	else if(en=="i_pr_market")					return Vector(360,56,0);
	else if(en=="i_pr_crate")					return Vector(112,64,0);
	else if(en=="i_pr_lamppost")				return Vector(64,-56,0);
	else if(en=="i_pr_candlestand")				return Vector(48,-32,0);
	else if(en=="i_pr_tree2")					return Vector(256,220,0);
	else if(en=="i_pr_tree1")					return Vector(248,220,0);
	else if(en=="boss_phys_512_1")				return Vector(412,0,0);
	else if(en=="boss_phys_spider")				return Vector(256,0,0);
	else if(en=="boss_phys_512_2")				return Vector(412,0,0);
	else if(en=="boss_phys_128_2")				return Vector(96,0,0);
	else if(en=="boss_phys_128_3")				return Vector(96,0,0);
	else if(en=="boss_phys_128_4")				return Vector(96,0,0);
	else if(en=="boss_phys_128_5")				return Vector(96,0,0);
	return null;
}

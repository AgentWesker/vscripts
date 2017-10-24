//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

stop <- false;
givenmessage <- false;
count_ct <- 0;
count_t <- 0;

function CheckZone()
{
	if(!stop)
	{
		if(activator != null&& activator.IsValid() && activator.GetTeam() == 3 && activator.GetHealth()>0)
			count_ct++;
		else if(activator != null&& activator.IsValid() && activator.GetTeam() == 2 && activator.GetHealth()>0)
		{
			count_t++;
			ClampHealthT(activator);
		}
	}
}

function ValidateCheck()
{
	if(count_ct>0&&count_t<=0)
	{
		stop = true;
		KillAllT();
		EntFire("game_winning_relay","FireUser1","",0.05,null);
	}
	else
	{
		if(count_t>0&&!givenmessage)
		{
			givenmessage = true;
			EntFire("server","Command","***KILL ALL ZOMBIES TO WIN***",0.00,null);
			EntFire("server","Command","***KILL ALL ZOMBIES TO WIN***",0.02,null);
			EntFire("server","Command","***KILL ALL ZOMBIES TO WIN***",0.05,null);
			EntFire("server","Command","***KILL ALL ZOMBIES TO WIN***",0.07,null);
			EntFire("server","Command","***KILL ALL ZOMBIES TO WIN***",0.10,null);
		}
		count_ct = 0;
		count_t = 0;
		EntFireByHandle(self,"CountPlayersInZone","",1.00,null,null);
		EntFireByHandle(self,"RunScriptCode"," ValidateCheck(); ",1.50,null,null);
	}
}

function ClampHealthT(ph)
{
	if(ph != null && ph.IsValid() && ph.GetTeam() == 2 && ph.GetHealth()>1000)
		EntFireByHandle(ph, "SetHealth", "1000", 0.00, null, null);
}

function KillAllCT()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 3 && p.GetHealth()>0)
			EntFireByHandle(p, "SetHealth", "-69", 0.00, null, null);
	}
}

function KillAllT()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 2 && p.GetHealth()>0)
			EntFireByHandle(p, "SetHealth", "-69", 0.00, null, null);
	}
}

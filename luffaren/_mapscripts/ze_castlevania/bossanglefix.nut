//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

//PLACE THIS SCRIPT ON THE BOSS MODELS (prop_dynamic) THAT GETS PARENTED TO THE MAIN PHYSBOX
//ONLY UTILIZE THIS FOR MODELS THAT GETS PARENTED TO boss_phys (OTHER/STATIC BOSSES WILL BREAK)
//RUN THE FOLLOWING 0.01 SECS AFTER THE BOSS MODEL GETS PARENTED TO THE MAIN PHYSBOX:
//OnBlah > model > RunScriptCode > CorrectAngle();

ticking <- false;
retries <- 5;		//times to force the angle every 0.1 secs (just to be safe)
bossphys <- null;	//boss_phys func_physbox for the boss
bossteledest <- null;
bossteledestmoved <- false;
bossteleporter <- null;
backup <- "";

//this method repeats 5 times
function CorrectAngle(angle_offset)
{
	//check for boss_phys object, set the variable if it's null
	if(bossphys == null || !bossphys.IsValid())
	{
		retries = 5;
		local p = null;	while(null != (p = Entities.FindByName(p, "boss_phys"))){bossphys = p;}
		if(bossteledest == null || !bossteledest.IsValid())
		{
			retries = 5;
			local pp = null;while(null != (pp = Entities.FindByName(pp, "boss_teleporter_destination"))){bossteledest = pp;}
		}
		if(bossteleporter == null || !bossteleporter.IsValid())
		{
			retries = 5;
			local pp = null;while(null != (pp = Entities.FindByName(pp, "boss_teleporter"))){bossteleporter = pp;}
		}
	}
	//if boss_phys object is valid
	if(bossphys != null && bossphys.IsValid())
	{
		//tick this 5 times, set the !self angle (script must be attached on the boss model) -
		//-to the boss_phys object (doesn't set position, only rotation)
		if(retries > 0)
		{
			local angs = bossphys.GetAngles();
			local final_angle = angs.y + angle_offset;
			if(final_angle  >= 360)
			{
				final_angle  = final_angle - 360;
			}
			if(final_angle  < 0)
			{
				final_angle = final_angle + 360;
			}
			local aofs = " CorrectAngle("+angle_offset+"); ";
			backup = " CorrectAngle("+angle_offset+"); ";
			EntFireByHandle(self, "RunScriptCode",aofs, 0.1, null, null);
			retries--;
			//OLD:  
				//EntFireByHandle(self, "AddOutput", "angles 0 " + final_angle + " 0", 0.00, null, null);
			//NEW:  
				local orgisn = bossphys.GetOrigin()-(bossphys.GetUpVector()*8);
				local orgasm = "origin "+orgisn.x+" "+orgisn.y+" "+orgisn.z;
				local angisn = "angles "+angs.x+" "+(angs.y+270)+" "+angs.z;
				if(self.GetName()=="boss_spiderqueen_model")angisn = "angles "+angs.x+" "+(angs.y)+" "+angs.z;
				EntFireByHandle(self, "ClearParent", "", 0.00, null, null);
				EntFireByHandle(self, "AddOutput", orgasm, 0.02, null, null);
				EntFireByHandle(self, "AddOutput", angisn, 0.02, null, null);
				EntFireByHandle(self, "SetParent", "boss_phys", 0.03, null, null);
		}
		//when it runs out of tries, stop the self-inflicted loop and reset the retry count to 5
		else
			retries = 5;
	}
	if(!ticking)
	{
		ticking = true;
		Tick();
	}
}

function Tick()
{
	if(GetDistanceZ(bossteledest.GetOrigin(),bossphys.GetOrigin())>128)
	{
		if(!bossteledestmoved)
		{
			bossteledestmoved = true;
			local orgisn = bossteledest.GetOrigin();
			orgisn.z+=32;
			local orgasm = "origin "+orgisn.x+" "+orgisn.y+" "+orgisn.z;
			EntFireByHandle(bossteledest,"AddOutput",orgasm,0.00,null,null);
		}
		local orgisn = bossphys.GetOrigin();
		if(self.GetName()=="boss_gaibon_model")
			orgisn = bossphys.GetOrigin()-(bossphys.GetUpVector()*375);
		else if(self.GetName()=="boss_slogra_model")
			orgisn = bossphys.GetOrigin()-(bossphys.GetUpVector()*145);
		else if(self.GetName()=="boss_ogre_model")
			orgisn = bossphys.GetOrigin()-(bossphys.GetUpVector()*295);
		else if(self.GetName()=="boss_spiderqueen_model")
			orgisn = bossphys.GetOrigin()-(bossphys.GetUpVector()*270);
		EntFireByHandle(bossteleporter,"Enable","",0.05,null,null);
		EntFireByHandle(bossteleporter,"Disable","",9.98,null,null);
		EntFireByHandle(bossphys,"Wake","",1.01,null,null);
		EntFireByHandle(bossphys,"EnableMotion","",1.00,null,null);
		EntFireByHandle(self,"RunScriptCode",backup,0.00,null,null);
		EntFireByHandle(self,"RunScriptCode"," Tick(); ",1.00,null,null);
	}
	else
		EntFireByHandle(self,"RunScriptCode"," Tick(); ",0.20,null,null);
}

function GetDistanceZ(v1,v2){return sqrt((v1.z-v2.z)*(v1.z-v2.z));}







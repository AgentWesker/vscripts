//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

spawner <- null;

function Tick()
{
	if(spawner != null && spawner.IsValid())
	{
		local or = self.GetOrigin()+(self.GetUpVector()*60)+(self.GetForwardVector()*56)+(self.GetLeftVector()*(RandomInt(-48,48)));
		local pos = "origin "+or.x+" "+or.y+" "+or.z;
		EntFireByHandle(spawner,"AddOutput",pos,0.00,null,null);
	}
}

function SetSpawner()
{
	spawner = caller;
}

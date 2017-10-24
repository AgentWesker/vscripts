//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

SPEED <- "0.60";
plist <- [];
ticking <- true;

function AddSpeed()
{
	local exists = false;
	for(local i=0;i<plist.len();i+=1){if(plist[i]==activator){exists=true;break;}}
	if(!exists)plist.push(activator);
	EntFire("game_speed","ModifySpeed",SPEED,0.00,activator);
}

function RemoveSpeed()
{
	for(local i=0;i<plist.len();i+=1){if(plist[i]==activator){plist.remove(i);break;}}
	EntFire("game_speed","ModifySpeed","1.0",0.00,activator);
}

function Tick()
{
	if(!ticking)return;
	for(local i=0;i<plist.len();i+=1)
	{	
		if(plist[i]!=null&&plist[i].IsValid()&&plist[i].GetHealth()>0)
			EntFire("game_speed","ModifySpeed",SPEED,0.00,plist[i]);
	}
	EntFireByHandle(self,"RunScriptCode"," Tick(); ",0.20,null,null);
}

function ClearSpeed()
{
	ticking = false;
	for(local i=0;i<plist.len();i+=1)
	{
		if(plist[i]!=null&&plist[i].IsValid()&&plist[i].GetHealth()>0)
			EntFire("game_speed","ModifySpeed","1.0",0.00,plist[i]);
	}
	plist.clear();
}
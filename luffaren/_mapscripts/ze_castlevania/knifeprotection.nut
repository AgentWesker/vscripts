//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

plist <- [];

function ValidatePlayer()
{
	local exists = false;
	for(local i=0;i<plist.len();i+=1)
	{
		if(activator==plist[i])
		{
			exists = true;
			break;
		}
	}
	if(!exists)
	{
		plist.push(activator);
		EntFireByHandle(caller,"FireUser4","",0.00,activator,activator);
	}
}

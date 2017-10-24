//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

locked <- false;

function CheckEffect()
{
	if(!locked)
	{
		LockEffect();
		EntFireByHandle(self,"FireUser4","",0.00,activator,activator);
		EntFireByHandle(self,"RunScriptCode"," UnlockEffect(); ",0.05,activator,activator);
	}
}

function LockEffect()
{
	locked = true;
}

function UnlockEffect()
{
	locked = false;
}
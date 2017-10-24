//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

started <- false;
clist <- [];

function AddPlayer()
{
	clist.push(activator);
	if(!started)
	{
		started = true;
		Tick();
	}
}

function Tick()
{
	for(local i=0;i<clist.len();i+=1)
	{
		if(clist[i]!=null&&clist[i].IsValid()&&clist[i].GetHealth()>0&&clist[i].GetTeam()==3)
			EntFireByHandle(clist[i],"SetDamageFilter","filter_t_no",0.00,null,null);
	}
	EntFireByHandle(self,"RunScriptCode"," Tick(); ",0.40,null,null);
}

//===================================\\
// Ammo script by Wan
// (Modified/fixed by Luffaren)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

function RefillAmmoInRadius(radius)
{
	local originpos = self.GetOrigin();
	local p = null;
	while(null != (p = Entities.FindByClassnameWithin(p,"player",originpos,radius)))
	{
		EntFire("ammo_equip_refill","use","",0.00,p);
	} 
}

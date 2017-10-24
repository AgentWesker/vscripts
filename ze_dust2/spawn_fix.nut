SPAWN_VEC <- Vector(0.0, 0.0, -419.0);
DEST_VEC <- Vector(-420.0, -890.0, 190.0);
self.SetOrigin(SPAWN_VEC);

function TurnOn() {
	local ent = null;

	while ((ent = Entities.FindByClassnameWithin(ent, "player", self.GetOrigin(), 85.0)) != null)
	{
		ent.SetOrigin(DEST_VEC);
	}	
	EntFireByHandle(self, "RunScriptCode", "TurnOn();", 2.5, null, null);
}


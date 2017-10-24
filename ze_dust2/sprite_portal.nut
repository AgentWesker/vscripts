SPAWN_VEC <- Vector(391.0, 85.0, 77.0);
SPAWN_VEC2 <- Vector(64.0, -736.0, 80.0);
VEC_B <- Vector(-1564.0, 2653.0, 55.0);
self.SetOrigin(SPAWN_VEC);

DEST_VEC <- Vector(0.0, 0.0, 0.0);
DEST_VEC_1 <- Vector(666.0, 931.0, 60.0);
DEST_VEC_2 <- Vector(1425.0, 1588.0, 51.0);
DEST_VEC_3 <- Vector(-448.0, 2144.0, -80.0);
DEST_VEC_4 <- Vector(-1856.0, -800.0, 161.0);
DEST_VEC_5 <- Vector(-1500.0, -984.0, 147.0);

humans <- 0;

function SetupPortal(num) {
	if (num == 1) {
		humans = 0;
		DEST_VEC = DEST_VEC_1;
	} else if (num == 2) {
		humans = 0;
		DEST_VEC = DEST_VEC_2;
		self.SetOrigin(DEST_VEC_1);
	} else if (num == 3) {
		humans = 0;
		DEST_VEC = DEST_VEC_3;
		self.SetOrigin(DEST_VEC_2);
	} else if (num == 4) {
		humans = 1;
		DEST_VEC = DEST_VEC_4;
		self.SetOrigin(VEC_B);
	} else if (num == 5) {
		humans = 0;
		DEST_VEC = DEST_VEC_5;
		self.SetOrigin(SPAWN_VEC2);
	}
}

function StartPortal() {
	local ent = null;

	while ((ent = Entities.FindByClassnameWithin(ent, "player", self.GetOrigin(), 85.0)) != null)
	{
		if ((humans == 1) && (ent.GetTeam() == 2)) {
			continue;
		} else if ((humans == 1) && (ent.GetTeam() == 3)) {
			EntFireByHandle(ent, "AddOutput", "targetname Human", 0.0, null, null);
		} 
		ent.SetOrigin(DEST_VEC);
	}	
	EntFireByHandle(self, "RunScriptCode", "StartPortal();", 0.5, null, null);
}


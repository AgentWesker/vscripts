UPPER_VEC <- Vector(-937.0, -706.0, 185.0);
LOWER_VEC <- Vector(-937.0, -706.0, 145.0);
VELOCITY <- Vector(4.0, 0.0, 0.0);
local roll;
roll = RandomInt(1, 2)
if (roll == 1) {
	self.SetOrigin(LOWER_VEC);
} else if (roll == 2) {
	self.SetOrigin(UPPER_VEC);
}
EntFireByHandle(self, "TurnOn", "", 0.001, null, null);
EntFire("ze_beam_sound", "PlaySound", 0.01);
EntFireByHandle(self, "RunScriptCode", "MoveVehicle();", 0.001, null, null);
EntFireByHandle(self, "Kill", "", 5.0, null, null);

function MoveVehicle() {
		self.SetOrigin(self.GetOrigin()-VELOCITY);
		EntFireByHandle(self, "RunScriptCode", "MoveVehicle();", 0.001, null, null);
}


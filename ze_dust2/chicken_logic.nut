const PUSH_SCALE = 120.0;
EntFireByHandle(self, "SetHealth", "5000000", 0.01, null, null);
self.SetOrigin(Vector(0.0, 0.0, -5000.0));
self.PrecacheModel("models/chicken/chicken_zombie.mdl");
self.SetModel("models/chicken/chicken_zombie.mdl");
self.ConnectOutput("OnHealthChanged", "fHealthChanged");

function MoveChicken() {
	self.SetOrigin(Vector(0.0, 0.0, -5000.0));
}

function fHealthChanged() {

	self.SetHealth(90000000);
	
	
	if (activator == null) {
		return;
	}
	
	if (activator.GetClassname() == "player") {
		// Compute the direction vector from player to chicken
		local a = self.GetCenter();
		local b = activator.GetCenter();
		//local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);
		local dir = MakeVectorFromPoints(a, b);
		
		dir.Norm();

		local vel = Vector(PUSH_SCALE * dir.x, PUSH_SCALE * dir.y, PUSH_SCALE * 0.2);

		self.__KeyValueFromVector("basevelocity", vel);
	}
}

function MakeVectorFromPoints(vecA, vecB) {
	local vecDir = Vector(vecA.x - vecB.x, vecA.y - vecB.y, vecA.z - vecB.z);
	return vecDir;
}

//Run function from the player
//
//function TestPlayer() {
//
//	local entChicken = null;
//	entChicken = Entities.FindByClassname(null, "chicken");
//	
//	entChicken.SetHealth(90000000);
//	self.SetHealth(99);
//	
//	if (self.GetClassname() == "player") {
//		// Compute the direction vector from player to ogre
//		local a = entChicken.GetCenter();
//		local b = self.GetCenter();
//		local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);
//
//		dir.Norm();
//
//		local vel = Vector(PUSH_SCALE * dir.x, PUSH_SCALE * dir.y, PUSH_SCALE * 100.0);
//
//		entChicken.__KeyValueFromVector("basevelocity", vel);
//		self.SetHealth(69);
//	}
//}
//
//::TestPlayer <- TestPlayer;
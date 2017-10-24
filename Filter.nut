function filterHolder() {
	if (self.GetMoveParent().GetOwner() == activator)
		EntFireByHandle(self, "FireUser4", "", 0.0, activator, activator)
	else {
		EntFireByHandle(self, "PressIn", "", 0.0, activator, activator)
	}
}

function filterHolderNoIn() {
	if (self.GetMoveParent().GetOwner() == activator)
		EntFireByHandle(self, "FireUser4", "", 0.0, activator, activator)
}

function filterDeath(){
	EntFireByHandle(self.GetOwner(), "SetHealth", "-999999999", 0.0, null, null);
	EntFireByHandle(self.GetOwner(), "SetDamageFilter", "", 0.0, null, null);
	EntFireByHandle(self.GetOwner(), "AddOutput", "max_health 100", 0.0, null, null);
	EntFireByHandle(self.GetOwner(), "AddOutput", "rendermode 0", 0.0, null, null);
	//EntFire("speedMod", "ModifySpeed", "1", 0.0, self.GetOwner());
}

function SaveNameAtSpawn() {
	storedName <- self.GetName();
}

function ResetName() {
	self.__KeyValueFromString("targetname", storedName);
}

function ArmorNearDeath(){
	EntFireByHandle(self, "FireUser1", "", 0.0, self.GetMoveParent(), self.GetMoveParent());
}
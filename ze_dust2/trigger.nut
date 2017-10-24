self.ConnectOutput("OnTrigger", "DoStuff");

function SetupTrigger() {
	self.SetOrigin(Vector(895.0, 496.0, 144.0));
	EntFireByHandle(self, "Enable", "", 0.1, null, null);
	EntFire("command", "Command", "say IM GETTING READY", 0.0);
}

function DoStuff() {
	EntFire("command", "Command", "say IM TRIGGERED", 0.0);
}
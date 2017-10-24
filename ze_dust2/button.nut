function PressButton(num) {
	if (activator.GetTeam() == 2) {
		EntFire("command", "Command", "say **Zombies reached the objective**", 0.0);
		EntFire("scriptbox", "RunScriptCode", "NukeHumans();", 1.5);
		return;
	} else {
		if (num == 1) {
			EntFire("command", "Command", "say **The way will open in 15 seconds**", 0.0);
			EntFire("ze_doors_door", "kill", "", 15.0);
			EntFire("command", "Command", "say **Zombie shortcut is now active**", 25.0);
			EntFire("ze_sprite", "RunScriptCode", "SetupPortal(1);", 25.0);
			EntFire("ze_sprite", "RunScriptCode", "StartPortal();", 25.0);
			EntFire("ze_sprite", "ShowSprite", "", 25.0);
			EntFire("ze_sprite_glow", "ShowSprite", "", 25.0);
		} else if (num == 2) {
			EntFire("command", "Command", "say **The wall will break in 20 seconds**", 0.0);
			EntFire("ze_doors_door2", "kill", "", 20.0);
			EntFire("command", "Command", "say **Zombie shortcut is now active**", 30.0);
			EntFire("ze_sprite", "RunScriptCode", "SetupPortal(2);", 30.0);
		} else if (num == 3) {
			EntFire("command", "Command", "say **The statues will judge you in 20 seconds**", 0.0);
			EntFire("command", "Command", "say **The statues were killed by door huggers**", 20.0);
			EntFire("ze_a_door_extreme", "kill", "", 17.5);
			EntFire("ze_a_door", "kill", "", 20.0);
			EntFire("command", "Command", "say **Zombie shortcut is now active**", 30.0);
			EntFire("ze_sprite", "RunScriptCode", "SetupPortal(3);", 30.0);
			EntFire("ze_mid_rocks1", "kill", "", 30.0);
		} else if (num == 4) {
			EntFire("command", "Command", "say **Hold B for 40 seconds**", 0.0);
			EntFire("command", "Command", "say **10 seconds until escape**", 30.0);
			EntFire("ze_sprite", "RunScriptCode", "SetupPortal(4);", 40.0);
			EntFire("command", "Command", "say **Get in the portal**", 40.0);
			EntFire("command", "Command", "say **Get in the portal**", 41.0);
			EntFire("command", "Command", "say **Get in the portal**", 42.0);
			EntFire("scriptbox", "RunScriptCode", "TeleportLeftovers();", 50.0);
			EntFire("ze_sprite", "RunScriptCode", "SetupPortal(5);", 51.0);
			EntFire("command", "Command", "say **Kill the Boss**", 50.0);
			EntFire("ze_Boss", "RunScriptCode", "BossThink();", 50.0);
		}
	}
}
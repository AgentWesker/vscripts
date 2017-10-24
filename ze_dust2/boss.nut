bossHP <- 600;
active <- 0;
cooldown <- 0;
globalCooldown <- 0.0;
spellspeed <- 0.0;
entPlayer <- null;
entSpellTarget <- null;
entSpellFake <- null;
entSpell <- null;

function BossDamage() {
	if (active == 0) {
		return;
	}
	
	if (bossHP < 1) {
		EntFire("ze_Boss", "break", 0.01);
		EntFire("ze_hud2", "AddOutput", "message DEAD", 0.01);
		EntFire("command", "Command", "say ***You defeated the final boss of the universe***", 1.5);
		EntFire("command", "Command", "say ***Congrats, I guess?***", 1.7);
		EntFire("scriptbox", "RunScriptCode", "SetLevel(3);", 3.0);
		EntFire("scriptbox", "RunScriptCode", "SetExtreme(1);", 3.0);
		EntFire("scriptbox", "RunScriptCode", "NukeZombies();", 3.1);
	} else {
		bossHP--;
		EntFire("ze_hud2", "AddOutput", "message " + bossHP, 0.01);
	}
}

bossSetup <- 0;

function BossThink() {
	if (bossSetup == 0) {
		local ent=null;
		while((ent = Entities.FindByClassname(ent,"player")) != null)
		{
			if (ent.GetTeam() == 3) {
				bossHP += 35;
			}
		}
		EntFire("ze_hud1", "AddOutput", "message Boss HP", 0.01);
		EntFire("ze_hud2", "AddOutput", "message " + bossHP, 0.01);
		active = 1;
		bossSetup = 1;
		cooldown = 4;
		globalCooldown = 3.0;
		spellspeed = 2.0;
	}
	
	if (bossHP > 2000) {
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 3.5, null, null);
	} else if (bossHP > 1000) {
		spellspeed = 1.6;
		globalCooldown = 2.0;
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 3.5, null, null);
	} else if (bossHP > 650) {
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 2.0, null, null);
	} else if (bossHP > 350) {
		globalCooldown = 1.0;
		spellspeed = 1.3;
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 1.5, null, null);
	} else if (bossHP >= 125) {
		spellspeed = 1.0;
		globalCooldown = 0.5;
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 1.1, null, null);
	} else if ((bossHP < 125) && (bossHP > 0)) {
		EntFire("ze_beam_template", "ForceSpawn", 0.01);
		EntFireByHandle(self, "RunScriptCode", "BossThink();", 0.6, null, null);
	}
	
	ChargeSpell();
}

function ResetCooldown(num) {
	cooldown = num;
}

function ChargeSpell() {
	if (cooldown <= 0) {
		cooldown = 9999;
		posvec <- Vector(0.0, 0.0, 0.0);		
		local ValidPlayer = false;
		local ValidPlayerLoop = 0;
		while (ValidPlayer == false) {
			while((entPlayer = Entities.FindByClassname(entPlayer, "player")) != null)
			{
				if ((entPlayer.GetTeam() == 3) && (entPlayer.GetHealth() > 0)) {
					posvec = entPlayer.GetOrigin();
					ValidPlayer = true;
					break;
				}
			}
			if (ValidPlayerLoop > 2) {
				ScriptPrintMessageChatAll("RIP :(");
				active = 0;
				break;
			}
			ValidPlayerLoop++;
		}
		
		entSpellTarget = Entities.FindByName(entSpellTarget, "ze_boss_spell_target")
		entSpellTarget.SetOrigin(posvec);
		entSpellTarget = null;
		entSpellFake = Entities.FindByName(null, "ze_boss_spell_fake");
		entSpell = Entities.FindByName(null, "ze_boss_spell");
		
		EntFireByHandle(entSpellFake, "TurnOn", "", 0.0, entPlayer, entPlayer);
		EntFire("ze_spell_sound", "PlaySound", spellspeed);
		EntFireByHandle(entSpellFake, "TurnOff", "", spellspeed, entPlayer, entPlayer);
		EntFireByHandle(entSpell, "TurnOn", "", spellspeed, entPlayer, entPlayer);
		EntFireByHandle(entSpell, "TurnOff", "", spellspeed + 1.0, entPlayer, entPlayer);
		EntFireByHandle(self, "RunScriptCode", "ResetCooldown(0);", spellspeed + 1.0 + globalCooldown, null, null);
		entPlayer = null;
		entSpellFake = null;
		entSpell = null;
	} else {
		cooldown--;
	}
}
logicToggle <- 1;
targetToggle <- 1;
entPlayer <- null;
entTarget <- null;
entChicken <- null;
entExplode <- null;
entChicken = Entities.FindByClassname(null, "chicken");
entExplode = Entities.FindByClassname(null, "env_explosion");

function RunLogic() {
	if (logicToggle == 1)
	{
		posvec <- Vector(0.0, 0.0, 0.0);
		posvec = entPlayer.GetOrigin();
		posvec.z = posvec.z + 7.0;
		
		entChicken.SetOrigin(posvec);
		//entChicken.SetHealth(90000000);
		EntFire("extreme_chicken_tesla", "TurnOn", "", 0.0);
		targetToggle = 1;
		EntFireByHandle(self, "RunScriptCode", "ChickenTarget();", 0.1, null, null);
		EntFireByHandle(self, "RunScriptCode", "SetTargeting(0);", 3.0, null, null);
		EntFireByHandle(self, "RunScriptCode", "ExplodeChicken();", 4.5, null, null);
		EntFire("extreme_chicken_tesla", "TurnOff", "", 4.5);
		
		EntFireByHandle(self, "RunScriptCode", "RunLogic();", 10.0, null, null);
	}
}

function TargetPlayer() {
	local ValidPlayer = false;
	local ValidPlayerLoop = 0;
	while (ValidPlayer == false) {
		while((entPlayer = Entities.FindByClassname(entPlayer, "player")) != null)
		{
			if ((entPlayer.GetTeam() == 3) && (entPlayer.GetHealth() > 0)) {

				ValidPlayer = true;
				break;
			}
		}
		if (ValidPlayerLoop > 1) {
			logicToggle = 0;
			break;
		}
		ValidPlayerLoop++;
	}
	return entPlayer;
}

function SetTargeting(num) {
	targetToggle = num;
}

function ChickenTarget() {
	if (targetToggle == 1)
	{
		chickenPos <- Vector(0.0, 0.0, 0.0);
		chickenPos = entChicken.GetOrigin();
		
		//entTarget = Entities.FindByClassnameWithin(null, "player", chickenPos, 400.0);
		entTarget = entPlayer;

		if (entTarget) {
			entChicken.EmitSound("c4.click");
			playerPos <- Vector(0.0, 0.0, 0.0);
			playerPos = entTarget.GetOrigin();
			
			//local chickToPlayer = MakeVectorFromPoints(playerPos, chickenPos);
			//chickToPlayer.Norm();
			//chickToPlayer.x = 0.0;
			//chickToPlayer.z = 0.0;
			//local chickForward = entChicken.GetAngles();
			//chickForward.Norm();
			
			local chickAng = entChicken.GetForwardVector();
			chickAng.Norm();
			chickAng.x *= 10;
			chickAng.y *= 10;
			chickAng.z *= 10;
			local chickenPos2 = Vector(chickenPos.x + chickAng.x, chickenPos.y + chickAng.y, chickenPos.z + chickAng.z);
			
			local tYaw = GetTargetYaw(chickenPos,playerPos); //Yaw to target
			local cYaw = GetTargetYaw(chickenPos,chickenPos2); //Yaw Origin
			local yaw = (cYaw - tYaw);
			
			//ScriptPrintMessageChatAll("Yaw = " + yaw);
			chickAng.z = 15;
			
			if (yaw > -20.0 && yaw < 20.0) {
				yaw = 0.0;
				chickAng.x *= 7;
				chickAng.y *= 7;
			} else {
				chickAng.x *= 4.5;
				chickAng.y *= 4.5;
				if (yaw < 0.0) {
					if (yaw < -120.0) {
						yaw = 350.0;
					} else {
						yaw = 130.0;
					}
				} else if (yaw > 0.0) {
					if (yaw > 120.0) {
						yaw = -350.0;
					} else {
						yaw = -130.0;
					}
				}
			}
			entChicken.SetAngularVelocity(0.0, yaw, 0.0);
			entChicken.__KeyValueFromVector("basevelocity", chickAng);
			
			//entChicken.SetForwardVector(chickToPlayer);
			//chickToPlayer.x *= 50;
			//chickToPlayer.y *= 50;
			// //forwardVec.z = 5;
			//entChicken.__KeyValueFromVector("basevelocity", chickToPlayer);
		}
		EntFireByHandle(self, "RunScriptCode", "ChickenTarget();", 0.1, null, null);
	} else {
		local stopVec = Vector(0.0, 0.0, 0.0);
		entChicken.SetAngularVelocity(0.0, 0.0, 0.0);
		entChicken.__KeyValueFromVector("basevelocity", stopVec);
	}
}

function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	yaw-=180;
	if (v.y < 0) {
		yaw=-yaw;
	}
	return yaw;
}

function MakeVectorFromPoints(vecA, vecB) {
	local vecDir = Vector(vecA.x - vecB.x, vecA.y - vecB.y, vecA.z - vecB.z);
	return vecDir;
}

function ExplodeChicken() {
	posvec2 <- Vector(0.0, 0.0, 0.0);
	posvec2 = entChicken.GetOrigin();
	posvec2.z = posvec2.z + 20.0;
	entExplode.SetOrigin(posvec2);
	entChicken.EmitSound("Chicken.Death");
	EntFire("extreme_explosion", "Explode", 0.01);
	EntFireByHandle(entChicken, "RunScriptCode", "MoveChicken();", 0.01, null, null);
}
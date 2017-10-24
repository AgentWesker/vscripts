//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_castlevania/)
//===================================\\

//--------------------\\

SPEED_MOVE <- 1.00;
SPEED_ANGLE <- 1.00;
TARGET_DISTANCE <- 3000;
TARGET_TIME <- 7.00;
HEALTH_BASE <- 1000;
HEALTH_EACH <- 100;
RADIUS_WIDTH <- 80;
RADIUS_HEIGHT <- 120;
STEP_HEIGHT <- 20;
STEP_LENGTH <- 30;
AIRED_LENGTH <- 70;
AIRDEATH_LENGTH <- 700;
HIT_DAMAGE <- 90;

//--------------------\\

MOVE <- true;
ROTATE <- true;
TRIGHT <- false;
TFRONT <- false;
TBACK <- false;
TANGLE <- 0.00;
TARGET <- Vector(0,0,0);
LOOKTARGET <- Vector(0,0,0)
TICKRATE <- 0.10;
TICKRATE_IDLE <- 1.00;
TICKRATE_DEATH <- 0.10;
DELTATIME <- 0.015625;
DEAD <- false;DEADSCALE <- 1.20;DEADALPHA <- 255;DEADCOLOR <- 255;DEAD_CLEANUP <- false;
_THRUSTERSIDE <- null;
_THRUSTER <- null;
PAUSED <- false;

//--------------------\\

ptarget <- null;
ltarget <- null;
target_time <- TARGET_TIME;

function Start()
{
	SetSpeed(SPEED_MOVE,SPEED_ANGLE);
	Tick();
}

function Pause()
{
	PAUSED = true;
}

function Resume()
{
	PAUSED = false;
}

function BehaviourTick()
{
	LOOKTARGET = ptarget.GetOrigin();
	TARGET = ptarget.GetOrigin();
	if(TARGET==null){ptarget=null;FindPlayer();}else
	{
		UpdateMovement();
		EntFireByHandle(_THRUSTER,"Deactivate","",0.00,null,null);
		EntFireByHandle(_THRUSTER,"AddOutput","angles 0 "+TANGLE+" 0",0.00,null,null);
		EntFireByHandle(_THRUSTERSIDE,"Deactivate","",0.00,null,null);
		EntFireByHandle(_THRUSTERSIDE,"AddOutput","force "+(15*SPEED_ANGLE),0.00,null,null);
		if(TRIGHT)EntFireByHandle(_THRUSTERSIDE,"AddOutput","angles 0 90 0",0.00,null,null);
		else EntFireByHandle(_THRUSTERSIDE,"AddOutput","angles 0 270 0",0.00,null,null);
		if(!TFRONT&&ROTATE)EntFireByHandle(_THRUSTERSIDE,"Activate","",0.01,null,null);
		if(MOVE)EntFireByHandle(_THRUSTER,"Activate","",0.01,null,null);
	}
}

function FindPlayer()
{
	local result = null;local hlist = [];local h = null;local spos = GVO(self.GetOrigin(),0,0,44);
	while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),TARGET_DISTANCE)))
	{
		if(ValidPlayer(h,3))
			hlist.push(h);
	}
	if(hlist.len()>0)//=================> target found
	{
		target_time=TARGET_TIME;
		result = hlist[RandomInt(0,hlist.len()-1)];
	}
	else//=================> no target found
	{
		EntFireByHandle(_THRUSTER,"Deactivate","",0.00,null,null);
		EntFireByHandle(_THRUSTERSIDE,"Deactivate","",0.00,null,null);
	}
	return result;
}

//==================================================================================================\\
//==================================================================================================\\
//==================================================================================================\\

function SetEnt(i)
{
	if(i==1)_THRUSTERSIDE=caller;
	else if(i==2)_THRUSTER=caller;
}

function Tick()
{
	if(!PAUSED)
	{
		if(ValidPlayer(ptarget,3))
		{
			BehaviourTick();
			target_time-=(DELTATIME*(TICKRATE/0.01));
			if(target_time<=0.00){ptarget=null;ptarget=FindPlayer();}
		}
		else ptarget = FindPlayer();
	}
	EntFireByHandle(self,"RunScriptCode"," Tick() ",TICKRATE,null,null);
}

function SetSpeed(move,angle)
{
	SPEED_MOVE = move;
	SPEED_ANGLE = angle;
	EntFireByHandle(_THRUSTER,"AddOutput","force "+(850*SPEED_MOVE),0.00,null,null);
	EntFireByHandle(_THRUSTER,"Deactivate","",0.00,null,null);
}

function UpdateMovement()
{
	TFRONT = false;TBACK = false;TRIGHT = false;
	local sa = self.GetAngles().y;
	local ta = GetTargetYaw(self.GetOrigin(),TARGET);TANGLE = ta;
	ta = GetTargetYaw(self.GetOrigin(),LOOKTARGET);
	SPEED_ANGLE = abs(abs(ta)-abs(sa));
	local infront = false;
	if(abs(ta-sa)<2.5)TFRONT = true;
	else if(abs(ta-sa)>135)TBACK = true;
	if((sa-ta+360)%360>180)TRIGHT = true;
}

function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	yaw-=180;if(v.y<0)yaw=-yaw;return yaw;
}

function GGV(vec)
{
	local ground = Vector(vec.x,vec.y,vec.z);ground.z-=50000;
	local r = InSightGet(vec,ground);r.z+=8;return r; 
}

function GetVectorBetween(start,target,units)
{
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	v.Norm();return (start-(v*units));
}

function GetVectorBetweenPercentage(start,target,percentage)//0-100
{
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);v.Norm();
	return (start-(v*(GetDistance(start,target)*(percentage*0.01))));
}

function GVO(vec,_x,_y,_z){return Vector(vec.x+_x,vec.y+_y,vec.z+_z);}
function InSightGet(start,target){local tl=TraceLine(start,target,self);local v=Vector(start.x-target.x,start.y-target.y,start.z-target.z);v.Norm();return (start-(v*(GetDistance(start,target)*tl)));}
function InSight(start,target){if(TraceLine(start,target,self)<1.00)return false;return true;}
function RandomChance(percentage){if(percentage>RandomFloat(0.00,100.00))return true;return false;}
function GetDistance(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}
function GetDistanceXY(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));}
function GetDistanceZ(v1,v2){return sqrt((v1.z-v2.z)*(v1.z-v2.z));}
function ValidHandle(handle){if(handle!=null&&handle.IsValid())return true;return false;}
function ValidPlayer(handle,team)//======>  2T  3CT  <======\\
{if(handle!=null&&handle.IsValid()&&handle.GetClassname()=="player"&&handle.GetTeam()==team&&handle.GetHealth()>0)return true;return false;}

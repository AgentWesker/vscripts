ogre <- null;
const PUSH_SCALE = 40.0;
const PUSH_SCALE_HEAD = 72.0;
const PUSH_SCALE_NAZG = 160.0;

function LoadActivatorAsOgreTarget() 
{
    ogre = activator;
}

function FuckTheOgreUp()
{
    // Leave if either of them is invalid
    if (activator == null || ogre == null) return;

    // Compute the direction vector from player to ogre
    local a = ogre.GetCenter();
    local b = activator.GetCenter();
    local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);

    // Normalize the direction
    dir.Norm();

    // Scale appropiately to get the velocity
    local vel = Vector(PUSH_SCALE * dir.x, PUSH_SCALE * dir.y, PUSH_SCALE * dir.z);

    // Apply onto the ogre
    ogre.__KeyValueFromVector("basevelocity", vel);
}

function FuckTheOgreHeadUp()
{
    // Leave if either of them is invalid
    if (activator == null || ogre == null) return;

    // Compute the direction vector from player to ogre
    local a = ogre.GetCenter();
    local b = activator.GetCenter();
    local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);

    // Normalize the direction
    dir.Norm();

    // Scale appropiately to get the velocity
    local vel = Vector(PUSH_SCALE_HEAD * dir.x, PUSH_SCALE_HEAD * dir.y, PUSH_SCALE_HEAD * dir.z);

    // Apply onto the ogre
    ogre.__KeyValueFromVector("basevelocity", vel);
}

function FuckTheNazgulUp()
{
    // Leave if either of them is invalid
    if (activator == null || ogre == null) return;

    // Compute the direction vector from player to ogre
    local a = ogre.GetCenter();
    local b = activator.GetCenter();
    local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);

    // Normalize the direction
    dir.Norm();

    // Scale appropiately to get the velocity
    local vel = Vector(PUSH_SCALE_NAZG * dir.x, PUSH_SCALE_NAZG * dir.y, PUSH_SCALE_NAZG * dir.z);

    // Apply onto the ogre
    ogre.__KeyValueFromVector("basevelocity", vel);
}
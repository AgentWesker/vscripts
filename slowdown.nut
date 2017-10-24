function ChangeHealth(amount) {
  EntFireByHandle(activator, "SetHealth", "" + (activator.GetHealth() + amount), 0.0, null, null);
}
// UOSL (enhanced)
inherits spelskil;

member int ticksUntilNext; // are these ticks or seconds?
member int ticksLeft;
member int strength;
member int dmgToDeal;
member int victimHP;

function void adjustStrength(obj victim, int strength)
{
  victimHP = getCurHP(victim);
    actionBark(victim, 0x21, "* You are in extreme pain, and require immediate aid! *", "* " + getName(victim) + " begins to spasm uncontrollably. *");
    dmgToDeal = victimHP / 0x02;
    ticksUntilNext = 5;
  return;
}

function int poisonIsValid(obj victim)
{
  if(isDead(this))
  {
    return(0x00);
  }
  if(!hasObjVar(this, "poison_strength")) // what is this?
  {
    setObjVar(this, "poison_strength", 0x01);
    return(0x01);
  }
  if(getCurHP(this) < 0x00)
  {
    return(0x00);
  }
  return(0x01);
}

trigger creation()
{
  if(!poisonIsValid(this))
  {
    curePoison(this);
    return(0x00);
  }
  strength = getObjVar(this, "poison_strength");
  setPoisoned(this, 0x01);
  ticksUntilNext = 15;
  adjustStrength(this, strength);
  ticksLeft = (random(10, 20) * strength);
  callBack(this, ticksUntilNext, 0x53);
  return(0x01);
}

trigger callback<0x53>()
{
  if(!poisonIsValid(this))
  {
    curePoison(this);
    return(0x00);
  }
  ticksLeft --;
  if(ticksLeft < 0x01)
  {
    systemMessage(this, "The poison seems to have worn off.");
    curePoison(this);
    return(0x00);
  }
  doDamageType(NULL(), this, (dmgToDeal + 0x02), 0x08);
  if(!poisonIsValid(this))
  {
    curePoison(this);
    return(0x00);
  }
  else
  {
    if(!random(0x00, 0x02))
    {
      strength = getObjVar(this, "poison_strength");
      adjustStrength(this, strength);
    }
    callBack(this, ticksUntilNext, 0x53);
    return(0x00);
  }
  curePoison(this);
  return(0x00);
}

trigger ishealthy()
{
  return(0x00);
}
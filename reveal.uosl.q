// UOSL (enhanced)
inherits revealbase;

trigger use(obj user)
{
  Q4M9(this, user);
  return(0x00);
}

trigger message<"castspell">(obj sender, list args)
{
  obj user = Q4BB(this, args);
  if(!isValid(user))
  {
    return(0x00);
  }
  Q5RD(user, this);
  targetLoc(user, this);
  return(0x00);
}

trigger targetloc(obj user, loc place, int objtype)
{
  if(!Q4C8(user, this))
  {
    return(0x01);
  }
  if(!isInMap(place))
  {
    return(0x00);
  }
  if(canSeeLoc(user, place) == 0x01)
  {
    if(!Q5YC(user, this))
    {
      return(0x00);
    }
    if(Q4LT(user, place, this))
    {
      Q4M3(user, place);
    }
    else
    {
      Q4RD(user);
    }
  }
  else
  {
    systemMessage(user, "Target cannot be seen.");
  }
  return(0x00);
}

trigger creation()
{
  return(0x00);
}
// UOSL (enhanced)
trigger enterrange<0x08>(obj target)
{
  if(isHuman(target))
  {
    if(!isDead(target))
    {
      attack(this, target);
    }
  }
  return(0x01);
}
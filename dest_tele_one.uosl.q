// UOSL (enhanced)
trigger enterrange<0x02>(obj target)
{
  loc toLocation = 5143, 802, 3;
  if(getY(getLocation(target)) > getY(getLocation(this)))
  {
    return(0x01);
  }
  if(!teleport(target, toLocation))
  {
    return(0x00);
  }
  return(0x01);
}
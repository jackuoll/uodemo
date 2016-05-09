// UOSL (enhanced)
inherits globals;

trigger creation()
{
  setType(this, 0x01);
  return(0x00);
}

trigger enterrange<0x01>(obj target)
{
  loc Q54M = 5130, 908, (0 - 22);
  loc Q54P = 5144, 797, 22;
  loc Q54Q = 5152, 810, (0 - 19);
  loc Q54N = 5133, 985, 22;
  loc Q43K = getLocation(this);
  loc Q648;
  Q648 = 0 - 1, 0 - 1, 0;
  if(Q43K == Q54M)
  {
    Q648 = 5143, 802, 4;
  }
  if(Q43K == Q54P)
  {
    Q648 = 5130, 903, 0;
  }
  if(Q43K == Q54Q)
  {
    Q648 = 5138, 985, 5;
  }
  if(Q43K == Q54N)
  {
    Q648 = 5148, 810, 0;
  }
  if(isInMap(Q648))
  {
    int r = teleport(target, Q648);
    return(!r);
  }
  return(0x01);
}
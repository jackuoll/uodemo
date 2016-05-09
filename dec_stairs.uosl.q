// UOSL (enhanced)

// The scripts dec_teleport and dec_stairs serve the same function

inherits globals;

trigger enterrange<0x01>(obj target)
{
  loc Q648;
  loc Q59R = getLocation(this);
  loc Q52X = 5217, 587, (0 - 20);
  loc Q530 = 5305, 531, 10;
  loc Q531 = 5347, 578, (0 - 20);
  loc Q52Z = 5137, 650, 15;
  loc Q52Y = 5218, 762, (0 - 35);
  loc Q52V = 5306, 649, 0;
  loc Q64A = 5217, 582, 0;
  loc Q64D = 5305, 534, 0;
  loc Q64E = 5342, 578, 0;
  loc Q64C = 5141, 650, 0;
  loc Q64B = 5218, 758, (0 - 20);
  loc Q649 = 5306, 654, 0;
  if(Q59R == Q52X)
  {
    Q648 = Q64D;
  }
  if(Q59R == Q530)
  {
    Q648 = Q64A;
  }
  if(Q59R == Q531)
  {
    Q648 = Q64C;
  }
  if(Q59R == Q52Z)
  {
    Q648 = Q64E;
  }
  if(Q59R == Q52Y)
  {
    Q648 = Q649;
  }
  if(Q59R == Q52V)
  {
    Q648 = Q64B;
  }
  if(!teleport(target, Q648))
  {
    return(0x01);
  }
  return(0x00);
}
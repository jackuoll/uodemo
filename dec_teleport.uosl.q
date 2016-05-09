// UOSL (enhanced)

// The scripts dec_teleport and dec_stairs serve the same function

trigger enterrange<0x01>(obj target)
{
  loc Q4WJ = getLocation(this);
  int Q53G = getX(Q4WJ);
  int Q53H = getY(Q4WJ);
  int Q53I = getZ(Q4WJ);
  loc Q648;
  if((Q53G == 5217) && (Q53H == 585) && (Q53I == (0 - 10)))
  {
    Q648 = 5306, 534, 0;
  }
  if((Q53G == 5305) && (Q53H == 531) && (Q53I == 10))
  {
    Q648 = 5217, 583, 0;
  }
  if((Q53G == 5348) && (Q53H == 578) && (Q53I == (0 - 10)))
  {
    Q648 = 5141, 650, 0;
  }
  if((Q53G == 5139) && (Q53H == 650) && (Q53I == 10))
  {
    Q648 = 5342, 578, 0;
  }
  if((Q53G == 5218) && (Q53H == 761) && (Q53I == (0 - 30)))
  {
    Q648 = 5306, 654, 0;
  }
  if((Q53G == 5306) && (Q53H == 651) && (Q53I == 10))
  {
    Q648 = 5219, 578, (0 - 20);
  }
  if(!teleport(target, Q648))
  {
    return(0);
  }
  return(1);
}
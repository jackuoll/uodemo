// UOSL (enhanced)
inherits globals;

trigger enterrange<0x01>(obj target)
{
  loc Q648;
  loc Q59R = getLocation(this);
  loc Q4NZ = 5572, 629, 45;
  loc Q4O0 = 5571, 632, 10;
  loc Q54L = 5505, 570, 39;
  loc Q54O = 5523, 673, 35;

  loc lvl2To3 = 5385, 756, 0-13;
  loc lvl3To2 = 5411, 859, 62;

  if(Q59R == Q4NZ)
  {
    Q648 = 5498, 570, 59;
  }
  if(Q59R == Q4O0)
  {
    Q648 = 5518, 672, 20;
  }
  if(Q59R == Q54L)
  {
    Q648 = 5576, 629, 30;
  }
  if(Q59R == Q54O)
  {
    Q648 = 5576, 633, 30;
  }
  if(Q59R == lvl2To3)
  {
    Q648 = 5406, 859, 45;
  }
  if(Q59R == lvl3To2)
  {
    Q648 = 5391, 756, 5;
  }
  if(!teleport(target, Q648))
  {
    return(0x01);
  }
  return(0x00);
}
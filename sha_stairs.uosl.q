// UOSL (enhanced)

// This seems to have been replaced by sha_tele_new

inherits globals;

trigger enterrange<0x01>(obj target)
{
  loc Q648;
  loc Q59R = getLocation(this);
  loc Q52X = 5491, 18, (0 - 52);
  loc Q530 = 5512, 8, 0;
  loc Q531 = 5512, 148, 20;
  loc Q52Z = 5602, 101, (0 - 23);
  loc Q52Y = 5873, 17, 10;
  loc Q52V = 5516, 174, (0 - 23);
  loc Q64D = 5515, 8, 0;
  loc Q64A = 5488, 18, (0 - 30);
  loc Q64C = 5600, 101, 0;
  loc Q64E = 5513, 148, 20;
  loc Q649 = 5511, 175, 0;
  loc Q64B = 5878, 18, (0 - 10);
  if(Q59R == Q52X)
  {
    Q648 = Q64D;
  }
  else
  {
    if(Q59R == Q530)
    {
      Q648 = Q64A;
    }
    else
    {
      if(Q59R == Q531)
      {
        Q648 = Q64C;
      }
      else
      {
        if(Q59R == Q52Z)
        {
          Q648 = Q64E;
        }
        else
        {
          if(Q59R == Q52Y)
          {
            Q648 = Q649;
          }
          else
          {
            if(Q59R == Q52V)
            {
              Q648 = Q64B;
            }
            else
            {
              bark(this, "Not a supported teleporter location.");
              return(0x01);
            }
          }
        }
      }
    }
  }
  if(!teleport(target, Q648))
  {
    return(0x01);
  }
  return(0x00);
}
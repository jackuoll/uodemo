// UOSL (enhanced)
inherits sndfx;

function void Q6AA(obj player)
{
	
}

trigger creation()
{
  callback(this, 0x14, 0x95);
  return(0x01);
}

trigger callback<0x95>()
{
  list Q6AB;
  getMobsInRange(Q6AB, getLocation(this), 0x0A);
  int x = numInList(Q6AB);
  while(x != 0x00)
  {
    x --;
    obj Q61K = Q6AB[x];
    if(isPlayer(Q61K))
    {
      systemMessage(Q61K, "Ouch!");
    }
  }
  callback(this, 0x14, 0x95);
  return(0x00);
}
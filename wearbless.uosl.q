// UOSL (enhanced)
inherits wearstat;

trigger creation()
{
  Q5X6 = 0xFF;
  Q4HZ = 0xFF;
  Q4YI = 0xFF;
  return(0x01);
}

function void Q4HX(obj it)
{
  detachScript(it, "wearbless");
  return;
}
// UOSL (enhanced)
inherits eat;

trigger creation()
{
  setObjVar(this, "I_am_food", 0x01);
  setObjVar(this, "satiety", 0x06);
  return(0x01);
}

trigger use(obj user)
{
  Q4NG(user, 0x00);
  return(0x01);
}
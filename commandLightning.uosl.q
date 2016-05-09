trigger creation()
{
 loc place=getLocation(this);
 sfx(place,0x29,0x00);
 doLightning(this);
 if(isMobile(this))
 {
  int hits=getCurHP(this) / 2;
  if(hits > 1)
  {
  }
  setCurHP(this,hits);
 }
 detachScript(this,"commandLightning");
 return(1);
}


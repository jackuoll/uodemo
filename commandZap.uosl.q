trigger creation()
{
 if(isMobile(this) && (!isPlayer(this)))
 {
  deleteObject(this);
 }
 detachScript(this,"commandZap");
 return(1);
}


trigger creation()
{
 if(isMobile(this))
 {
  int amount=60000;
  doDamageType(NULL(),this,amount,0x04);
 }
 detachScript(this,"commandSlay");
 return(1);
}


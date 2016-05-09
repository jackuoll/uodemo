trigger creation()
{
 setMobFlag(this,0x01,1);
 detachScript(this,"commandInvulnerable");
 return(1);
}


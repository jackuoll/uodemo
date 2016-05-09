trigger creation()
{
 setMobFlag(this,0x01,0);
 detachScript(this,"commandVulnerable");
 return(1);
}


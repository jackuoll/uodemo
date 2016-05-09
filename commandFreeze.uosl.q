trigger creation()
{
 setMobFlag(this,0x02,0x01);
 detachScript(this,"commandFreeze");
 return(1);
}


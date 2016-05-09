trigger creation()
{
 setMobFlag(this,0x02,0x00);
 detachScript(this,"commandUnFreeze");
 return(1);
}


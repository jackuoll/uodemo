trigger creation()
{
 setMobFlag(this,0x04,0);
 detachScript(this,"commandUnSquelch");
 return(1);
}


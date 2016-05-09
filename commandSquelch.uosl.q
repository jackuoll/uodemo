trigger creation()
{
 setMobFlag(this,0x04,1);
 detachScript(this,"commandSquelch");
 return(1);
}


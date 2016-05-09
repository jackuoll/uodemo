trigger creation()
{
 if(isMobile(this))
 {
  resurrect(this,0);
 }
 detachScript(this,"commandResurrect");
 return(1);
}


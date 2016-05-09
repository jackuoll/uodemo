trigger creation()
{
 if(!isMobile(this))
 {
  deleteObject(this);
 }
 detachScript(this,"commandDelete");
 return(1);
}


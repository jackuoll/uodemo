trigger creation()
{
 loc transLoc;
 if(hasObjVar(this,"transLoc"))
 {
  transLoc=getObjVar(this,"transLoc");
  teleport(this,transLoc);
  removeObjVar(this,"transLoc");
 }
 detachScript(this,"commandTransfer");
 return(1);
}


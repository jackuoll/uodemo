trigger speech<"cross">(obj speaker,string arg)
{
 list Q5HT;
 if(isValid(speaker))
 {
  if(getDistanceInTiles(getLocation(this),getLocation(speaker)) <= 2 && hasObjVar(this,"dest"))
  {
   teleport(speaker,getObjVar(this,"dest"));
  }
 }
 return(0);
}


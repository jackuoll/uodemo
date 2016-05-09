trigger creation()
{
 if(isPlayer(this))
 {
  removePlayerFromGame(this);
 }
 detachScript(this,"commandKick");
 return(1);
}


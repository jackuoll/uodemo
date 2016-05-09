inherits defines;
member string command;
member int theinteger1;
member string thestring1;
function string GetLocationDescription(loc inLocation,loc inReferenceLocation)
{
 string outDesc;
 loc outNormalizedLocation;
 int result=getLocalizedDesc(outDesc,outNormalizedLocation,inLocation,inReferenceLocation);
 if(!result)
 {
  outDesc="unknown";
 }
 return(outDesc);
}
trigger online()
{
 systemMessage(this,"The GM cheat script welcomes you!");
}
trigger speech<"]*">(obj speaker,string arg)
{
 if(speaker != this)
 {
  return(0);
 }
 string argnew;
 textSubstitute(argnew,"%" + arg,"]","");
 doSCommand(speaker,argnew);
}
trigger speech<"[*">(obj speaker,string arg)
{
 if(speaker != this)
 {
  return(0);
 }
 list args;
 split(args,arg);
 int argcount=numInList(args);
 if(argcount < 1)
 {
  return(1);
 }
 int test=0;
 int modify=0;
 int query=1;
 int needloc=0;
 int needobj=0;
 command=args[0];
 if(command == "go" || (command == "tele"))
 {
  command="teleport";
 }
 if(command != "")
 {
  if(command == "create")
  {
   if(argcount < 2)
   {
    return(1);
   }
   string s=arg;
   removePrefix(s,"[create ");
   int id=StringToItem(s);
   if(id >= 100000)
   {
    systemMessage(speaker,"Cannot create templates using this method.");
   }
   else
   {
    if(id > 0)
    {
     createGlobalObjectAt(id,getLocation(this));
     systemMessage(speaker,"Created " + s + " at your location.");
    }
    else
    {
     systemMessage(speaker,"Item " + s + " is not known.");
    }
   }
  }
  else
  {
   if(command == "setstat")
   {
    if(argcount != 0x03)
    {
     systemMessage(speaker,"[setstat [str/dex/int] [value]");
     return(1);
    }
    string stat;
    int setTo=strtoi(args[0x02]);
    if(setTo < 10)
    {
     systemMessage(speaker,"Cannot set stat to less than 10");
     return(1);
    }
    else
    {
     stat=args[0x01];
    }
    systemMessage(speaker,stat);
    if(stat == "str")
    {
     setRealStat(speaker,0x00,setTo);
    }
    else
    {
     if(stat == "dex")
     {
      setRealStat(speaker,0x01,setTo);
     }
     else
     {
      if(stat == "int")
      {
       setRealStat(speaker,0x02,setTo);
      }
      else
      {
       if(stat == "all")
       {
        setRealStat(speaker,0x00,setTo);
        setRealStat(speaker,0x01,setTo);
        setRealStat(speaker,0x02,setTo);
       }
      }
     }
    }
    return(1);
   }
   else
   {
    if(command == "recover")
    {
     setCurHP(speaker,getMaxHP(speaker));
     setCurMana(speaker,getMaxMana(speaker));
     setCurFatigue(speaker,getMaxFatigue(speaker));
     systemMessage(speaker,"You have been refreshed.");
    }
    else
    {
     if(command == "setskill")
     {
      int skillindex;
      int skillvalue;
      if(argcount < 0x03)
      {
       return(1);
      }
      skillvalue=strtoi(args[0x02]);
      if(args[0x01] == "all")
      {
       for(int k=0x00;k < 0x27;k++)
       {
        setSkillLevel(speaker,k,skillvalue * 0x0A);
       }
       systemMessage(speaker,"All of your skills are now " + skillvalue);
      }
      else
      {
       skillindex=strtoi(args[0x01]);
       if(skillindex < 0x00 || (skillindex > 0x27))
       {
        systemMessage(speaker,"This skill(" + skillindex + ") does not exist. 0-39 only");
        return(1);
       }
       if(skillvalue < 0x00)
       {
        systemMessage(speaker,"Please don't set your skills negative.");
        return(1);
       }
       if(skillvalue > 0x64)
       {
        systemMessage(speaker,"No skills over 100, trammy.");
        return(1);
       }
       string msg="Now skill is " + skillvalue + " in " + getSkillName(skillindex);
       systemMessage(speaker,msg);
       setSkillLevel(speaker,skillindex,skillvalue * 0x0A);
      }
     }
     else
     {
      if(command == "listskills")
      {
       for(int i=0x00;i < 0x27;i++)
       {
        systemMessage(speaker,"" + i + ": " + getSkillName(i));
       }
      }
      else
      {
       if(command == "getserial")
       {
        needobj=1;
       }
       else
       {
        if(command == "gethue")
        {
         needobj=1;
        }
        else
        {
         if(command == "getheight")
         {
          needobj=1;
         }
         else
         {
          if(command == "getelevation")
          {
           needloc=1;
          }
          else
          {
           if(command == "where")
           {
            loc curLocation=getLocation(speaker);
            systemMessage(speaker,"loc = " + curLocation + " : " + GetLocationDescription(curLocation,curLocation));
           }
           else
           {
            if(command == "teleport")
            {
             loc temploc;
             if(argcount < 3)
             {
              systemMessage(speaker,"Where do you want to teleport to?");
              needloc=1;
              query=0;
             }
             else
             {
              if(argcount == 3)
              {
               setX(temploc,strtoi(args[1]));
               setY(temploc,strtoi(args[2]));
               setZ(temploc,getElevation(temploc));
               if(isInMap(temploc))
               {
                teleport(speaker,temploc);
                systemMessage(speaker,"teleport(" + temploc + ") = " + getLocation(speaker));
               }
               else
               {
                systemMessage(speaker,"loc(" + temploc + ") = invalid!");
               }
              }
              else
              {
               if(argcount == 4)
               {
                setX(temploc,strtoi(args[1]));
                setY(temploc,strtoi(args[2]));
                setZ(temploc,strtoi(args[3]));
                if(isInMap(temploc))
                {
                 teleport(speaker,temploc);
                 systemMessage(speaker,"teleport(" + temploc + ") = " + getLocation(speaker));
                }
                else
                {
                 systemMessage(speaker,"teleport(" + temploc + ") = invalid!");
                }
               }
              }
             }
            }
            else
            {
             if(command == "setname")
             {
              if(argcount == 2)
              {
               thestring1=args[1];
               needobj=1;
               modify=1;
              }
              else
              {
               systemMessage(speaker,"Usage: setname <new name>");
              }
             }
             else
             {
              if(command == "sethue")
              {
               theinteger1=strtoi(args[1]);
               needobj=1;
               modify=1;
              }
              else
              {
               if(command == "cnv")
               {
                if(argcount != 2)
                {
                 systemMessage(speaker,"Please include a value to create");
                 return(1);
                }
                int toCreate=strtoi(args[1]);
                obj o=createNoResObjectAt(toCreate,getLocation(speaker));
                string weapon=getWeaponName(o);
                systemMessage(speaker,"Created a " + weapon);
                int reqdRes=0x00;
                getResource(reqdRes,o,"metal",0x03,0x00);
                systemMessage(speaker,"Required Resource: " + reqdRes);
                int val=reqdRes + (getWeaponSpeed(o) * getAverageDamage(o) / 0x0C);
                systemMessage(speaker,"the final val is: " + val);
               }
               else
               {
                if(command == "remove")
                {
                 needobj=1;
                 modify=1;
                }
                else
                {
                 if(command == "sethp")
                 {
                  theinteger1=strtoi(args[1]);
                  needobj=1;
                  modify=1;
                 }
                 else
                 {
                  if(command == "getinfo")
                  {
                   needobj=1;
                   query=1;
                  }
                  else
                  {
                   if(command == "addscript")
                   {
                    thestring1=args[1];
                    needobj=1;
                    modify=1;
                   }
                   else
                   {
                    if(command == "spawn" || (command == "spawnitem"))
                    {
                     theinteger1=strtoi(args[1]);
                     if(theinteger1 == 0)
                     {
                      s=arg;
                      removePrefix(s,"[" + command + " ");
                      theinteger1=StringToItem(s);
                      if(theinteger1 >= 100000)
                      {
                       theinteger1=theinteger1 - 100000;
                       command="spawn";
                      }
                      else
                      {
                       if(theinteger1 >= 0)
                       {
                        command="spawnitem";
                        systemMessage(speaker,"the command is to spawn an item");
                       }
                      }
                     }
                     if(theinteger1 > 0 && (theinteger1 < 100000))
                     {
                      if(command == "spawn")
                      {
                       systemMessage(speaker,"Where do you want the NPC to spawn?");
                      }
                      else
                      {
                       if(command == "spawnitem")
                       {
                        systemMessage(speaker,"Where do you want the item to spawn?");
                       }
                      }
                      needloc=1;
                      modify=1;
                     }
                     else
                     {
                      systemMessage(speaker,"Invalid id.");
                      command="";
                     }
                    }
                    else
                    {
                     if(command == "test")
                     {
                      if(argcount < 2)
                      {
                       systemMessage(speaker,"What do you want to test?");
                       return(0x01);
                      }
                      command=args[1];
                      test=1;
                      if(command != "")
                      {
                       if(command == "scommand" || (command == "doscommand"))
                       {
                        doSCommand(this,"test");
                       }
                       else
                       {
                        if(command == "obscene" || (command == "isobscene"))
                        {
                         if(argcount < 0x03)
                         {
                          systemMessage(speaker,"What words do you want to test?");
                          return(0x01);
                         }
                         else
                         {
                          for(i=0x02;i < argcount;i++)
                          {
                           if(isObscene(args[i]))
                           {
                            systemMessage(speaker,arg[i] + " = obscene!");
                           }
                           else
                           {
                            systemMessage(speaker,arg[i] + " = not obscene");
                           }
                          }
                          return(0x01);
                         }
                        }
                        else
                        {
                         if(command == "canseeloc")
                         {
                          needloc=1;
                         }
                         else
                         {
                          if(command == "canseeobj")
                          {
                           needobj=1;
                          }
                          else
                          {
                           command="";
                          }
                         }
                        }
                       }
                      }
                     }
                     else
                     {
                      command="";
                     }
                    }
                   }
                  }
                 }
                }
               }
              }
             }
            }
           }
          }
         }
        }
       }
      }
     }
    }
   }
  }
  if(command != "")
  {
   if(needloc != 0)
   {
    if(test != 0)
    {
     systemMessage(speaker,"Click on the loc you want to test.");
    }
    else
    {
     if(modify != 0)
     {
      systemMessage(speaker,"Click on the loc you want to modify.");
     }
     else
     {
      if(query != 0)
      {
       systemMessage(speaker,"Click on the loc you want to query.");
      }
     }
    }
    targetLoc(speaker,this);
   }
   if(needobj != 0)
   {
    if(test != 0)
    {
     systemMessage(speaker,"Click on the object you want to test.");
    }
    else
    {
     if(modify != 0)
     {
      systemMessage(speaker,"Click on the object you want to modify.");
     }
     else
     {
      if(query != 0)
      {
       systemMessage(speaker,"Click on the object you want to query.");
      }
     }
    }
    targetObj(speaker,this);
   }
  }
 }
 return(0x01);
}
trigger targetloc(obj user,loc place,int objtype)
{
 if(!isInMap(place))
 {
  return(0);
 }
 string tempstring="";
 int result;
 if(command == "canseeloc")
 {
  result=canSeeLoc(user,place);
  tempstring=tempstring + "CanSeeLoc (serial=" + objtoint(user) + ", loc=" + place + ") = " + result;
 }
 else
 {
  if(command == "teleport")
  {
   teleport(user,place);
   systemMessage(user,"teleport(" + place + ") = " + getLocation(user));
  }
  else
  {
   if(command == "getelevation")
   {
    result=getElevation(place);
    tempstring=tempstring + "GetElevation (loc=" + place + ") = " + result;
    systemMessage(user,tempstring);
    tempstring="";
    result=getElevationAt(getX(place),getY(place));
    tempstring=tempstring + "GetElevationAt (loc=" + place + ") = " + result;
   }
   else
   {
    if(command == "spawn")
    {
     createGlobalNPCAtSpecificLoc(theinteger1,place);
    }
    else
    {
     if(command == "spawnitem")
     {
      createGlobalObjectAt(theinteger1,place);
     }
     else
     {
      if(tempstring != "")
      {
       systemMessage(user,tempstring);
      }
     }
    }
   }
  }
 }
 command="";
 return(1);
}
trigger oortargetobj(obj user,obj usedon)
{
 if(usedon == NULL())
 {
  return(0);
 }
 string tempstring="";
 int result;
 if(command == "getheight")
 {
  result=getHeight(usedon);
  tempstring=tempstring + "GetHeight (serial=" + objtoint(usedon) + ") = " + result;
 }
 else
 {
  if(command == "gethue")
  {
   result=getHue(usedon);
   tempstring=tempstring + "GetHue (serial=" + objtoint(usedon) + ") = " + result;
  }
  else
  {
   if(command == "getserial")
   {
    result=objtoint(usedon);
    if(result >= 0)
    {
     tempstring=tempstring + "serial = " + result;
    }
    else
    {
     tempstring=tempstring + "serial = " + result + " or " + objToStr(usedon);
    }
   }
   else
   {
    if(command == "canseeobj")
    {
     result=canSeeObj(user,usedon);
     tempstring=tempstring + "CanSeeObj (serial=" + objtoint(user) + ", serial=" + objtoint(usedon) + ") = " + result;
    }
    else
    {
     if(command == "setname")
     {
      string oldname=getName(usedon);
      setRealName(usedon,thestring1);
      tempstring=tempstring + "Name was: " + oldname + ", is now: " + getRealName(usedon);
     }
     else
     {
      if(command == "sethue")
      {
       int oldhue=getHue(usedon);
       setHue(usedon,theinteger1);
       tempstring=tempstring + "Hue was: " + oldhue + ", is now: " + getHue(usedon);
      }
      else
      {
       if(command == "sethp")
       {
        setWeaponCurHP(usedon,theinteger1);
        setWeaponMaxHP(usedon,theinteger1);
        int curhits=getWeaponCurHP(usedon);
        string weapon=getWeaponName(usedon);
        tempstring="Adjusted " + weapon + " hits to " + curhits;
       }
       else
       {
        if(command == "addscript")
        {
         tempstring="Adding script " + thestring1 + " to " + objToStr(usedon);
         attachScript(usedon,thestring1);
        }
        else
        {
         if(command == "remove")
         {
          deleteObject(usedon);
          tempstring="Destroyed.";
         }
         else
         {
          if(command == "getinfo")
          {
           string weapon=getWeaponName(usedon);
           int dmg=getAverageDamage(usedon);
           int maxhits=getWeaponMaxHP(usedon);
           int curhits=getWeaponCurHP(usedon);
           int value=getValue(usedon);
           int wepSpeed=getWeaponSpeed(usedon);
           tempstring="AvDmg: " + dmg + " Max hits: " + maxhits + " Cur hits: " + curhits + " ItemID value:" + value + " Weapon Speed: " + wepSpeed;
          }
         }
        }
       }
      }
     }
    }
   }
  }
 }
 if(tempstring != "")
 {
  systemMessage(user,tempstring);
 }
 command="";
 return(1);
}


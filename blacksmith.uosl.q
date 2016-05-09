// UOSL (enhanced)
inherits itemmanip;

forward void Q555();
forward void cleanup();
forward void Q4ER();

member obj Crafter;
member list CurrentOptions;

function void findIngots(list metal, obj player)
{
  clearList(metal);
  for(int i = 7151; i <= 7156; i ++)
  {
    getObjectsOfTypeIn(metal, player, i); // this must assign to the list metal
  }
  return;
}

function int findTotalIngots(obj player)
{
  int total = 0x00;
  list metal;
  clearList(metal);
  findIngots(metal, player);
  for(int num = numInList(metal); num > 0x00; num --)
  {
    int amount;
    getResource(amount, metal[0x00], "metal", 0x03, 0x02); // "amount" is assigned to
    total = total + amount;
    removeItem(metal, 0x00);
  }
  return(total);
}

function void consumeMetal(obj newItem, obj player, int left)
{
  list metal;
  clearList(metal);
  findIngots(metal, player);
  for(int num = numInList(metal); num > 0x00; num --)
  {
    int amtInPile;
    obj useIngot = metal[0x00];
    getResource(amtInPile, useIngot, "metal", 0x03, 0x02);
    if(left >= amtInPile)
    {
      transferResources(newItem, useIngot, amtInPile, "metal");
      deleteObject(useIngot);
      removeItem(metal, 0x00);
      left = left - amtInPile;
    }
    else
    {
      transferResources(newItem, useIngot, left, "metal");
      getResource(amtInPile, useIngot, "metal", 0x03, 0x02);
      if(amtInPile < 0x01)
      {
        deleteObject(useIngot);
      }
      break;
    }
  }
  clearList(metal);
  return;
}

function int Q4A1(int Q5NY, int metal, int Q55Z)
{
  if(getArrayIntElem(0x00, 0x04, Q5NY) > metal)
  {
    return(0x00);
  }
  if(getArrayIntElem(0x00, 0x05, Q5NY) > Q55Z)
  {
    return(0x00);
  }
  return(0x01);
}

function void displayOptions(obj user, string optionText)
{
  list optionList;
  clearList(optionList);
  for(int i = 0; i < numInList(CurrentOptions); i ++)
  {
    int option = CurrentOptions[i];
    append(optionList, getArrayIntElem(0, 0, option));
    append(optionList, getArrayIntElem(0, 1, option));
    append(optionList, getArrayStrElem(0, 2, option));
  }
  selectTypeAndHue(user, this, 0x00, optionText, optionList);
  return;
}

function int Q4DY(int metal, int Q55Z, int Q5VT, int Q5VN)
{
  int Q5NY = Q5VT;
  while(Q5NY < 0x3D)
  {
    int Q4HG = getArrayIntElem(0x00, 0x03, Q5NY);
    if(Q4HG > Q5VN)
    {
      int Q4NT = numInList(CurrentOptions);
      int Q4NV = Q4DY(metal, Q55Z, Q5NY + 0x01, Q5VN + 0x01);
      int Q5C8 = numInList(CurrentOptions) - Q4NT;
      if(Q5C8 > 0x01)
      {
        truncateList(CurrentOptions, Q4NT);
        append(CurrentOptions, Q5NY);
      }
      Q5NY = Q4NV;
    }
    else
    {
      if((Q4HG < Q5VN) || (getArrayIntElem(0x00, 0x01, Q5NY) == 0x36))
      {
        break;
      }
      if(Q4A1(Q5NY, metal, Q55Z))
      {
        append(CurrentOptions, Q5NY);
      }
      Q5NY ++;
    }
  }
  return(Q5NY);
}

function int Q4Y7(int idx, int Q4HG, list items)
{
  int debug = hasObjVar(this, "debugSkillInfo");
  while(numInList(items))
  {
    setArrayIntElem(0, 0, idx, items[0]);
    setArrayIntElem(0, 3, idx, Q4HG);
    obj toCreate = createNoResObjectAt(items[0], getLocation(this));
    int reqdIngots = 0;
    getResource(reqdIngots, toCreate, "metal", 3, 0); // "reqdIngots" will be assigned to.
    setArrayIntElem(0, 4, idx, reqdIngots);
    int val;
    if(isReallyWeapon(toCreate))
    {
      val = reqdIngots + (getWeaponSpeed(toCreate) * getAverageDamage(toCreate) / 12);
    }
    else
    {
      val = reqdIngots + (getMaxArmorClass(toCreate) * 2);
    }
    setArrayIntElem(0, 5, idx, val);
    string description = getNameByType(items[0]);
    toUpper(description, 0, 1);
    if(debug)
    {
      description = description + ". $" + val + ", " + reqdIngots + " metal";
    }
    else
    {
      description = "Build " + description + ", " + reqdIngots + " metal.";
    }
    setArrayStrElem(0, 2, idx, description);
    deleteObject(toCreate);
    removeItem(items, 0);
    idx ++;
  }
  return(idx);
}

function void Q4Y8()
{
  if(hasObjVar(this, "debugSkillInfo"))
  {
    deleteArray(0x00);
  }
  if(isArrayInit(0x00))
  {
    return;
  }
  list Q4Y9 = 0x00, 0x01, "COL_NAME", 0x03, 0x04, 0x05;
  initArray(0x00, 0x06, 0x3D, Q4Y9);
  int Q5NY = 0x00;
  Q4Y9 = 0x0FAF, 0x00, "Repair an Item", 0x00;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x13ED, 0x36, "Build Armor", 0x01;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x13EC, 0x36, "Build Ring Armor", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x13EB, 0x13EF, 0x13F0, 0x13EC;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x13BF, 0x36, "Build Chain Armor", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x13BB, 0x13BE, 0x13BF;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x1415, 0x36, "Build Plate Armor", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x1408, 0x36, "Build Helmets", 0x03;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x140A, 0x140C, 0x140E, 0x1408, 0x1412;
  Q5NY = Q4Y7(Q5NY, 0x03, Q4Y9);
  Q4Y9 = 0x1413, 0x1414, 0x1410, 0x1411, 0x1415, 0x1C04;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x1B74, 0x36, "Build Shields", 0x01;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x1B73, 0x1B72, 0x1B7B, 0x1B78, 0x1B74, 0x1B76;
  Q5NY = Q4Y7(Q5NY, 0x01, Q4Y9);
  Q4Y9 = 0x0F45, 0x36, "Build Weapons", 0x01;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x0F61, 0x36, "Build Blades", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x0F51, 0x1441, 0x13FF, 0x1401, 0x13B6, 0x0F5E, 0x0F61, 0x13B9;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x13FB, 0x36, "Build Axes", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x0F47, 0x0F49, 0x0F45, 0x1443, 0x0F4B, 0x13FB, 0x13B0;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x0F4D, 0x36, "Build Pole Arms", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x1403, 0x0F62, 0x1405, 0x0F4D, 0x143F;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  Q4Y9 = 0x1407, 0x36, "Build Bludgeoning Weapons", 0x02;
  setArrayElems(0x00, 0x00, Q5NY, Q4Y9);
  Q5NY ++;
  Q4Y9 = 0x0F5C, 0x143B, 0x1407, 0x1439, 0x143D;
  Q5NY = Q4Y7(Q5NY, 0x02, Q4Y9);
  debugMessage("BlackSmithing Loaded:  Allocated Rows= " + 0x3D + " Computed Rows:" + Q5NY);
  int Q576 = 0x000F4240;
  int Q55T = 0x00;
  int i;
  int val;
  int Q577;
  int Q567;
  for(i = 0x01; i < Q5NY; i ++)
  {
    if(getArrayIntElem(0x00, 0x01, i) != 0x36)
    {
      val = getArrayIntElem(0x00, 0x05, i);
      if(Q55T < val)
      {
        Q55T = val;
        Q567 = getArrayIntElem(0x00, 0x00, i);
      }
      if(Q576 > val)
      {
        Q576 = val;
        Q577 = getArrayIntElem(0x00, 0x00, i);
      }
    }
  }
  debugMessage("Min Value=" + Q576 + " (" + Q577 + ") Max Value=" + Q55T + " (" + Q567 + ")");
  int range = Q55T - Q576;
  for(i = 0x01; i < Q5NY; i ++)
  {
    if(getArrayIntElem(0x00, 0x01, i) != 0x36)
    {
      val = getArrayIntElem(0x00, 0x05, i);
      int Q4IA = (val - Q576) * 0x03E8 / range;
      setArrayIntElem(0x00, 0x05, i, Q4IA);
    }
  }
  return;
}

trigger creation()
{
  Q4Y8();
  return(0x01);
}

trigger objectloaded()
{
  Q4Y8();
  return(0x01);
}

function int Q4ZM(obj user)
{
  int Q46D = 0x00;
  int Q4QG = 0x00;
  list Q5FD;
  clearList(Q5FD);
  getObjectsInRange(Q5FD, getLocation(user), 0x03);
  int Q5E6 = numInList(Q5FD);
  for(int i = 0x00; i < Q5E6; i ++)
  {
    int Q620 = getObjType(Q5FD[i]);
    switch(Q620)
    {
    case 0x0FAF:
    case 0x0FB0:
      Q46D = 0x01;
      break;
    case 0x0FB1:
      Q4QG = 0x01;
      break;
    }
    if(Q620 >= 0x197A)
    {
      if(Q620 <= 0x19A9)
      {
        Q4QG = 0x01;
      }
    }
  }
  if(!Q46D)
  {
    string Q47R = "You are not near an anvil";
    if(!Q4QG)
    {
      Q47R = Q47R + " or a forge.";
    }
    else
    {
      Q47R = Q47R + ".";
    }
    systemMessage(user, Q47R);
  }
  else
  {
    if(!Q4QG)
    {
      systemMessage(user, "You are not near a forge.");
    }
  }
  return(Q46D && Q4QG);
}

trigger targetobj(obj user, obj usedon)
{
  cleanup();
  if(Q4BL(user, "The blacksmith skill", 0x00))
  {
    return(0x00);
  }
  if(!Q4ZM(user))
  {
    return(0x00);
  }
  if(isWeapon(usedon) && hasResource(usedon, resourceTypeToId("metal")))
  {
    if(isInContainer(usedon))
    {
      obj container = getTopmostContainer(usedon);
      if(isMobile(container))
      {
        if(container != user)
        {
          systemMessage(user, "You can't work on that item.");
          return(0x00);
        }
      }
    }
    int Q4G6 = getWeaponCurHP(usedon);
    int Q56H = getWeaponMaxHP(usedon);
    if((Q56H == 0x00) || (Q4G6 >= Q56H))
    {
      systemMessage(user, "That is already in full repair.");
      return(0x00);
    }
    int Q5MK = (Q56H - Q4G6) * 0x04E2 / Q56H - 0xFA;
    int Q4Q1;
    int success = testAndLearnSkill(user, 0x07, Q5MK, 0x32);
    Q56H --;
    Q4G6 --;
    if(Q4G6 < 0x01)
    {
      systemMessage(user, "You destroyed the item.");
      deleteObject(usedon);
    }
    else
    {
      if(success > 0x00)
      {
        Q4G6 = Q56H;
        systemMessage(user, "You repair the item.");
      }
      Q4Q1 = setWeaponMaxHP(usedon, Q56H);
      Q4Q1 = setWeaponCurHP(usedon, Q4G6);
    }
    if(Q46J(user, this))
    {
      deleteObject(this);
    }
    return(0x00);
  }
  systemMessage(user, "You can't repair that.");
  return(0x00);
}

trigger use(obj user)
{
  if(Q4BL(user, "The blacksmith skill", 0x00))
  {
    return(0x00);
  }
  if(hasObjVar(this, "inUse"))
  {
    systemMessage(user, "That is being used by someone else.");
    return(0x00);
  }
  else
  {
    setObjVar(this, "inUse", 0x00);
    callBack(this, 0x3C, 0x1B);
  }
  Crafter = user;
  systemMessage(user, "What would you like to do?");
  loc Q66U = getLocation(user);
  int Q4Q1;
  list Q5FD;
  int Q5E6;
  int Q620;
  int i;
  if(Q4ZM(user))
  {
    int Q5TE = getSkillLevelReal(user, 0x07);
    int Q56Z = findTotalIngots(user);
    clearList(CurrentOptions);
    int Q5Z4 = Q4DY(Q56Z, Q5TE + 0xFA, 0x00, 0x00);
    displayOptions(user, "What would you like to do?");
  }
  else
  {
    cleanup();
  }
  return(0x00);
}

trigger typeselected<0x00>(obj user, int listindex, int objtype, int objhue)
{
  if(Q4BL(user, "The blacksmith skill", 0x00))
  {
    return(0x00);
  }
  removeCallback(this, 0x4A);
  if(listindex == 0x00)
  {
    cleanup();
    return(0x00);
  }
  listindex --;
  if(listindex >= numInList(CurrentOptions))
  {
    cleanup();
    return(0x00);
  }
  int Q5NY = CurrentOptions[listindex];
  if(Q5NY == 0x00)
  {
    systemMessage(user, "Select item to repair.");
    targetObj(user, this);
    return(0x00);
  }
  clearList(CurrentOptions);
  if(getArrayIntElem(0x00, 0x01, Q5NY) != 0x36)
  {
    append(CurrentOptions, Q5NY);
    shortCallback(this, 0x01, 0x4A);
    return(0x00);
  }
  int Q4HG = getArrayIntElem(0x00, 0x03, Q5NY);
  int Q56Z = findTotalIngots(user);
  int Q5TE = getSkillLevelReal(user, 0x07);
  int Q5Z4 = Q4DY(Q56Z, Q5TE + 0xFA, Q5NY + 0x01, Q4HG);
  displayOptions(user, getArrayStrElem(0x00, 0x02, Q5NY));
  return(0x00);
}

trigger callback<0x1B>()
{
  cleanup();
  return(0x00);
}

trigger callback<0x4A>()
{
  int Q4Q1;
  sfx(getLocation(this), 0x2A, 0x00);
  int Q5L6 = random(0x00, 0x05);
  if(Q5L6)
  {
    shortCallback(this, Q5L6, 0x4A);
  }
  else
  {
    Q4ER();
    if(hasObjVar(this, "inUse"))
    {
      removeObjVar(this, "inUse");
    }
  }
  return(0x00);
}

function void Q4ER()
{
  int Q4Q1;
  int Q56Z = findTotalIngots(Crafter);
  int Q5NY = CurrentOptions[0x00];
  int Q573 = getArrayIntElem(0x00, 0x04, Q5NY);
  if(Q573 > Q56Z)
  {
    systemMessage(Crafter, "The amount of metal changed since you started smithing the ingots.");
    cleanup();
    return;
  }
  int newType = getArrayIntElem(0x00, 0x00, Q5NY);
  int success = testAndLearnSkill(Crafter, 0x07, getArrayIntElem(0x00, 0x05, Q5NY), 0x32);
  obj item;
  if(success <= 0x00)
  {
    int Q570 = Q573 * (0x00 - success) / 0x03E8 + 0x01;
    Q56Z = Q56Z - Q570;
    item = createNoResObjectIn(newType, Crafter);
    consumeMetal(item, Crafter, Q570);
    deleteObject(item);
    systemMessage(Crafter, "You lost some metal.");
    cleanup();
    return;
  }
  item = createNoResObjectAt(newType, getLocation(Crafter));
  consumeMetal(item, Crafter, Q573);
  obj Q47G = getBackpack(Crafter);
  if(canHold(Q47G, item))
  {
    int Q4Q4 = putObjContainer(item, Q47G);
    systemMessage(Crafter, "You create the item and put it in your backpack.");
  }
  else
  {
    systemMessage(Crafter, "You create the item and put it at your feet.");
  }
  int Q59A = 0x64;
  if(success >= 0x0258)
  {
    systemMessage(Crafter, "Due to your exceptional skill, it's quality is higher than average.");
    Q59A = 0x78;
  }
  else
  {
    if(success < 0x012C)
    {
      systemMessage(Crafter, "You were barely able to make this item.  It's quality is below average.");
      Q59A = 0x50;
    }
  }
  if(Q59A != 0x64)
  {
    Q4Q1 = setWeaponMaxHP(item, getWeaponMaxHP(item) * Q59A / 0x64);
    Q4Q1 = setWeaponCurHP(item, getWeaponCurHP(item) * Q59A / 0x64);
    Q4Q1 = setMaxArmorClass(item, getMaxArmorClass(item) * Q59A / 0x64);
    int Q47C = getAverageDamage(item);
    if(Q47C > 0x00)
    {
      int Q48Q = Q47C * (Q59A - 0x64) / 0x64;
      Q581(this, 0x00, 0x00, Q48Q, 0x00);
    }
  }
  cleanup();
  if(Q46J(Crafter, this))
  {
    deleteObject(this);
  }
  return;
}

function void cleanup()
{
  clearList(CurrentOptions);
  Crafter = NULL();
  if(hasObjVar(this, "inUse"))
  {
    removeObjVar(this, "inUse");
  }
  return;
}
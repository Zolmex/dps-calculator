package
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class CharComposition
   {
      public static const TOME:uint = 4;
      
      public static const SHIELD:uint = 5;
      
      public static const SPELL:uint = 11;
      
      public static const SEAL:uint = 12;
      
      public static const CLOAK:uint = 13;
      
      public static const QUIVER:uint = 15;
      
      public static const HELM:uint = 16;
      
      public static const POISON:uint = 18;
      
      public static const SKULL:uint = 19;
      
      public static const TRAP:uint = 20;
      
      public static const ORB:uint = 21;
      
      public static const PRISM:uint = 22;
      
      public static const SCEPTER:uint = 23;
      
      public static const SHURIKEN:uint = 25;
      
      private var m_iClass:int;
      
      private var m_iPetLevelMP:int;
      
      private var m_iWeapon:int;
      
      private var m_iAbility:int;
      
      private var m_iArmor:int;
      
      private var m_iRing:int;
      
      private var m_iStatus:uint;
      
      private var m_afAbilDMG:Array = new Array();
      
      private var m_fAbilHPS:Number;
      
      private var m_afAbilDPS:Array = new Array();
      
      private var m_afDMG:Array = new Array();
      
      private var m_fHPS:Number;
      
      private var m_fHPS_NoRoF:Number;
      
      private var m_afDPS:Array = new Array();
      
      private var m_afDiffDMG:Array = new Array();
      
      private var m_fDiffHPS:Number;
      
      private var m_afDiffDPS:Array = new Array();
      
      private var m_afDiffDMG2:Array = new Array();
      
      private var m_afDiffDPS2:Array = new Array();
      
      private var m_aiMinDamage:Array = new Array();
      
      private var m_aiMaxDamage:Array = new Array();
      
      private var m_iProjectiles:uint;
      
      private var m_iColor:uint = 0;
      
      private var m_fOneHitChance:Number = 0;
      
      private var m_fTwoHitChance:Number = 0;
      
      private var m_bArmored:Boolean;
      
      private var m_bCursed:Boolean;
      
      public var vStatsBase:Vector.<int> = new Vector.<int>(8,true);
      
      public var vStatsBonus:Vector.<int> = new Vector.<int>(8,true);
      
      public var sChangeBullet:String = "";
      
      private var Wep:Weapon;
      
      public function CharComposition(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:uint, param12:Boolean)
      {
         super();
         this.Update(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function Update(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:uint, param12:Boolean) : void
      {
         this.m_iClass = param1;
         this.vStatsBase[Stat.ATT] = param2;
         this.vStatsBase[Stat.DEF] = param5;
         this.vStatsBase[Stat.DEX] = param3;
         this.vStatsBase[Stat.WIS] = param4;
         this.m_iPetLevelMP = param10;
         this.m_iWeapon = param6;
         this.m_iAbility = param7;
         this.m_iArmor = param8;
         this.m_iRing = param9;
         this.m_iStatus = param11;
         this.m_bCursed = param12;
         this.Calculate();
      }
      
      public function Clone() : CharComposition
      {
         var _loc1_:CharComposition = new CharComposition(this.m_iClass,this.vStatsBase[Stat.ATT],this.vStatsBase[Stat.DEX],this.vStatsBase[Stat.WIS],this.vStatsBase[Stat.DEF],this.m_iWeapon,this.m_iAbility,this.m_iArmor,this.m_iRing,this.m_iPetLevelMP,this.m_iStatus,this.m_bCursed);
         _loc1_.iColor = this.iColor;
         _loc1_.SetWep(this.Wep);
         _loc1_.CalculateForWepEdit();
         return _loc1_;
      }
      
      private function GetBonusStats(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:uint = 0;
         for each(_loc2_ in param1.ActivateOnEquip)
         {
            _loc3_ = Stat.iIxFrId(_loc2_.@stat);
            this.vStatsBonus[_loc3_] += int(_loc2_.@amount);
         }
      }
      
      private function GetBonusStatsWep() : void
      {
         var _loc1_:int = int(this.Wep.vStats.length);
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            this.vStatsBonus[_loc2_] += this.Wep.vStats[_loc2_];
            _loc2_++;
         }
      }
      
      private function GetBonusStatsSet(param1:XML) : void
      {
         var _loc2_:XML = null;
         for each(_loc2_ in param1.ActivateOnEquipAll)
         {
            this.vStatsBonus[Stat.iIxFrId(_loc2_.@stat)] = this.vStatsBonus[Stat.iIxFrId(_loc2_.@stat)] + int(_loc2_.@amount);
         }
      }
      
      public function SetWep(param1:Weapon) : void
      {
         this.Wep = param1;
      }
      
      public function CalculateForWepEdit() : void
      {
         this.Calculate();
      }
      
      private function Calculate(param1:uint = 0, param2:uint = 0, param3:Boolean = false) : void
      {
         var _loc9_:XML = null;
         var _loc10_:XML = null;
         var _loc11_:XML = null;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Boolean = false;
         var _loc16_:uint = 0;
         var _loc17_:* = undefined;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:String = null;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:Number = NaN;
         var _loc25_:uint = 0;
         var _loc26_:XML = null;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:Number = NaN;
         var _loc30_:uint = 0;
         var _loc31_:int = 0;
         var _loc32_:uint = 0;
         var _loc33_:Number = NaN;
         var _loc34_:uint = 0;
         var _loc35_:uint = 0;
         var _loc36_:Number = NaN;
         var _loc37_:uint = 0;
         var _loc38_:int = 0;
         var _loc39_:uint = 0;
         if(this.Wep == null)
         {
            return;
         }
         var _loc4_:uint = uint(this.m_iStatus >> 4);
         var _loc5_:uint = uint(this.m_iStatus - (_loc4_ << 4) >> 3);
         var _loc6_:uint = uint(this.m_iStatus - (_loc4_ << 4) - (_loc5_ << 3) >> 2);
         var _loc7_:uint = uint(this.m_iStatus - (_loc4_ << 4) - (_loc5_ << 3) - (_loc6_ << 2) >> 1);
         var _loc8_:uint = uint(this.m_iStatus - (_loc4_ << 4) - (_loc5_ << 3) - (_loc6_ << 2) - (_loc7_ << 1) >> 0);
         this.m_bArmored = Boolean(_loc8_);
         if(this.m_bCursed)
         {
            param3 = this.m_bCursed;
         }
         _loc9_ = XmlData.ObjectById(this.m_iAbility);
         _loc10_ = XmlData.ObjectById(this.m_iArmor);
         _loc11_ = XmlData.ObjectById(this.m_iRing);
         _loc12_ = this.Wep.fRateOfFire;
         _loc13_ = uint(this.Wep.iMinDamage);
         _loc14_ = uint(this.Wep.iMaxDamage);
         _loc15_ = this.Wep.bArmorPiercing;
         _loc16_ = this.m_iProjectiles = this.Wep.iProjectiles;
         _loc17_ = 0;
         while(_loc17_ < this.vStatsBonus.length)
         {
            this.vStatsBonus[_loc17_] = 0;
            _loc17_++;
         }
         this.sChangeBullet = "";
         _loc18_ = 0;
         _loc19_ = 0;
         this.GetBonusStatsWep();
         _loc19_ = this.Wep.iSetType;
         if(_loc19_ != 0)
         {
            _loc18_++;
         }
         if(_loc9_ != null)
         {
            this.GetBonusStats(_loc9_);
            if(uint(_loc9_.@setType) == _loc19_)
            {
               _loc18_++;
            }
         }
         if(_loc10_ != null)
         {
            this.GetBonusStats(_loc10_);
            if(uint(_loc10_.@setType) == _loc19_)
            {
               _loc18_++;
            }
         }
         if(_loc11_ != null)
         {
            this.GetBonusStats(_loc11_);
            if(uint(_loc11_.@setType) == _loc19_)
            {
               _loc18_++;
            }
         }
         if(_loc18_ == 4)
         {
            _loc26_ = XmlData.aEqSets[_loc19_];
            this.sChangeBullet = _loc26_.ActivateOnEquipAll[0].@bulletType;
            this.GetBonusStatsSet(_loc26_);
         }
         _loc20_ = 0;
         if(this.m_iAbility)
         {
            _loc20_ = uint(_loc9_.SlotType);
            _loc21_ = _loc9_.@id;
         }
         _loc22_ = this.iStatTotal(Stat.DEX) * (1 - _loc7_);
         _loc23_ = this.iStatTotal(Stat.ATT) * (1 - _loc5_);
         this.m_fHPS_NoRoF = 1.5 + 6.5 * _loc22_ / 75;
         this.m_fHPS = this.m_fHPS_NoRoF * _loc12_;
         _loc24_ = 0.5 + _loc23_ / 50;
         if(Boolean(_loc6_) && !_loc7_)
         {
            this.m_fHPS *= 1.5;
         }
         if(Boolean(_loc4_) && !_loc5_)
         {
            _loc24_ *= 1.5;
         }
         if(_loc14_ - _loc13_ == 0)
         {
            _loc14_++;
         }
         _loc25_ = 0;
         while(_loc25_ <= 200 || _loc25_ == 1000 || _loc25_ == 2000 || _loc25_ == 5000)
         {
            if(Boolean(param1) && param2 == _loc25_)
            {
               this.m_fOneHitChance = 0;
               this.m_fTwoHitChance = 0;
            }
            _loc27_ = 0;
            _loc28_ = _loc13_;
            while(_loc28_ < _loc14_)
            {
               _loc30_ = _loc28_ * _loc24_;
               _loc31_ = _loc30_ - _loc25_ * int(!_loc15_);
               _loc32_ = _loc30_ * 0.15;
               if(param3)
               {
                  _loc31_ *= 1.2;
               }
               if(_loc32_ > _loc31_)
               {
                  _loc31_ = int(_loc32_);
               }
               _loc27_ += _loc31_;
               if(Boolean(param1) && param2 == _loc25_)
               {
                  if(_loc31_ > param1)
                  {
                     ++this.m_fOneHitChance;
                  }
                  if(_loc31_ * 2 > param1)
                  {
                     ++this.m_fTwoHitChance;
                  }
               }
               if(_loc28_ == _loc13_)
               {
                  this.m_aiMinDamage[_loc25_] = _loc31_;
               }
               if(_loc28_ == _loc14_ - 1)
               {
                  this.m_aiMaxDamage[_loc25_] = _loc31_;
               }
               _loc28_++;
            }
            if(param1 && param2 == _loc25_ && Boolean(this.m_fOneHitChance))
            {
               this.m_fOneHitChance /= _loc28_ - _loc13_;
            }
            if(param1 && param2 == _loc25_ && Boolean(this.m_fTwoHitChance))
            {
               this.m_fTwoHitChance /= _loc28_ - _loc13_;
            }
            _loc29_ = _loc27_ / (_loc28_ - _loc13_);
            _loc29_ = _loc29_ * _loc16_;
            this.m_afDMG[_loc25_] = _loc29_;
            this.m_afDPS[_loc25_] = _loc29_ * this.m_fHPS;
            this.m_afDiffDMG[_loc25_] = 0;
            this.m_afDiffDPS[_loc25_] = 0;
            this.m_afDiffDMG2[_loc25_] = 0;
            this.m_afDiffDPS2[_loc25_] = 0;
            if(!_loc6_ && (_loc20_ == HELM || _loc21_ == "Soul of the Bearer"))
            {
               this.m_afDiffDMG[_loc25_] = _loc29_;
               this.m_afDiffDPS[_loc25_] = _loc29_ * this.m_fHPS * 1.5;
               this.m_afDiffDMG[_loc25_] -= this.m_afDMG[_loc25_];
               this.m_afDiffDPS[_loc25_] -= this.m_afDPS[_loc25_];
            }
            if(!_loc4_ && (_loc20_ == SEAL || _loc21_ == "Orb of Conflict"))
            {
               _loc33_ = 1.5;
               if(_loc21_ == "Orb of Conflict")
               {
                  _loc33_ = 1.5;
               }
               _loc34_ = 0;
               _loc35_ = _loc13_;
               while(_loc35_ < _loc14_)
               {
                  _loc37_ = _loc35_ * _loc24_ * _loc33_;
                  _loc38_ = _loc37_ - _loc25_ * int(!_loc15_);
                  _loc39_ = _loc37_ * 0.15;
                  if(this.m_bCursed)
                  {
                     _loc38_ *= 1.2;
                  }
                  if(_loc39_ > _loc38_)
                  {
                     _loc38_ = int(_loc39_);
                  }
                  _loc34_ += _loc38_;
                  _loc35_++;
               }
               _loc36_ = _loc34_ / (_loc35_ - _loc13_);
               _loc36_ = _loc36_ * _loc16_;
               this.m_afDiffDMG[_loc25_] = _loc36_;
               this.m_afDiffDPS[_loc25_] = _loc36_ * this.m_fHPS;
               this.m_afDiffDMG[_loc25_] -= this.m_afDMG[_loc25_];
               this.m_afDiffDPS[_loc25_] -= this.m_afDPS[_loc25_];
            }
            if(_loc20_ == ORB && _loc21_ != "Orb of Conflict" && _loc21_ != "Soul of the Bearer")
            {
               _loc34_ = 0;
               _loc35_ = _loc13_;
               while(_loc35_ < _loc14_)
               {
                  _loc37_ = _loc35_ * _loc24_;
                  _loc38_ = _loc37_ - _loc25_ * int(!_loc15_);
                  _loc39_ = _loc37_ * 0.15;
                  _loc38_ *= 1.2;
                  if(_loc39_ > _loc38_)
                  {
                     _loc38_ = int(_loc39_);
                  }
                  _loc34_ += _loc38_;
                  _loc35_++;
               }
               _loc36_ = _loc34_ / (_loc35_ - _loc13_);
               _loc36_ = _loc36_ * _loc16_;
               this.m_afDiffDMG[_loc25_] = _loc36_;
               this.m_afDiffDPS[_loc25_] = _loc36_ * this.m_fHPS;
               this.m_afDiffDMG[_loc25_] -= this.m_afDMG[_loc25_];
               this.m_afDiffDPS[_loc25_] -= this.m_afDPS[_loc25_];
               if(_loc21_ == "Banishment Orb" || _loc21_ == "Planefetter Orb")
               {
                  this.m_afDiffDMG2[_loc25_] = _loc36_;
                  this.m_afDiffDPS2[_loc25_] = _loc36_ * this.m_fHPS * 1.5;
                  this.m_afDiffDMG2[_loc25_] -= this.m_afDMG[_loc25_];
                  this.m_afDiffDPS2[_loc25_] -= this.m_afDPS[_loc25_];
                  if(_loc6_)
                  {
                     this.m_afDiffDPS2[_loc25_] = this.m_afDiffDPS[_loc25_];
                  }
               }
            }
            if(_loc25_ == 200)
            {
               _loc25_ = 999;
            }
            if(_loc25_ == 1000)
            {
               _loc25_ = 1999;
            }
            if(_loc25_ == 2000)
            {
               _loc25_ = 4999;
            }
            _loc25_++;
         }
         this.CalculateAbility();
      }
      
      private function SetAbilToZero() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ <= 200 || _loc1_ == 1000 || _loc1_ == 2000 || _loc1_ == 5000)
         {
            this.m_afAbilDMG[_loc1_] = 0;
            this.m_afAbilDPS[_loc1_] = 0;
            _loc1_++;
         }
         this.m_fAbilHPS = 0;
      }
      
      private function CalculateAbility() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:XML = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = undefined;
         var _loc17_:Number = NaN;
         var _loc18_:* = undefined;
         var _loc19_:Number = NaN;
         var _loc20_:uint = 0;
         var _loc21_:int = 0;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:* = false;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:Number = NaN;
         var _loc30_:uint = 0;
         if(!this.m_iAbility)
         {
            return this.SetAbilToZero();
         }
         var _loc1_:XML = XmlData.ObjectById(this.m_iAbility);
         var _loc2_:uint = uint(_loc1_.SlotType);
         var _loc3_:String = _loc1_.@id;
         if(_loc2_ == CLOAK)
         {
            return this.SetAbilToZero();
         }
         _loc4_ = 0.5 + this.iStatTotal(Stat.WIS) * 0.06;
         _loc4_ = _loc4_ + this.GetPetMPPerSecond(this.m_iPetLevelMP);
         if(_loc1_.MultiPhase != undefined)
         {
            _loc5_ = uint(_loc1_.MpEndCost);
         }
         else
         {
            _loc5_ = uint(_loc1_.MpCost);
         }
         this.m_fAbilHPS = _loc4_ / _loc5_;
         _loc6_ = 0.5;
         if(_loc1_.Cooldown != undefined)
         {
            _loc6_ = Number(_loc1_.Cooldown);
         }
         this.m_fAbilHPS = Math.min(this.m_fAbilHPS,1 / _loc6_);
         if(_loc2_ == HELM || _loc3_ == "Soul of the Bearer")
         {
            _loc7_ = 0;
            _loc8_ = uint(_loc1_.Activate.length());
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc13_ = _loc1_.Activate[_loc9_];
               if(_loc13_.@effect == "Berserk")
               {
                  _loc7_ = Number(_loc13_.@duration);
                  if(_loc13_.@useWisMod != undefined && _loc13_.@useWisMod == "true")
                  {
                     _loc7_ *= this.fWisMod;
                  }
                  break;
               }
               _loc9_++;
            }
            _loc10_ = Math.min(1,_loc7_ / _loc6_);
            _loc11_ = Math.min(_loc10_,_loc7_ * _loc4_ / _loc5_);
            _loc12_ = 0;
            while(_loc12_ <= 200 || _loc12_ == 1000 || _loc12_ == 2000 || _loc12_ == 5000)
            {
               this.m_afAbilDPS[_loc12_] = this.m_afDiffDPS[_loc12_] * _loc11_;
               if(_loc12_ == 200)
               {
                  _loc12_ = 999;
               }
               if(_loc12_ == 1000)
               {
                  _loc12_ = 1999;
               }
               if(_loc12_ == 2000)
               {
                  _loc12_ = 4999;
               }
               _loc12_++;
            }
         }
         else if(_loc2_ == SEAL || _loc3_ == "Orb of Conflict")
         {
            _loc14_ = 0;
            _loc8_ = uint(_loc1_.Activate.length());
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc13_ = _loc1_.Activate[_loc9_];
               if(_loc13_.@effect == "Damaging")
               {
                  _loc14_ = Number(_loc13_.@duration);
                  if(_loc13_.@useWisMod != undefined && _loc13_.@useWisMod == "true")
                  {
                     _loc14_ *= this.fWisMod;
                  }
                  break;
               }
               _loc9_++;
            }
            _loc10_ = Math.min(1,_loc14_ / _loc6_);
            _loc11_ = Math.min(_loc10_,_loc14_ * _loc4_ / _loc5_);
            _loc12_ = 0;
            while(_loc12_ <= 200 || _loc12_ == 1000 || _loc12_ == 2000 || _loc12_ == 5000)
            {
               this.m_afAbilDPS[_loc12_] = this.m_afDiffDPS[_loc12_] * _loc11_;
               if(_loc12_ == 200)
               {
                  _loc12_ = 999;
               }
               if(_loc12_ == 1000)
               {
                  _loc12_ = 1999;
               }
               if(_loc12_ == 2000)
               {
                  _loc12_ = 4999;
               }
               _loc12_++;
            }
         }
         else if(_loc2_ == ORB)
         {
            _loc7_ = 0;
            _loc15_ = 0;
            _loc8_ = uint(_loc1_.Activate.length());
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc13_ = _loc1_.Activate[_loc9_];
               if(_loc13_.@effect == "Berserk")
               {
                  _loc7_ = Number(_loc13_.@duration);
                  if(_loc13_.@useWisMod != undefined && _loc13_.@useWisMod == "true")
                  {
                     _loc7_ *= this.fWisMod;
                  }
               }
               if(_loc13_.@effect == "Curse")
               {
                  _loc15_ = Number(_loc13_.@duration);
                  if(_loc13_.@useWisMod != undefined && _loc13_.@useWisMod == "true")
                  {
                     _loc15_ *= this.fWisMod;
                  }
               }
               _loc9_++;
            }
            _loc16_ = Math.min(1,_loc7_ / _loc6_);
            _loc17_ = Math.min(_loc16_,_loc7_ * _loc4_ / _loc5_);
            _loc18_ = Math.min(1,_loc15_ / _loc6_);
            _loc19_ = Math.min(_loc18_,_loc15_ * _loc4_ / _loc5_);
            while(_loc12_ <= 200 || _loc12_ == 1000 || _loc12_ == 2000 || _loc12_ == 5000)
            {
               this.m_afAbilDPS[_loc12_] = this.m_afDiffDPS[_loc12_] * (_loc19_ - _loc17_) + this.m_afDiffDPS2[_loc12_] * _loc17_;
               if(_loc12_ == 200)
               {
                  _loc12_ = 999;
               }
               if(_loc12_ == 1000)
               {
                  _loc12_ = 1999;
               }
               if(_loc12_ == 2000)
               {
                  _loc12_ = 4999;
               }
               _loc12_++;
            }
         }
         else if(_loc2_ == POISON || _loc2_ == SKULL || _loc2_ == TRAP || _loc2_ == SCEPTER)
         {
            _loc20_ = uint(_loc1_.Activate.@totalDamage);
            _loc12_ = 0;
            while(_loc12_ <= 200 || _loc12_ == 1000 || _loc12_ == 2000 || _loc12_ == 5000)
            {
               _loc21_ = _loc20_ - _loc12_;
               _loc22_ = _loc20_ * 0.15;
               if(this.m_bCursed)
               {
                  _loc21_ *= 1.2;
               }
               if(_loc22_ > _loc21_)
               {
                  _loc21_ = int(_loc22_);
               }
               this.m_afAbilDPS[_loc12_] = _loc21_ * this.m_fAbilHPS;
               if(_loc12_ == 200)
               {
                  _loc12_ = 999;
               }
               if(_loc12_ == 1000)
               {
                  _loc12_ = 1999;
               }
               if(_loc12_ == 2000)
               {
                  _loc12_ = 4999;
               }
               _loc12_++;
            }
         }
         else if(_loc2_ == SPELL || _loc2_ == SHIELD || _loc2_ == QUIVER || _loc2_ == SHURIKEN || _loc2_ == PRISM)
         {
            _loc23_ = 1;
            _loc24_ = 0;
            _loc25_ = 0;
            _loc26_ = _loc1_.Projectile.ArmorPiercing != undefined;
            if(_loc2_ == SPELL || _loc2_ == PRISM)
            {
               _loc8_ = uint(_loc1_.Activate.length());
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc13_ = _loc1_.Activate[_loc9_];
                  if(_loc13_.@effect == "BulletNova" || _loc13_.@effect == "Decoy")
                  {
                     if(_loc13_.@effect == "BulletNova")
                     {
                        _loc23_ = 20;
                     }
                     else
                     {
                        _loc23_ = 0;
                     }
                     if(_loc13_.@numShots != undefined)
                     {
                        _loc23_ = uint(_loc13_.@numShots);
                     }
                  }
                  _loc9_++;
               }
            }
            else if(_loc1_.NumProjectiles != undefined)
            {
               _loc23_ = uint(int(_loc1_.NumProjectiles));
            }
            _loc24_ = uint(_loc1_.Projectile.MinDamage);
            _loc25_ = uint(_loc1_.Projectile.MaxDamage);
            if(_loc3_ == "Ghostly Prism")
            {
               _loc23_ = 6;
               _loc24_ = 320;
               _loc25_ = 480;
            }
            if(_loc25_ - _loc24_ == 0)
            {
               _loc25_++;
            }
            _loc12_ = 0;
            while(_loc12_ <= 200 || _loc12_ == 1000 || _loc12_ == 2000 || _loc12_ == 5000)
            {
               _loc27_ = 0;
               _loc28_ = _loc24_;
               while(_loc28_ < _loc25_)
               {
                  _loc30_ = _loc28_;
                  _loc21_ = _loc30_ - _loc12_ * int(!_loc26_);
                  _loc22_ = _loc30_ * 0.15;
                  if(this.m_bCursed)
                  {
                     _loc21_ *= 1.2;
                  }
                  if(_loc22_ > _loc21_)
                  {
                     _loc21_ = int(_loc22_);
                  }
                  _loc27_ += _loc21_;
                  _loc28_++;
               }
               _loc29_ = _loc27_ / (_loc28_ - _loc24_);
               _loc29_ = _loc29_ * _loc23_;
               this.m_afAbilDPS[_loc12_] = _loc29_ * this.m_fAbilHPS;
               if(_loc12_ == 200)
               {
                  _loc12_ = 999;
               }
               if(_loc12_ == 1000)
               {
                  _loc12_ = 1999;
               }
               if(_loc12_ == 2000)
               {
                  _loc12_ = 4999;
               }
               _loc12_++;
            }
         }
      }
      
      private function get fWisMod() : Number
      {
         return Utils.fWisMod(this.iStatTotal(Stat.WIS));
      }
      
      private function iGetBonus(param1:XML, param2:uint) : int
      {
         var _loc3_:XML = null;
         for each(_loc3_ in param1.ActivateOnEquip)
         {
            if(uint(_loc3_.@stat) == param2)
            {
               return int(_loc3_.@amount);
            }
         }
         return 0;
      }
      
      private function iGetBonusSet(param1:XML, param2:uint) : int
      {
         var _loc3_:XML = null;
         for each(_loc3_ in param1.ActivateOnEquipAll)
         {
            if(uint(_loc3_.@stat) == param2)
            {
               return int(_loc3_.@amount);
            }
         }
         return 0;
      }
      
      public function GetOneHitChance(param1:uint, param2:uint, param3:Boolean) : Number
      {
         this.Calculate(param1,param2,param3);
         return this.m_fOneHitChance;
      }
      
      public function GetTwoHitChance(param1:uint, param2:uint, param3:Boolean) : Number
      {
         this.Calculate(param1,param2,param3);
         return this.m_fTwoHitChance;
      }
      
      public function GetDef() : uint
      {
         return this.iStatTotal(Stat.DEF);
      }
      
      public function IsArmored() : Boolean
      {
         return this.m_bArmored;
      }
      
      public function GetMinDmg(param1:uint) : Number
      {
         return this.m_aiMinDamage[param1];
      }
      
      public function GetMaxDmg(param1:uint) : Number
      {
         return this.m_aiMaxDamage[param1];
      }
      
      public function GetDMG(param1:uint) : Number
      {
         return this.m_afDMG[param1];
      }
      
      public function GetHPS() : Number
      {
         return this.m_fHPS;
      }
      
      public function GetHPS_NoRoF() : Number
      {
         return this.m_fHPS_NoRoF;
      }
      
      public function GetDPS(param1:uint, param2:Boolean = false) : Number
      {
         return this.m_afDPS[param1];
      }
      
      public function GetAbilDMG(param1:uint) : Number
      {
         return this.m_afAbilDMG[param1];
      }
      
      public function GetAbilHPS() : Number
      {
         return this.m_fAbilHPS;
      }
      
      public function GetAbilDPS(param1:uint) : Number
      {
         return this.m_afAbilDPS[param1];
      }
      
      public function GetProjectiles() : uint
      {
         return this.m_iProjectiles;
      }
      
      public function get aDPS() : Array
      {
         return this.m_afDPS;
      }
      
      public function get iBonusAtt() : int
      {
         return this.vStatsBonus[Stat.ATT];
      }
      
      public function get iBonusDex() : int
      {
         return this.vStatsBonus[Stat.DEX];
      }
      
      public function get iBonusWis() : int
      {
         return this.vStatsBonus[Stat.WIS];
      }
      
      public function get iBonusDef() : int
      {
         return this.vStatsBonus[Stat.DEF];
      }
      
      public function get iColor() : uint
      {
         return this.m_iColor;
      }
      
      public function set iColor(param1:uint) : void
      {
         this.m_iColor = param1;
      }
      
      public function toSprite() : Sprite
      {
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:RotMGSprite = null;
         var _loc14_:RotMGSprite = null;
         var _loc15_:RotMGSprite = null;
         var _loc16_:RotMGSprite = null;
         var _loc17_:Bitmap = null;
         var _loc18_:Bitmap = null;
         var _loc19_:Bitmap = null;
         var _loc20_:Bitmap = null;
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Sprite = new Sprite();
         var _loc4_:RotMGSprite = new RotMGSprite(XmlData.aPlayers[this.m_iClass],2);
         _loc3_.addChild(_loc4_);
         var _loc5_:TextField = Tooltip.AddTextField(16 + 1,-5,16,Constants.TEXT_FORMAT_CHARCOMP_STAT);
         _loc5_.antiAliasType = "advanced";
         _loc5_.sharpness = 100;
         _loc5_.thickness = 0;
         _loc5_.text = String(this.vStatsBase[Stat.ATT]);
         _loc2_.addChild(_loc5_);
         var _loc6_:TextField = Tooltip.AddTextField(16 + 1,4,16,Constants.TEXT_FORMAT_CHARCOMP_STAT);
         _loc6_.antiAliasType = "advanced";
         _loc6_.sharpness = 100;
         _loc6_.thickness = 0;
         _loc6_.text = String(this.vStatsBase[Stat.DEX]);
         _loc2_.addChild(_loc6_);
         var _loc7_:TextField = Tooltip.AddTextField(13 + 16 + 1,-5,24,Constants.TEXT_FORMAT_CHARCOMP_STAT);
         _loc7_.antiAliasType = "advanced";
         _loc7_.sharpness = 100;
         _loc7_.thickness = 0;
         _loc7_.text = String(this.vStatsBase[Stat.WIS]);
         _loc2_.addChild(_loc7_);
         var _loc8_:TextField = Tooltip.AddTextField(13 + 16 + 1,4,24,Constants.TEXT_FORMAT_CHARCOMP_STAT);
         _loc8_.antiAliasType = "advanced";
         _loc8_.sharpness = 100;
         _loc8_.thickness = 0;
         _loc8_.text = String(this.m_iPetLevelMP);
         _loc2_.addChild(_loc8_);
         if(this.Wep != null)
         {
            _loc13_ = new RotMGSprite(this.Wep.GetXML(),2);
            _loc13_.x = -7 + 18 + 20 * 2;
            _loc3_.addChild(_loc13_);
         }
         if(XmlData.ObjectById(this.m_iAbility))
         {
            _loc14_ = new RotMGSprite(XmlData.ObjectById(this.m_iAbility),2);
            _loc14_.x = -7 + 18 + 20 * 3;
            _loc3_.addChild(_loc14_);
         }
         if(XmlData.ObjectById(this.m_iArmor))
         {
            _loc15_ = new RotMGSprite(XmlData.ObjectById(this.m_iArmor),2);
            _loc15_.x = -7 + 18 + 20 * 4;
            _loc3_.addChild(_loc15_);
         }
         if(XmlData.ObjectById(this.m_iRing))
         {
            _loc16_ = new RotMGSprite(XmlData.ObjectById(this.m_iRing),2);
            _loc16_.x = -7 + 18 + 20 * 5;
            _loc3_.addChild(_loc16_);
         }
         _loc9_ = uint(this.m_iStatus >> 4);
         _loc10_ = uint(this.m_iStatus - (_loc9_ << 4) >> 3);
         _loc11_ = uint(this.m_iStatus - (_loc9_ << 4) - (_loc10_ << 3) >> 2);
         _loc12_ = uint(this.m_iStatus - (_loc9_ << 4) - (_loc10_ << 3) - (_loc11_ << 2) >> 1);
         if(_loc9_)
         {
            _loc17_ = SpriteParser.GetSprite("lofiInterface2",49);
            _loc17_.x = -7 + 18 + 20 * 6;
            _loc17_.y = -1;
            _loc3_.addChild(_loc17_);
         }
         if(_loc10_)
         {
            _loc18_ = SpriteParser.GetSprite("lofiInterface2",34);
            _loc18_.x = -7 + 18 + 20 * 6 + 8;
            _loc18_.y = -1;
            _loc3_.addChild(_loc18_);
         }
         if(_loc11_)
         {
            _loc19_ = SpriteParser.GetSprite("lofiInterface2",50);
            _loc19_.x = -7 + 18 + 20 * 6;
            _loc19_.y = 8;
            _loc3_.addChild(_loc19_);
         }
         if(_loc12_)
         {
            _loc20_ = SpriteParser.GetSprite("lofiInterface2",44);
            _loc20_.x = -7 + 18 + 20 * 6 + 8;
            _loc20_.y = 8 + 1;
            _loc3_.addChild(_loc20_);
         }
         _loc3_.filters = [Constants.BLACK_OUTLINE];
         _loc2_.filters = [Constants.BLACK_OUTLINE];
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc2_);
         _loc1_.graphics.lineStyle(2,this.iColor,1,true,"normal","none","miter");
         _loc1_.graphics.drawRect(-4,-4,137 + 18,24);
         return _loc1_;
      }
      
      private function GetPetMagicMaxHeal(param1:uint) : int
      {
         switch(param1)
         {
            case 0:
               return 0;
            case 1:
               return 1;
            case 30:
               return 3;
            case 50:
               return 8;
            case 70:
               return 17;
            case 90:
               return 33;
            case 100:
               return 45;
            default:
               var _loc2_:XML = XmlData.ObjectByName("MagicHeal");
               var _loc3_:int = int(_loc2_.Parameters.MaxHeal.@min);
               var _loc4_:int = int(_loc2_.Parameters.MaxHeal.@max);
               var _loc5_:String = _loc2_.Parameters.MaxHeal.@curve;
               return int(_loc3_ + (_loc4_ - _loc3_) * (param1 / 100));
         }
      }
      
      private function GetPetMagicCooldown(param1:uint) : Number
      {
         switch(param1)
         {
            case 0:
               return 0;
            case 1:
               return 10;
            case 30:
               return 6;
            case 50:
               return 4;
            case 70:
               return 2;
            case 90:
               return 1.5;
            case 100:
               return 1;
            default:
               var _loc2_:XML = XmlData.ObjectByName("MagicHeal");
               var _loc3_:int = int(_loc2_.Parameters.Cooldown.@min);
               var _loc4_:int = int(_loc2_.Parameters.Cooldown.@max);
               var _loc5_:String = _loc2_.Parameters.Cooldown.@curve;
               return _loc4_ + (_loc3_ - _loc4_) * (1 - param1 / 100);
         }
      }
      
      private function GetPetMPPerSecond(param1:uint) : Number
      {
         if(param1)
         {
            return this.GetPetMagicMaxHeal(param1) / this.GetPetMagicCooldown(param1);
         }
         return 0;
      }
      
      public function toString() : String
      {
         return "";
      }
      
      public function iStatTotal(param1:uint) : uint
      {
         return this.vStatsBase[param1] + this.vStatsBonus[param1];
      }
      
      public function iItemID_Slot(param1:uint) : uint
      {
         switch(param1)
         {
            case 0:
               return this.Wep.iID;
            case 1:
               return this.m_iAbility;
            case 2:
               return this.m_iArmor;
            case 3:
               return this.m_iRing;
            default:
               return 0;
         }
      }
   }
}


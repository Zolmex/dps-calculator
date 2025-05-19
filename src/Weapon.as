package
{
   import com.pfiffel.util.MathUtil;
   
   public class Weapon
   {
      public static const PARTICLE_LIFETIME:uint = 500;
      
      public static const PARTICLE_MAXSPEED:uint = 30;
      
      public static const PARTICLE_DEFAULT_COLOR:uint = 16711935;
      
      public var iID:int;
      
      public var sName:String;
      
      public var iParticleTrail:uint;
      
      public var fParticleIntensity:Number;
      
      public var iParticleLifeTime:uint;
      
      public var iSize:int;
      
      public var fSpeed:Number;
      
      public var iLifeTime:int;
      
      public var fAmplitude:Number;
      
      public var fFrequency:Number;
      
      public var bWavy:Boolean;
      
      public var bParametric:Boolean;
      
      public var iProjectiles:int;
      
      public var fArcGap:Number;
      
      public var fRateOfFire:Number;
      
      public var iMinDamage:int;
      
      public var iMaxDamage:int;
      
      public var bMultiHit:Boolean;
      
      public var bArmorPiercing:Boolean;
      
      public var bPassesCover:Boolean;
      
      public var vStats:Vector.<int> = new Vector.<int>(8,true);
      
      public var iTier:int;
      
      public var iBagType:int;
      
      public var iFameBonus:int;
      
      public var iFeedPower:int;
      
      public var bSoulbound:Boolean;
      
      public var iSlotType:int;
      
      public var sDescr:String;
      
      public var sDisId:String;
      
      public var sTex:String;
      
      public var sProjId:String;
      
      public var iSetType:uint;
      
      public var sSetName:String;
      
      public var sSound:String;
      
      public var iSpriteIndex:uint;
      
      public var sSpriteFile:String;
      
      public function Weapon(param1:XML = null)
      {
         super();
         if(param1 != null)
         {
            this.CreateFromXML(param1);
         }
      }
      
      public function Clone() : Weapon
      {
         return new Weapon(this.GetXML());
      }
      
      private function CreateFromXML(param1:XML) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         var _loc4_:XML = null;
         this.iID = param1.@type;
         this.sName = param1.@id;
         this.fParticleIntensity = 1;
         this.iParticleLifeTime = PARTICLE_LIFETIME;
         if(param1.Projectile.ParticleTrail != undefined)
         {
            this.iParticleTrail = param1.Projectile.ParticleTrail;
            if(this.iParticleTrail == 0)
            {
               this.iParticleTrail = PARTICLE_DEFAULT_COLOR;
            }
            if(param1.Projectile.ParticleTrail.@intensity != undefined)
            {
               this.fParticleIntensity = param1.Projectile.ParticleTrail.@intensity;
            }
            if(param1.Projectile.ParticleTrail.@lifetimeMS != undefined)
            {
               this.iParticleLifeTime = param1.Projectile.ParticleTrail.@lifetimeMS;
            }
         }
         this.iSize = 100;
         if(param1.Projectile.Size != undefined)
         {
            this.iSize = param1.Projectile.Size;
         }
         this.fSpeed = param1.Projectile.Speed;
         this.iLifeTime = param1.Projectile.LifetimeMS;
         this.fAmplitude = param1.Projectile.Amplitude;
         this.fFrequency = 1;
         if(param1.Projectile.Frequency != undefined)
         {
            this.fFrequency = param1.Projectile.Frequency;
         }
         this.bWavy = param1.Projectile.Wavy != undefined;
         this.bParametric = param1.Projectile.Parametric != undefined;
         this.iProjectiles = 1;
         if(param1.NumProjectiles != undefined)
         {
            this.iProjectiles = param1.NumProjectiles;
         }
         this.fArcGap = 11.25;
         if(param1.ArcGap != undefined)
         {
            this.fArcGap = param1.ArcGap;
         }
         this.fRateOfFire = param1.RateOfFire;
         this.iMinDamage = param1.Projectile.MinDamage;
         this.iMaxDamage = param1.Projectile.MaxDamage;
         this.bMultiHit = param1.Projectile.MultiHit != undefined;
         this.bPassesCover = param1.Projectile.PassesCover != undefined;
         this.bArmorPiercing = param1.Projectile.ArmorPiercing != undefined;
         _loc2_ = uint(param1.ActivateOnEquip.length());
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.ActivateOnEquip[_loc3_];
            if(_loc4_ == "IncrementStat")
            {
               this.vStats[Stat.iIxFrId(uint(_loc4_.@stat))] = uint(_loc4_.@amount);
            }
            _loc3_++;
         }
         this.iTier = -1;
         if(param1.Tier != undefined)
         {
            this.iTier = param1.Tier;
         }
         this.iBagType = param1.BagType;
         this.iFameBonus = param1.FameBonus;
         this.iFeedPower = param1.feedPower;
         this.bSoulbound = param1.Soulbound != undefined;
         this.iSlotType = param1.SlotType;
         this.sDescr = param1.Description;
         this.sDisId = param1.DisplayId;
         this.sProjId = param1.Projectile.ObjectId;
         this.iSetType = param1.@setType;
         this.sSetName = param1.@setName;
         this.sSound = param1.Sound;
         this.sTex = param1.Texture;
         this.sSpriteFile = param1.Texture.File;
         this.iSpriteIndex = param1.Texture.Index;
      }
      
      public function Trace() : void
      {
         trace(this.sName + " | D: " + this.iMinDamage + " - " + this.iMaxDamage);
      }
      
      public function toString() : String
      {
         var _loc2_:* = null;
         var _loc3_:uint = 0;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc1_:* = "<Object type=\"0x" + this.iID.toString(16) + "\" id=\"" + this.sName + "\"";
         if(this.iSetType)
         {
            _loc1_ += " setType=\"0x" + this.iSetType.toString(16) + "\" setName=\"" + this.sSetName + "\"";
         }
         _loc1_ += ">\n";
         _loc1_ += "<Class>Equipment</Class>\n";
         _loc1_ += "<Item/>\n";
         _loc1_ += this.sTex + "\n";
         _loc1_ += "<SlotType>" + this.iSlotType + "</SlotType>\n";
         if(this.iTier >= 0)
         {
            _loc1_ += "<Tier>" + this.iTier + "</Tier>\n";
         }
         _loc1_ += "<Description>" + this.sDescr + "</Description>\n";
         _loc1_ += "<RateOfFire>" + this.fRateOfFire + "</RateOfFire>\n";
         _loc1_ += "<Sound>" + this.sSound + "</Sound>\n";
         _loc1_ += "<Projectile>\n";
         _loc1_ += "\t<ObjectId>" + this.sProjId + "</ObjectId>\n";
         _loc1_ += "\t<Speed>" + this.fSpeed + "</Speed>\n";
         _loc1_ += "\t<MinDamage>" + this.iMinDamage + "</MinDamage>\n";
         _loc1_ += "\t<MaxDamage>" + this.iMaxDamage + "</MaxDamage>\n";
         _loc1_ += "\t<LifetimeMS>" + this.iLifeTime + "</LifetimeMS>\n";
         if(this.fAmplitude)
         {
            _loc1_ += "\t<Amplitude>" + this.fAmplitude + "</Amplitude>\n";
         }
         if(this.fFrequency)
         {
            _loc1_ += "\t<Frequency>" + this.fFrequency + "</Frequency>\n";
         }
         _loc1_ += "\t<Size>" + this.iSize + "</Size>\n";
         if(this.bMultiHit)
         {
            _loc1_ += "\t<MultiHit/>\n";
         }
         if(this.bParametric)
         {
            _loc1_ += "\t<Parametric/>\n";
         }
         if(this.bPassesCover)
         {
            _loc1_ += "\t<PassesCover/>\n";
         }
         if(this.bWavy)
         {
            _loc1_ += "\t<Wavy/>\n";
         }
         if(this.bArmorPiercing)
         {
            _loc1_ += "\t<ArmorPiercing/>\n";
         }
         _loc2_ = "";
         if(this.iParticleTrail)
         {
            _loc5_ = "";
            if(this.fParticleIntensity != 1)
            {
               _loc5_ += " intensity=\"" + this.fParticleIntensity + "\"";
            }
            if(this.iParticleLifeTime != PARTICLE_LIFETIME)
            {
               _loc5_ += " lifetimeMS=\"" + this.iParticleLifeTime + "\"";
            }
            if(this.iParticleTrail == PARTICLE_DEFAULT_COLOR)
            {
               _loc2_ = "\t<ParticleTrail" + _loc5_ + "/>\n";
            }
            else
            {
               _loc2_ = "\t<ParticleTrail" + _loc5_ + ">0x" + this.iParticleTrail.toString(16) + "</ParticleTrail>\n";
            }
            _loc1_ += _loc2_;
         }
         _loc1_ += "</Projectile>\n";
         _loc1_ += "<NumProjectiles>" + this.iProjectiles + "</NumProjectiles>\n";
         _loc1_ += "<ArcGap>" + this.fArcGap + "</ArcGap>\n";
         _loc3_ = this.vStats.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.vStats[_loc4_])
            {
               _loc1_ += "<ActivateOnEquip stat=\"" + Stat.iIdFrIx(_loc4_) + "\" amount=\"" + this.vStats[_loc4_] + "\">IncrementStat</ActivateOnEquip>\n";
            }
            _loc4_++;
         }
         _loc1_ += "<BagType>" + this.iBagType + "</BagType>\n";
         _loc1_ += "<FameBonus>" + this.iFameBonus + "</FameBonus>\n";
         _loc1_ += "<feedPower>" + this.iFeedPower + "</feedPower>\n";
         if(this.bSoulbound)
         {
            _loc1_ += "<Soulbound/>\n";
         }
         _loc1_ += "<DisplayId>" + this.sDisId + "</DisplayId>\n";
         return _loc1_ + "</Object>\n";
      }
      
      public function GetXML() : XML
      {
         return XML(this.toString());
      }
      
      public function get fTrueRange() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:* = (this.iProjectiles - 1) * this.fArcGap;
         if(_loc1_ < 180)
         {
            _loc2_ = 0.5 / Math.cos(MathUtil.fDegToRad * (90 - _loc1_ / 2));
            _loc3_ = Math.sqrt(_loc2_ * _loc2_ - 0.5 * 0.5);
            if(_loc3_ < this.fRange)
            {
               return _loc3_;
            }
            return this.fRange;
         }
         return 0;
      }
      
      public function get fRange() : Number
      {
         return this.iLifeTime * this.fSpeed / 10000;
      }
      
      public function get fAverageDamage() : Number
      {
         return (this.iMinDamage + this.iMaxDamage) / 2;
      }
      
      public function get fDPS() : Number
      {
         return this.fAverageDamage * this.fRateOfFire * this.iProjectiles * (0.5 * 1.5);
      }
   }
}


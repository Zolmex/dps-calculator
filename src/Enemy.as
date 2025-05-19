package
{
   import com.pfiffel.util.MathUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Enemy extends Sprite
   {
      private var m_ID:uint;
      
      private var m_Xml:XML;
      
      private var m_EV:EnemyViewer;
      
      private var m_iEXP:uint;
      
      private var m_iNew:uint;
      
      public function Enemy(param1:EnemyViewer, param2:XML, param3:uint, param4:Number = 4)
      {
         super();
         this.m_EV = param1;
         this.m_Xml = param2;
         this.m_ID = param2.@type;
         this.m_iNew = param3;
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(5526612,1);
         _loc5_.graphics.drawRect(-4,-4,32 + 8,32 + 8);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         var _loc6_:RotMGSprite = new RotMGSprite(this.m_Xml,param4);
         _loc6_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_OBJECT];
         addChild(_loc6_);
         addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         var _loc7_:Number = 1;
         if(this.m_Xml.XpMult != undefined)
         {
            _loc7_ = Number(this.m_Xml.XpMult);
         }
         this.m_iEXP = Math.min(Math.ceil(uint(this.m_Xml.MaxHitPoints) / 10),195) * _loc7_;
      }
      
      public function GetValue(param1:String) : Number
      {
         var _loc2_:CharComposition = null;
         switch(param1)
         {
            case "God":
               return Number(this.m_Xml.God != undefined);
            case "Cube":
               return Number(this.m_Xml.Cube != undefined);
            case "Def":
               if(this.m_Xml.Defense == undefined)
               {
                  return 0;
               }
               return this.m_Xml.Defense[0];
               break;
            case "HP":
               return this.m_Xml.MaxHitPoints;
            case "EXP":
               return this.m_iEXP;
            case "OneHit":
               _loc2_ = this.m_EV.GetComp();
               return MathUtil.Round(_loc2_.GetOneHitChance(this.m_Xml.MaxHitPoints,this.m_Xml.Defense[0],this.m_EV.bCursed) * 100,2);
            case "New":
               return this.m_iNew;
            case "ID":
               return this.m_ID;
            default:
               return 0;
         }
      }
      
      public function GetValueString(param1:String) : String
      {
         switch(param1)
         {
            case "Group":
               if(this.m_Xml.Group != undefined)
               {
                  return this.m_Xml.Group;
               }
               return "zzz";
               break;
            case "Terrain":
               if(this.m_Xml.Terrain != undefined)
               {
                  return this.m_Xml.Terrain;
               }
               return "zzz";
               break;
            default:
               return "";
         }
      }
      
      public function GetName() : String
      {
         if(this.m_Xml.DisplayId != undefined)
         {
            return Language.getString(this.m_Xml.DisplayId);
         }
         return this.m_Xml.@id;
      }
      
      public function get Xml() : XML
      {
         return this.m_Xml;
      }
      
      public function get iID() : uint
      {
         return this.m_ID;
      }
      
      private function OnOver(param1:MouseEvent) : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc8_:TextField = null;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:String = null;
         var _loc18_:* = null;
         var _loc19_:Number = NaN;
         var _loc20_:CharComposition = null;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:* = null;
         var _loc26_:Number = NaN;
         var _loc27_:Vector.<String> = null;
         var _loc28_:String = null;
         var _loc29_:* = null;
         var _loc30_:* = undefined;
         var _loc31_:Sprite = null;
         var _loc32_:uint = 0;
         var _loc33_:TextFormatPlus = null;
         var _loc34_:TextField = null;
         var _loc35_:Array = null;
         var _loc36_:int = 0;
         var _loc37_:TextField = null;
         var _loc38_:TextField = null;
         var _loc39_:TextField = null;
         var _loc40_:TextField = null;
         var _loc41_:TextField = null;
         var _loc42_:uint = 0;
         var _loc43_:XML = null;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:RotMGSprite = null;
         var _loc47_:TextFormatPlus = null;
         var _loc48_:TextField = null;
         var _loc49_:TextField = null;
         var _loc50_:TextField = null;
         var _loc51_:* = false;
         var _loc52_:String = null;
         var _loc53_:TextField = null;
         var _loc54_:Vector.<String> = null;
         var _loc55_:* = null;
         var _loc56_:* = undefined;
         var _loc57_:TextField = null;
         var _loc58_:TextFormatPlus = null;
         var _loc59_:* = null;
         var _loc60_:int = 0;
         var _loc61_:* = undefined;
         var _loc62_:TextField = null;
         var _loc2_:Number = 400;
         _loc3_ = new Sprite();
         _loc4_ = new Sprite();
         _loc4_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         var _loc5_:Sprite = new BackgroundTooltip();
         _loc5_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         var _loc6_:uint = 3;
         var _loc7_:RotMGSprite = new RotMGSprite(this.m_Xml,3);
         _loc7_.x = _loc7_.y = 16;
         _loc7_.filters = [Constants.BLACK_OUTLINE];
         addChild(_loc7_);
         _loc8_ = Tooltip.AddTextField(50,_loc6_,200,Constants.TEXT_FORMAT_TT_HEADER);
         _loc8_.text = this.GetName();
         _loc6_ += 45;
         var _loc9_:TextField = Tooltip.AddTextField(10,_loc6_ - 4,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC_ID);
         _loc9_.antiAliasType = "advanced";
         _loc9_.sharpness = 20;
         _loc9_.thickness = 0;
         _loc9_.htmlText = "Type: 0x" + uint(this.m_Xml.@type).toString(16) + " - " + uint(this.m_Xml.@type) + " - ID: " + this.m_Xml.@id;
         _loc4_.addChild(_loc9_);
         _loc6_ += 14;
         var _loc10_:String = "";
         var _loc11_:Sprite = new Divider();
         _loc11_.width += 154;
         _loc11_.x = 10;
         _loc11_.y = _loc6_;
         _loc6_ += _loc11_.height + 4;
         var _loc12_:TextField = Tooltip.AddTextField(10,_loc6_,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         _loc12_.htmlText = "";
         if(DPSCalculator.TESTING)
         {
            _loc33_ = Constants.TEXT_FORMAT_TT_DESC.Clone();
            _loc33_.color = 16777215;
            _loc34_ = Tooltip.AddTextField(_loc2_,_loc6_,0,_loc33_);
            _loc34_.htmlText = "";
            _loc34_.filters = [Constants.BLACK_OUTLINE];
         }
         _loc13_ = 1;
         if(this.m_Xml.XpMult != undefined)
         {
            _loc13_ = Number(this.m_Xml.XpMult);
         }
         _loc14_ = uint(this.m_Xml.MaxHitPoints) * Number(this.m_Xml.XpMult) / 10;
         _loc15_ = uint(this.m_Xml.MaxHitPoints);
         _loc16_ = uint(this.m_Xml.Defense[0]);
         _loc17_ = "#BBBBBB";
         _loc18_ = "";
         if(this.m_EV.bArmored || this.m_EV.bBroken)
         {
            _loc18_ = " (" + _loc16_ + ")";
            if(this.m_EV.bArmored)
            {
               _loc16_ *= 2;
               _loc17_ = "#93572b";
            }
            if(this.m_EV.bBroken)
            {
               _loc16_ = 0;
               _loc17_ = "#540090";
            }
         }
         _loc19_ = 1;
         if(this.m_EV.bCursed)
         {
            _loc19_ = 1.2;
         }
         _loc20_ = this.m_EV.GetComp();
         _loc21_ = _loc20_.GetOneHitChance(_loc15_,_loc16_,this.m_EV.bCursed);
         _loc22_ = _loc20_.GetTwoHitChance(_loc15_,_loc16_,this.m_EV.bCursed);
         _loc23_ = _loc20_.GetDPS(_loc16_);
         _loc24_ = _loc15_ / _loc23_;
         _loc25_ = "<font color=\'#FF6666\'>";
         _loc25_ = _loc25_ + ("Av. Hit damage: " + "<b>" + MathUtil.Round(_loc20_.GetDMG(_loc16_),2) + "</b>");
         _loc25_ = _loc25_ + (" (" + "<b>" + int(_loc20_.GetMinDmg(_loc16_)) + " - " + int(_loc20_.GetMaxDmg(_loc16_)) + "</b>)");
         _loc25_ = _loc25_ + ("<br/>DPS Against: " + "<b>" + MathUtil.Round(_loc23_,2) + "</b>");
         _loc26_ = _loc15_ / _loc20_.GetDMG(_loc16_);
         _loc25_ += "<br/>Av. Time To Kill: " + "<b>" + MathUtil.Round(_loc24_,2) + " s</b>";
         _loc25_ = _loc25_ + (" Av. Hits To Kill: " + "<b>" + MathUtil.Round(_loc26_,2) + "</b>");
         _loc25_ = _loc25_ + ("<br/>One-Hit Chance: " + "<b>" + MathUtil.Round(_loc21_ * 100,2) + "%</b>");
         _loc25_ = _loc25_ + (" Two-Hit Chance: " + "<b>" + MathUtil.Round(_loc22_ * 100,2) + "%</b>");
         _loc25_ = _loc25_ + "</font>";
         if(DPSCalculator.TESTING)
         {
            _loc10_ += "<br/><br/><br/><br/><br/><br/>XpMult: <b>" + _loc13_ + "</b>";
            _loc34_.htmlText = _loc10_;
         }
         _loc12_.htmlText += "\nHealth: " + "<b>" + _loc15_ + "</b>";
         _loc12_.htmlText += "\n<font color=\'" + _loc17_ + "\'>Defense: " + "<b>" + _loc16_ + _loc18_ + "</b></font>";
         _loc12_.htmlText += _loc25_;
         _loc12_.htmlText += "\nEXP: " + "<b>" + this.m_iEXP + "</b>" + " (<b>" + _loc14_ + "</b>)";
         if(this.m_Xml.Group != undefined)
         {
            _loc12_.htmlText += "Group: <b>" + this.m_Xml.Group + "</b>";
         }
         if(this.m_Xml.Terrain != undefined)
         {
            _loc12_.htmlText += "Terrain:  <b>" + this.m_Xml.Terrain + "</b>";
         }
         if(this.m_Xml.LeachHealth != undefined)
         {
            _loc12_.htmlText += "Leaches Health";
         }
         if(this.m_Xml.StasisImmune != undefined)
         {
            _loc12_.htmlText += "Immune to Stasis";
         }
         if(this.m_Xml.StunImmune != undefined)
         {
            _loc12_.htmlText += "Immune to Stun";
         }
         if(this.m_Xml.ParalyzeImmune != undefined)
         {
            _loc12_.htmlText += "Immune to Paralyze";
         }
         if(this.m_Xml.DazedImmune != undefined)
         {
            _loc12_.htmlText += "Immune to Dazed";
         }
         _loc27_ = new Vector.<String>();
         if(this.m_Xml.God != undefined)
         {
            _loc27_.push("God");
         }
         if(this.m_Xml.Cube != undefined)
         {
            _loc27_.push("Cube");
         }
         if(this.m_Xml.Encounter != undefined)
         {
            _loc27_.push("Encounter");
         }
         if(this.m_Xml.Quest != undefined)
         {
            if(this.m_Xml.Level != undefined)
            {
               _loc27_.push("Quest (level " + this.m_Xml.Level + ")");
            }
            else
            {
               _loc27_.push("Quest");
            }
         }
         _loc29_ = "";
         _loc30_ = 0;
         while(_loc30_ < _loc27_.length)
         {
            if(_loc30_ != 0)
            {
               _loc29_ += ", ";
            }
            _loc29_ += _loc27_[_loc30_];
            _loc30_++;
         }
         if(_loc29_)
         {
            _loc12_.htmlText += "<i>" + _loc29_ + "</i>";
         }
         _loc31_ = new Sprite();
         _loc32_ = uint(this.m_Xml.Projectile.length());
         if(_loc32_)
         {
            _loc35_ = [30,75,105,145,305];
            _loc36_ = _loc6_ + _loc12_.textHeight;
            _loc37_ = Tooltip.AddTextField(_loc35_[0],_loc36_,_loc35_[1] - _loc35_[0],Constants.TEXT_FORMAT_TT_DESC_ATT);
            _loc38_ = Tooltip.AddTextField(_loc35_[1],_loc36_,_loc35_[2] - _loc35_[1],Constants.TEXT_FORMAT_TT_DESC_ATT);
            _loc39_ = Tooltip.AddTextField(_loc35_[2],_loc36_,_loc35_[3] - _loc35_[2],Constants.TEXT_FORMAT_TT_DESC_ATT);
            _loc40_ = Tooltip.AddTextField(_loc35_[3],_loc36_,_loc35_[4] - _loc35_[3],Constants.TEXT_FORMAT_TT_DESC_ATT);
            _loc41_ = Tooltip.AddTextField(_loc35_[4],_loc36_,_loc2_ - _loc35_[4],Constants.TEXT_FORMAT_TT_DESC_ATT);
            _loc37_.htmlText = "<b>Dmg</b>";
            _loc38_.htmlText = "<b>Spd</b>";
            _loc39_.htmlText = "<b>Rng</b>";
            _loc40_.htmlText = "<b>Effect</b>";
            _loc41_.htmlText = "<b>Other</b>";
            _loc31_.addChild(_loc37_);
            _loc31_.addChild(_loc38_);
            _loc31_.addChild(_loc39_);
            _loc31_.addChild(_loc40_);
            _loc31_.addChild(_loc41_);
            _loc42_ = 0;
            if(this.m_EV.bCalcDef)
            {
               _loc42_ = _loc20_.GetDef() * (1 + int(_loc20_.IsArmored()));
            }
            _loc30_ = 0;
            while(_loc30_ < _loc32_)
            {
               _loc43_ = XmlData.ObjectByName(this.m_Xml.Projectile[_loc30_].ObjectId);
               _loc44_ = this.m_Xml.Projectile[_loc30_].Speed / 10;
               _loc45_ = this.m_Xml.Projectile[_loc30_].LifetimeMS * this.m_Xml.Projectile[_loc30_].Speed / 10000;
               _loc46_ = new RotMGSprite(_loc43_,2);
               _loc46_.x = -_loc46_.width / 2;
               _loc46_.y = -_loc46_.height / 2;
               _loc46_.x += 18;
               _loc46_.y += _loc36_ + (_loc30_ + 1) * 18 + 9;
               _loc47_ = Constants.TEXT_FORMAT_TT_DESC_ATT.Clone();
               _loc47_.color = 16777215;
               if(DPSCalculator.TESTING)
               {
                  _loc57_ = Tooltip.AddTextField(_loc2_,_loc36_ + (_loc30_ + 1) * 18,200,_loc47_);
                  _loc57_.filters = [Constants.BLACK_OUTLINE];
                  _loc57_.htmlText = "" + this.m_Xml.Projectile[_loc30_].ObjectId;
               }
               _loc48_ = Tooltip.AddTextField(_loc35_[0],_loc36_ + (_loc30_ + 1) * 18,_loc35_[1] - _loc35_[0],Constants.TEXT_FORMAT_TT_DESC_ATT);
               _loc49_ = Tooltip.AddTextField(_loc35_[1],_loc36_ + (_loc30_ + 1) * 18,_loc35_[2] - _loc35_[1],Constants.TEXT_FORMAT_TT_DESC_ATT);
               _loc50_ = Tooltip.AddTextField(_loc35_[2],_loc36_ + (_loc30_ + 1) * 18,_loc35_[3] - _loc35_[2],Constants.TEXT_FORMAT_TT_DESC_ATT);
               _loc51_ = this.m_Xml.Projectile[_loc30_].ArmorPiercing != undefined;
               if(this.m_Xml.Projectile[_loc30_].Damage != undefined)
               {
                  _loc52_ = "" + this.CalcDamagePostDef(this.m_Xml.Projectile[_loc30_].Damage,_loc42_,_loc51_);
               }
               else
               {
                  _loc52_ = "" + this.CalcDamagePostDef(this.m_Xml.Projectile[_loc30_].MinDamage,_loc42_,_loc51_) + "-" + this.CalcDamagePostDef(this.m_Xml.Projectile[_loc30_].MaxDamage,_loc42_,_loc51_);
               }
               if(_loc51_)
               {
                  _loc48_.htmlText = "<font color=\'#540090\'>" + _loc52_ + "</font>";
               }
               else
               {
                  _loc48_.htmlText = _loc52_;
               }
               _loc49_.htmlText = "" + MathUtil.Round(_loc44_,3);
               _loc50_.htmlText = "" + MathUtil.Round(_loc45_,3);
               if(this.m_Xml.Projectile[_loc30_].ConditionEffect != undefined)
               {
                  _loc58_ = Constants.TEXT_FORMAT_TT_DESC_ATT.Clone();
                  _loc59_ = "";
                  _loc60_ = int(this.m_Xml.Projectile[_loc30_].ConditionEffect.length());
                  _loc61_ = 0;
                  while(_loc61_ < _loc60_)
                  {
                     if(_loc61_ != 0)
                     {
                        _loc59_ += ", ";
                     }
                     _loc59_ += this.m_Xml.Projectile[_loc30_].ConditionEffect[_loc61_] + " " + this.m_Xml.Projectile[_loc30_].ConditionEffect[_loc61_].@duration + "s";
                     _loc61_++;
                  }
                  _loc62_ = Tooltip.AddTextField(_loc35_[3],_loc36_ + (_loc30_ + 1) * 18,_loc35_[4] - _loc35_[3],_loc58_);
                  _loc62_.htmlText = _loc59_;
                  if(_loc62_.numLines > 1)
                  {
                     _loc58_.leading = -5;
                     _loc62_.y -= 4;
                  }
                  _loc62_.setTextFormat(_loc58_);
                  _loc31_.addChild(_loc62_);
               }
               _loc53_ = Tooltip.AddTextField(_loc35_[4],_loc36_ + (_loc30_ + 1) * 18,_loc2_ - _loc35_[4],Constants.TEXT_FORMAT_TT_DESC_ATT);
               _loc54_ = new Vector.<String>();
               if(this.m_Xml.Projectile[_loc30_].MultiHit != undefined)
               {
                  _loc54_.push("MHit");
               }
               if(this.m_Xml.Projectile[_loc30_].Boomerang != undefined)
               {
                  _loc54_.push("Boom");
               }
               if(this.m_Xml.Projectile[_loc30_].PassesCover != undefined)
               {
                  _loc54_.push("NoCov");
               }
               if(this.m_Xml.Projectile[_loc30_].Parametric != undefined)
               {
                  _loc54_.push("ParaM");
               }
               if(this.m_Xml.Projectile[_loc30_].Amplitude != undefined)
               {
                  _loc54_.push("Osc");
               }
               _loc55_ = "";
               _loc56_ = 0;
               while(_loc56_ < _loc54_.length)
               {
                  if(_loc56_ != 0)
                  {
                     _loc55_ += ", ";
                  }
                  _loc55_ += _loc54_[_loc56_];
                  _loc56_++;
               }
               if(_loc55_)
               {
                  _loc53_.htmlText = "<i>" + _loc55_ + "</i>";
                  _loc31_.addChild(_loc53_);
               }
               _loc31_.addChild(_loc46_);
               _loc31_.addChild(_loc48_);
               _loc31_.addChild(_loc49_);
               _loc31_.addChild(_loc50_);
               if(DPSCalculator.TESTING)
               {
                  _loc31_.addChild(_loc57_);
               }
               _loc30_++;
            }
         }
         _loc31_.x += 2;
         _loc31_.y += 2;
         _loc6_ += _loc12_.textHeight + _loc31_.height + 8;
         _loc5_.width = _loc2_;
         _loc5_.height = _loc6_;
         _loc3_.addChild(_loc5_);
         _loc4_.addChild(_loc31_);
         _loc4_.addChild(_loc7_);
         _loc4_.addChild(_loc8_);
         _loc4_.addChild(_loc12_);
         if(DPSCalculator.TESTING)
         {
            _loc4_.addChild(_loc34_);
         }
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(_loc11_);
         Tooltip.Show(_loc3_);
      }
      
      private function CalcDamagePostDef(param1:uint, param2:uint, param3:Boolean = false) : int
      {
         if(param3)
         {
            return param1;
         }
         var _loc4_:int = param1 - param2;
         var _loc5_:uint = param1 * 0.15;
         if(_loc5_ > _loc4_)
         {
            _loc4_ = int(_loc5_);
         }
         return _loc4_;
      }
      
      private function OnOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
   }
}


package
{
   import com.pfiffel.util.MathUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Item extends Sprite
   {
      private var m_ID:uint;
      
      private var m_Xml:XML;
      
      private var m_fWisMod:Number = 1;
      
      private var m_iWis:int = 0;
      
      public function Item(param1:XML, param2:Number = 4)
      {
         super();
         this.m_Xml = param1;
         this.m_ID = param1.@type;
         var _loc3_:RotMGSprite = new RotMGSprite(this.m_Xml,param2);
         _loc3_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_OBJECT];
         addChild(_loc3_);
         addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
      }
      
      public function SetWis(param1:uint) : void
      {
         this.m_iWis = param1;
         this.m_fWisMod = Utils.fWisMod(param1);
      }
      
      private function ApplyWis(param1:Number) : Number
      {
         return MathUtil.Floor(param1 * this.m_fWisMod,1);
      }
      
      private function TextOld(param1:String) : String
      {
         return Constants.OldColor(param1);
      }
      
      private function TextWis(param1:String) : String
      {
         return Constants.WisColor(param1);
      }
      
      private function TextBold(param1:String) : String
      {
         return "<b>" + param1 + "</b>";
      }
      
      private function GetOldActive(param1:String, param2:String = null) : XML
      {
         var _loc4_:uint = 0;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:XML = XmlData.aObjectOld[this.m_ID];
         if(_loc3_ == null)
         {
            return null;
         }
         _loc4_ = uint(_loc3_.Activate.length());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_.Activate[_loc5_];
            _loc7_ = _loc3_.Activate[_loc5_].@effect;
            _loc8_ = param1;
            if(_loc6_ == "ConditionEffectAura" && (_loc7_ == "Healing" || _loc7_ == "Damaging"))
            {
               _loc8_ = "ConditionEffectAura";
            }
            if(_loc6_ == _loc8_ && _loc7_ == param2)
            {
               return _loc3_.Activate[_loc5_];
            }
            _loc5_++;
         }
         return null;
      }
      
      private function TextPerc(param1:Number, param2:Number, param3:int = 1) : String
      {
         var _loc4_:Number = (param2 - param1) / param1 * 100 * param3;
         var _loc5_:String = "#66cc66";
         if(_loc4_ < 0)
         {
            _loc5_ = "#cc6666";
         }
         return "<font color=\'" + _loc5_ + "\'>" + "(" + MathUtil.Round(_loc4_,2) + "%)" + "</font>";
      }
      
      private function TextCompare(param1:XML, param2:XML, param3:String) : String
      {
         var _loc5_:Number = NaN;
         var _loc4_:Number = Number(param2[param3]);
         if(param2.@useWisMod != undefined && param2.@useWisMod == "true")
         {
            _loc4_ = this.ApplyWis(param2[param3]);
         }
         if(param3 == "@amount")
         {
            _loc4_ = Math.floor(_loc4_);
         }
         if(DPSCalculator.COMPARE == false)
         {
            return this.TextBold("" + _loc4_);
         }
         if(param1 == null)
         {
            return this.TextBold("" + _loc4_);
         }
         _loc5_ = Number(param1[param3]);
         if(_loc4_ == _loc5_)
         {
            return this.TextBold("" + _loc4_);
         }
         return _loc5_ + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + _loc4_) + " " + this.TextPerc(_loc5_,_loc4_);
      }
      
      private function TextCompareStat(param1:XML, param2:XML, param3:String) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc4_:Number = Number(param2[param3]);
         if(param1 == null || DPSCalculator.COMPARE == false)
         {
            return "" + _loc4_;
         }
         _loc5_ = Number(param1[param3]);
         if(_loc5_ == _loc4_)
         {
            return "" + _loc4_;
         }
         _loc6_ = 1;
         if(param3 == "MpCost" || param3 == "Cooldown")
         {
            _loc6_ = -1;
         }
         return _loc5_ + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + _loc4_) + " " + this.TextPerc(_loc5_,_loc4_,_loc6_);
      }
      
      private function TextCompareVals(param1:Number, param2:Number) : String
      {
         if(DPSCalculator.COMPARE == false || param1 == param2)
         {
            return "" + param2;
         }
         return param1 + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + param2);
      }
      
      private function GetDamage(param1:XML) : Number
      {
         var _loc2_:Number = Number(param1.Projectile.MinDamage);
         var _loc3_:Number = Number(param1.Projectile.MaxDamage);
         return (_loc2_ + _loc3_) / 2;
      }
      
      private function CompareDamage(param1:XML, param2:XML) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:Number = Number(param2.Projectile.MinDamage);
         var _loc4_:Number = Number(param2.Projectile.MaxDamage);
         if(!_loc4_)
         {
            return "";
         }
         if(param1 == null || DPSCalculator.COMPARE == false)
         {
            return "Damage: " + this.TextDamage(_loc3_,_loc4_);
         }
         _loc5_ = Number(param1.Projectile.MinDamage);
         _loc6_ = Number(param1.Projectile.MaxDamage);
         _loc7_ = (_loc5_ + _loc6_) / 2;
         _loc8_ = (_loc3_ + _loc4_) / 2;
         if(_loc5_ == _loc3_ && _loc6_ == _loc4_ && _loc7_ == _loc8_)
         {
            return "Damage: " + this.TextDamage(_loc3_,_loc4_);
         }
         return "Damage: " + this.TextDamage(_loc5_,_loc6_) + "<br/>" + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + this.TextDamage(_loc3_,_loc4_)) + " " + this.TextPerc(_loc7_,_loc8_);
      }
      
      private function TextDamage(param1:Number, param2:Number) : String
      {
         var _loc3_:Number = (param1 + param2) / 2;
         return this.TextStat(param1 + " - " + param2) + " (av.: " + this.TextStat("" + _loc3_) + ")";
      }
      
      private function CompareRange(param1:XML, param2:XML) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = param2.Projectile.Speed / 10;
         var _loc4_:Number = param2.Projectile.LifetimeMS * param2.Projectile.Speed / 10000;
         if(!_loc4_)
         {
            return "";
         }
         if(param1 == null || DPSCalculator.COMPARE == false)
         {
            return "Range: " + this.TextRange(_loc4_,_loc3_);
         }
         _loc5_ = param1.Projectile.Speed / 10;
         _loc6_ = param1.Projectile.LifetimeMS * param1.Projectile.Speed / 10000;
         if(_loc6_ == _loc4_ && _loc5_ == _loc3_)
         {
            return "Range: " + this.TextRange(_loc4_,_loc3_);
         }
         return "Range: " + this.TextRange(_loc6_,_loc5_) + "<br/>" + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + this.TextRange(_loc4_,_loc3_)) + " " + this.TextPerc(_loc6_,_loc4_);
      }
      
      private function TextRange(param1:Number, param2:Number) : String
      {
         return this.TextStat("" + MathUtil.Round(param1,2)) + " (speed: " + this.TextStat("" + MathUtil.Round(param2,2)) + " t/s)";
      }
      
      private function CompareRateOfFire(param1:XML, param2:XML) : String
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = Number(param2.RateOfFire);
         if(!_loc3_)
         {
            return "";
         }
         if(param1 == null || DPSCalculator.COMPARE == false)
         {
            if(_loc3_ == 1)
            {
               return "";
            }
            return "Rate Of Fire: " + this.TextRoF(_loc3_);
         }
         _loc4_ = Number(param1.RateOfFire);
         if(_loc4_ == _loc3_)
         {
            if(_loc3_ == 1)
            {
               return "";
            }
            return "Rate Of Fire: " + this.TextRoF(_loc3_);
         }
         return "Rate Of Fire: " + this.TextRoF(_loc4_) + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + this.TextRoF(_loc3_)) + " " + this.TextPerc(_loc4_,_loc3_);
      }
      
      private function TextRoF(param1:Number) : String
      {
         return this.TextStat(MathUtil.Round(param1 * 100,2) + "%");
      }
      
      private function TextCompareEqStat(param1:int, param2:int, param3:uint) : String
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(param2 == 0 && param1 == param2 || param2 == 0 && DPSCalculator.COMPARE == false)
         {
            return "";
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param3 == 20 || param3 == 28)
         {
            _loc4_ = true;
         }
         if(param3 == 27)
         {
            _loc5_ = true;
         }
         _loc6_ = Constants.COLOR_STAT;
         if(_loc4_)
         {
            _loc6_ = "#ff7f44";
         }
         else if(_loc5_)
         {
            _loc6_ = "#7f7fc4";
         }
         _loc7_ = StringUtil.AddPrefix(param1) + this.TextBold(this.TextWis(" -> ")) + this.TextBold(StringUtil.AddPrefix(param2));
         if(param1 == param2 || DPSCalculator.COMPARE == false)
         {
            _loc7_ = StringUtil.AddPrefix(param2);
         }
         return "<font color=\'" + _loc6_ + "\'>" + _loc7_ + " " + Stat.sNameFrId(param3) + "</font>";
      }
      
      private function TextStat(param1:String) : String
      {
         return "<font color=\'" + Constants.COLOR_STAT + "\'>" + param1 + "</font>";
      }
      
      private function tierColor(param1:String) : String
      {
         if(this.m_Xml.@setType != undefined)
         {
            return "<font color=\'#ff9900\'>" + param1 + "</font>";
         }
         if(this.m_Xml.Tier == undefined)
         {
            return "<font color=\'#8a2be2\'>" + param1 + "</font>";
         }
         return param1;
      }
      
      private function getAttrInt(param1:XML, param2:String, param3:int = 0) : int
      {
         return !!param1.hasOwnProperty("@" + param2) ? int(param1[param2]) : param3;
      }
      
      private function getAttrFloat(param1:XML, param2:String, param3:Number = 0) : Number
      {
         return !!param1.hasOwnProperty("@" + param2) ? Number(param1[param2]) : param3;
      }
      
      private function getAttrString(param1:XML, param2:String, param3:String = "") : String
      {
         return !!param1.hasOwnProperty("@" + param2) ? String(param1[param2]) : param3;
      }
      
      private function getPlural(param1:Number, param2:String) : String
      {
         var _loc3_:String = param1 + " " + param2;
         if(param1 != 1)
         {
            return this.hl(_loc3_ + "s");
         }
         return this.hl(_loc3_);
      }
      
      private function condEffectAndDuration(param1:XML, param2:String = "Nothing", param3:Number = 5) : String
      {
         var _loc5_:Number = NaN;
         var _loc4_:String = !!param1.hasOwnProperty("@condEffect") ? param1.@condEffect : param2;
         if(_loc4_ != "Nothing")
         {
            _loc5_ = this.getAttrFloat(param1,"condDuration",param3);
            return "Inflicts " + this.hl("" + _loc4_) + " for " + this.getPlural(_loc5_,"second") + "<br/>";
         }
         return "";
      }
      
      private function hl(param1:String) : String
      {
         return "<font color=\'" + Constants.COLOR_STAT + "\'>" + param1 + "</font>";
      }
      
      private function getWisBonus(param1:Number) : String
      {
         return !!param1 ? "<font color=\'" + Constants.COLOR_WIS + "\'>" + " (+" + param1 + ")" + "</font>" : "";
      }
      
      private function OnOver(param1:MouseEvent) : void
      {
         var _loc9_:TextField = null;
         var _loc10_:RotMGSprite = null;
         var _loc11_:TextField = null;
         var _loc12_:Sprite = null;
         var _loc13_:TextField = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = false;
         var _loc24_:* = false;
         var _loc25_:* = false;
         var _loc26_:int = 0;
         var _loc27_:Number = NaN;
         var _loc28_:int = 0;
         var _loc29_:uint = 0;
         var _loc30_:* = undefined;
         var _loc31_:uint = 0;
         var _loc32_:Array = null;
         var _loc33_:Array = null;
         var _loc34_:Vector.<uint> = null;
         var _loc35_:uint = 0;
         var _loc36_:uint = 0;
         var _loc37_:* = undefined;
         var _loc38_:Sprite = null;
         var _loc39_:TextField = null;
         var _loc40_:RotMGSprite = null;
         var _loc41_:* = undefined;
         var _loc42_:Number = NaN;
         var _loc43_:uint = 0;
         var _loc44_:* = null;
         var _loc45_:String = null;
         var _loc46_:String = null;
         var _loc47_:Number = NaN;
         var _loc48_:String = null;
         var _loc49_:XML = null;
         var _loc50_:String = null;
         var _loc51_:String = null;
         var _loc52_:int = 0;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:String = null;
         var _loc58_:* = null;
         var _loc59_:String = null;
         var _loc60_:int = 0;
         var _loc61_:Number = NaN;
         var _loc62_:Number = NaN;
         var _loc63_:Number = NaN;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:* = null;
         var _loc67_:int = 0;
         var _loc68_:int = 0;
         var _loc69_:int = 0;
         var _loc70_:int = 0;
         var _loc71_:int = 0;
         var _loc72_:int = 0;
         var _loc73_:int = 0;
         var _loc74_:int = 0;
         var _loc75_:int = 0;
         var _loc76_:int = 0;
         var _loc77_:int = 0;
         var _loc78_:Boolean = false;
         var _loc79_:String = null;
         var _loc80_:String = null;
         var _loc81_:int = 0;
         var _loc82_:Number = NaN;
         var _loc83_:Number = NaN;
         var _loc84_:Number = NaN;
         var _loc85_:int = 0;
         var _loc86_:int = 0;
         var _loc87_:Number = NaN;
         var _loc88_:Number = NaN;
         var _loc89_:Number = NaN;
         var _loc90_:Number = NaN;
         var _loc91_:int = 0;
         var _loc92_:String = null;
         var _loc93_:XML = null;
         var _loc94_:XMLList = null;
         var _loc95_:uint = 0;
         var _loc96_:* = undefined;
         var _loc97_:uint = 0;
         var _loc98_:Boolean = false;
         var _loc99_:int = 0;
         var _loc100_:uint = 0;
         var _loc101_:Sprite = null;
         var _loc102_:TextField = null;
         var _loc103_:uint = 0;
         var _loc104_:XML = null;
         var _loc105_:uint = 0;
         var _loc106_:uint = 0;
         var _loc107_:uint = 0;
         var _loc108_:* = undefined;
         var _loc109_:uint = 0;
         var _loc110_:* = undefined;
         var _loc111_:* = undefined;
         var _loc112_:RotMGSprite = null;
         var _loc113_:* = undefined;
         var _loc114_:* = undefined;
         var _loc115_:XML = null;
         var _loc116_:RotMGSprite = null;
         var _loc117_:XML = null;
         var _loc118_:RotMGSprite = null;
         var _loc119_:String = null;
         var _loc120_:XML = null;
         var _loc121_:RotMGSprite = null;
         var _loc122_:TextField = null;
         var _loc2_:Number = 246;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Sprite = new Sprite();
         _loc4_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         var _loc5_:Sprite = new BackgroundTooltip();
         _loc5_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc3_.addChild(_loc5_);
         var _loc6_:uint = 3;
         var _loc7_:RotMGSprite = new RotMGSprite(this.m_Xml,3);
         _loc7_.x = _loc7_.y = 16;
         _loc7_.filters = [Constants.BLACK_OUTLINE];
         var _loc8_:TextField = Tooltip.AddTextField(50,_loc6_,150,Constants.TEXT_FORMAT_TT_HEADER);
         _loc8_.text = String(this.m_Xml.DisplayId != undefined && this.m_Xml.DisplayId != "" ? this.m_Xml.DisplayId : String(this.m_Xml.@id));
         _loc9_ = Tooltip.AddTextField(205,_loc6_,40,Constants.TEXT_FORMAT_TT_HEADER_TIER);
         _loc10_ = new RotMGSprite(this.BagByType(this.m_Xml.BagType),2);
         _loc10_.x = 205 + 1;
         _loc10_.y = _loc6_ + 22;
         _loc10_.filters = [Constants.BLACK_OUTLINE];
         if(this.m_Xml.@setType != undefined)
         {
            _loc9_.htmlText = "<b>" + this.tierColor("ST") + "</b>";
         }
         else if(this.m_Xml.Tier != undefined)
         {
            _loc9_.htmlText = "<b>" + this.tierColor("T" + this.m_Xml.Tier) + "</b>";
         }
         else
         {
            _loc9_.htmlText = "<b>" + this.tierColor("UT") + "</b>";
         }
         _loc6_ += 45;
         _loc11_ = Tooltip.AddTextField(10,_loc6_,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         _loc11_.htmlText = Language.getString(this.m_Xml.Description).replace(/\\n/g,"<br/>");
         _loc6_ += _loc11_.textHeight + 8;
         _loc12_ = new Divider();
         _loc12_.x = 10;
         _loc12_.y = _loc6_;
         _loc6_ += _loc12_.height + 4;
         if(this.m_Xml.Projectile != undefined)
         {
            _loc40_ = new RotMGSprite(XmlData.ObjectByName(this.m_Xml.Projectile.ObjectId),3);
            _loc40_.y = _loc6_;
            _loc40_.x = 180 + 24;
            _loc40_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
            _loc3_.addChild(_loc40_);
         }
         _loc13_ = Tooltip.AddTextField(10,_loc6_,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         _loc13_.htmlText = "";
         _loc14_ = Number(this.m_Xml.NumProjectiles);
         _loc15_ = this.m_Xml.Projectile.Speed / 10;
         _loc16_ = this.m_Xml.Projectile.LifetimeMS * this.m_Xml.Projectile.Speed / 10000;
         _loc17_ = 10;
         if(this.m_Xml.ArcGap != undefined)
         {
            _loc17_ = Number(this.m_Xml.ArcGap);
         }
         if(Boolean(_loc17_) && _loc14_ > 1)
         {
            _loc41_ = (_loc14_ - 1) * _loc17_;
            if(_loc41_ < 180)
            {
               _loc42_ = 0.5 / Math.cos(MathUtil.fDegToRad * (90 - _loc41_ / 2));
               _loc18_ = Math.sqrt(_loc42_ * _loc42_ - 0.5 * 0.5);
            }
         }
         _loc19_ = Number(this.m_Xml.Projectile.MinDamage);
         _loc20_ = Number(this.m_Xml.Projectile.MaxDamage);
         _loc21_ = (_loc19_ + _loc20_) / 2;
         _loc22_ = Number(this.m_Xml.RateOfFire);
         _loc23_ = this.m_Xml.Projectile.MultiHit != undefined;
         _loc24_ = this.m_Xml.Projectile.PassesCover != undefined;
         _loc25_ = this.m_Xml.Projectile.ArmorPiercing != undefined;
         if(this.m_Xml.MultiPhase != undefined)
         {
            _loc26_ = int(this.m_Xml.MpEndCost);
         }
         else
         {
            _loc26_ = int(this.m_Xml.MpCost);
         }
         _loc27_ = Number(this.m_Xml.FameBonus);
         _loc28_ = int(this.m_Xml.Cooldown);
         if(this.m_Xml.ExtraTooltipData != undefined)
         {
            _loc43_ = uint(this.m_Xml.ExtraTooltipData.EffectInfo.length());
            _loc30_ = 0;
            while(_loc30_ < _loc43_)
            {
               _loc44_ = Language.getString(this.m_Xml.ExtraTooltipData.EffectInfo[_loc30_].@name);
               if(_loc44_ != "")
               {
                  _loc44_ += ": ";
               }
               _loc45_ = Language.getString(this.m_Xml.ExtraTooltipData.EffectInfo[_loc30_].@description);
               _loc13_.htmlText += "\n" + _loc44_ + this.hl(_loc45_);
               _loc30_++;
            }
         }
         if(_loc28_)
         {
            _loc13_.htmlText += "\nCooldown: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + this.TextCompareStat(XmlData.aObjectOld[this.m_ID],this.m_Xml,"Cooldown") + " seconds" + "</font>";
         }
         if(_loc14_)
         {
            _loc13_.htmlText += "\nShots: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + _loc14_ + "</font>";
         }
         _loc13_.htmlText += this.CompareDamage(XmlData.aObjectOld[this.m_ID],this.m_Xml);
         _loc13_.htmlText += this.CompareRateOfFire(XmlData.aObjectOld[this.m_ID],this.m_Xml);
         _loc13_.htmlText += this.CompareRange(XmlData.aObjectOld[this.m_ID],this.m_Xml);
         if(Boolean(_loc18_) && _loc18_ < _loc16_)
         {
            _loc13_.htmlText += "\n" + "True Range: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + MathUtil.Round(_loc18_,2) + "</font>";
         }
         if(_loc23_)
         {
            _loc13_.htmlText += "\n<font color=\'" + Constants.COLOR_STAT + "\'>" + "Shots hit multiple targets" + "</font>";
         }
         if(_loc24_)
         {
            _loc13_.htmlText += "\n<font color=\'" + Constants.COLOR_STAT + "\'>" + "Shots pass through obstacles" + "</font>";
         }
         if(_loc25_)
         {
            _loc13_.htmlText += "\n<font color=\'" + Constants.COLOR_STAT + "\'>" + "Ignores defense of target" + "</font>";
         }
         _loc29_ = uint(this.m_Xml.ConditionEffect.length());
         if(_loc29_)
         {
            _loc13_.htmlText += "\nShot Effect:";
         }
         _loc30_ = 0;
         while(_loc30_ < _loc29_)
         {
            _loc46_ = this.m_Xml.ConditionEffect[_loc30_];
            _loc47_ = Number(this.m_Xml.ConditionEffect[_loc30_].@duration);
            _loc48_ = Constants.COLOR_STAT;
            if(_loc46_ == "Armor Broken")
            {
               _loc48_ = "#8a2be2";
            }
            _loc13_.htmlText += "\n" + "<font color=\'" + _loc48_ + "\'>" + _loc46_ + " for " + _loc47_ + " seconds" + "</font>";
            _loc30_++;
         }
         _loc31_ = uint(this.m_Xml.Activate.length());
         _loc30_ = 0;
         while(_loc30_ < _loc31_)
         {
            _loc49_ = this.m_Xml.Activate[_loc30_];
            if(_loc49_.@checkExistingEffect == undefined)
            {
               if(_loc49_ != "Shoot")
               {
                  if(this.m_Xml.Activate[_loc30_] != "BulletNova")
                  {
                     _loc50_ = _loc49_;
                     _loc52_ = int(_loc49_.@totalDamage);
                     _loc53_ = Number(_loc49_.@duration);
                     _loc54_ = Number(_loc49_.@condDuration);
                     _loc55_ = Number(_loc49_.@range);
                     _loc56_ = Number(_loc49_.@radius);
                     _loc57_ = _loc49_.@effect;
                     if(_loc50_ == "ConditionEffectAura")
                     {
                        _loc58_ = "W";
                        _loc51_ = "Party Effect: ";
                     }
                     else if(_loc50_ == "ConditionEffectSelf")
                     {
                        _loc51_ = "Effect on self: ";
                     }
                     else if(_loc50_ == "HealNova")
                     {
                        _loc51_ = "Party Heal: ";
                        _loc58_ = "" + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@amount") + " HP w";
                     }
                     if(_loc50_ == "StatBoostAura")
                     {
                        _loc13_.htmlText += "\nParty Effect: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + "Within " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@range") + " sqrs increase " + Stat.sNameFrId(_loc49_.@stat) + " by " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@amount") + " for " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@duration") + " seconds</font>";
                     }
                     else if(_loc50_ == "Trap")
                     {
                        _loc60_ = this.getAttrInt(_loc49_,"totalDamage");
                        _loc61_ = this.getAttrFloat(_loc49_,"radius");
                        _loc62_ = this.getAttrFloat(_loc49_,"duration",20);
                        _loc63_ = this.getAttrFloat(_loc49_,"throwTime",1);
                        _loc64_ = this.getAttrFloat(_loc49_,"sensitivity",0.5);
                        _loc65_ = MathUtil.Round(_loc61_ * _loc64_,2);
                        _loc66_ = this.tierColor("Trap: ");
                        _loc66_ = _loc66_ + (this.hl("" + _loc60_) + " damage within " + this.getPlural(_loc61_,"square") + "<br/>");
                        _loc66_ = _loc66_ + this.condEffectAndDuration(_loc49_,"Slowed",5);
                        _loc66_ = _loc66_ + (this.getPlural(_loc63_,"second") + " to arm for " + this.getPlural(_loc62_,"second") + "<br/>");
                        _loc66_ = _loc66_ + ("Triggers within " + this.getPlural(_loc65_,"square"));
                        _loc13_.htmlText += _loc66_;
                     }
                     else if(_loc50_ == "PoisonGrenade")
                     {
                        _loc67_ = this.getAttrInt(_loc49_,"totalDamage");
                        _loc61_ = this.getAttrFloat(_loc49_,"radius");
                        _loc62_ = this.getAttrFloat(_loc49_,"duration");
                        _loc63_ = this.getAttrFloat(_loc49_,"throwTime",1);
                        _loc68_ = this.getAttrInt(_loc49_,"impactDamage",0);
                        _loc66_ = this.tierColor("Poison: ");
                        _loc66_ = _loc66_ + (this.hl("" + _loc67_) + " damage");
                        if(_loc68_)
                        {
                           _loc66_ += " (" + this.hl("" + _loc68_) + " on impact)";
                        }
                        _loc66_ += " within " + this.getPlural(_loc61_,"square");
                        _loc66_ = _loc66_ + (" over " + this.getPlural(_loc62_,"second"));
                        _loc66_ = _loc66_ + this.condEffectAndDuration(_loc49_,"Nothing",5);
                        _loc13_.htmlText += _loc66_;
                     }
                     else if(_loc50_ == "Lightning")
                     {
                        _loc69_ = this.m_iWis;
                        _loc70_ = this.getAttrInt(_loc49_,"decrDamage",0);
                        _loc71_ = this.getAttrInt(_loc49_,"wisPerTarget",10);
                        _loc72_ = this.getAttrInt(_loc49_,"wisDamageBase",_loc70_);
                        _loc73_ = this.getAttrInt(_loc49_,"wisMin",50);
                        _loc74_ = Math.max(0,_loc69_ - _loc73_);
                        _loc75_ = _loc74_ / _loc71_;
                        _loc76_ = _loc72_ / 10 * _loc74_;
                        _loc77_ = this.getAttrInt(_loc49_,"maxTargets") + _loc75_;
                        _loc60_ = this.getAttrInt(_loc49_,"totalDamage") + _loc76_;
                        _loc66_ = this.tierColor("Lightning: ");
                        _loc66_ = _loc66_ + (this.hl("" + _loc77_) + this.getWisBonus(_loc75_) + " targets<br/>");
                        _loc66_ = _loc66_ + (this.hl("" + _loc60_) + this.getWisBonus(_loc76_) + " damage");
                        _loc78_ = false;
                        if(_loc70_)
                        {
                           if(_loc70_ < 0)
                           {
                              _loc78_ = true;
                           }
                           _loc79_ = "reduced";
                           if(_loc78_)
                           {
                              _loc79_ = this.hl("increased");
                           }
                           _loc66_ += ", " + _loc79_ + " by <br/>" + this.hl("" + _loc70_) + " for each subsequent target<br/>";
                        }
                        _loc66_ += this.condEffectAndDuration(_loc49_,"Nothing",5);
                        _loc13_.htmlText += _loc66_;
                     }
                     else if(_loc50_ == "StasisBlast")
                     {
                        _loc13_.htmlText += "\nStasis on group: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@duration") + " seconds" + "</font>";
                     }
                     else if(_loc50_ == "GenericActivate")
                     {
                        _loc80_ = "Party Effect:";
                        if(_loc49_.@target == "enemy")
                        {
                           _loc80_ = "AoE Effect:";
                        }
                        _loc13_.htmlText += "\n" + _loc80_ + " " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + "Within " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@range") + " sqrs " + _loc57_ + " for " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@duration") + " seconds</font>";
                     }
                     else if(_loc50_ == "VampireBlast")
                     {
                        _loc69_ = this.m_iWis;
                        _loc81_ = this.getAttrInt(_loc49_,"wisPerRad",10);
                        _loc82_ = this.getAttrFloat(_loc49_,"incrRad",0.5);
                        _loc72_ = this.getAttrInt(_loc49_,"wisDamageBase",0);
                        _loc73_ = this.getAttrInt(_loc49_,"wisMin",50);
                        _loc74_ = Math.max(0,_loc69_ - _loc73_);
                        _loc76_ = _loc72_ / 10 * _loc74_;
                        _loc83_ = MathUtil.Round(int(_loc74_ / _loc81_) * _loc82_,2);
                        _loc60_ = this.getAttrInt(_loc49_,"totalDamage") + _loc76_;
                        _loc61_ = this.getAttrFloat(_loc49_,"radius");
                        _loc84_ = MathUtil.Round(this.getAttrFloat(_loc49_,"healRange",5) + _loc83_,2);
                        _loc85_ = this.getAttrInt(_loc49_,"heal");
                        _loc86_ = this.getAttrInt(_loc49_,"ignoreDef",0);
                        _loc66_ = this.tierColor("Skull: ");
                        _loc66_ = _loc66_ + (this.hl("" + _loc60_) + this.getWisBonus(_loc76_) + " damage<br/>");
                        _loc66_ = _loc66_ + ("within " + this.getPlural(_loc61_,"square") + "<br/>");
                        if(_loc85_)
                        {
                           _loc66_ += "Steals " + this.hl("" + _loc85_) + " HP";
                        }
                        if(Boolean(_loc85_) && Boolean(_loc86_))
                        {
                           _loc66_ += " and ignores " + this.hl("" + _loc86_) + " defense";
                        }
                        else if(_loc86_)
                        {
                           _loc66_ += "Ignores " + this.hl("" + _loc86_) + " defense";
                        }
                        if(_loc85_)
                        {
                           _loc66_ += "<br/>Heals allies within " + this.hl("" + _loc84_) + this.getWisBonus(_loc83_) + " squares" + "<br/>";
                        }
                        _loc66_ += this.condEffectAndDuration(_loc49_,"Nothing",2.5);
                        _loc13_.htmlText += _loc66_;
                     }
                     else if(_loc50_ == "RemoveNegativeConditions")
                     {
                        _loc13_.htmlText += "\n" + "<font color=\'" + "#8a2be2" + "\'>" + "Removes negative status effects" + "</font>";
                     }
                     else if(_loc50_ == "Decoy")
                     {
                        _loc62_ = this.getAttrFloat(_loc49_,"duration");
                        _loc87_ = this.getAttrFloat(_loc49_,"angleOffset",0);
                        _loc88_ = this.getAttrFloat(_loc49_,"speed",1);
                        _loc89_ = this.getAttrFloat(_loc49_,"distance",8);
                        _loc90_ = MathUtil.Round(_loc89_ / (_loc88_ * 5),2);
                        _loc91_ = this.getAttrInt(_loc49_,"numShots",0);
                        _loc66_ = this.tierColor("Decoy: ");
                        _loc66_ = _loc66_ + this.getPlural(_loc62_,"second");
                        if(_loc87_)
                        {
                           _loc66_ += " at " + this.getPlural(_loc87_,"degree");
                        }
                        _loc66_ += "<br/>";
                        if(_loc88_ == 0)
                        {
                           _loc66_ += "Decoy does not move";
                        }
                        else
                        {
                           _loc66_ += this.getPlural(_loc89_,"square") + " in " + this.getPlural(_loc90_,"second");
                        }
                        if(_loc91_)
                        {
                           _loc66_ += "<br/>Shots: " + this.hl("" + _loc91_);
                        }
                        _loc13_.htmlText += _loc66_;
                     }
                     else if(_loc50_ == "Pet")
                     {
                        _loc13_.htmlText += "\n" + "<font color=\'" + "#8a2be2" + "\'>" + "Releases " + _loc49_.@objectId + "</font>";
                     }
                     else if(_loc50_ == "Teleport")
                     {
                        _loc13_.htmlText += "\n" + "<font color=\'" + Constants.COLOR_STAT + "\'>" + "Teleport to target" + "</font>";
                     }
                     else if(_loc50_ != "ShurikenAbility")
                     {
                        if(_loc50_ == "DazeBlast")
                        {
                           _loc13_.htmlText += "\nDaze Blast: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + _loc52_ + " damage within " + _loc56_ + " sqrs" + "</font>";
                        }
                        else
                        {
                           _loc59_ = "\n" + _loc51_;
                           if(_loc55_)
                           {
                              _loc59_ += "<font color=\'" + Constants.COLOR_STAT + "\'>" + _loc58_ + "ithin " + this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@range") + " sqrs " + "</font>";
                           }
                           _loc48_ = Constants.COLOR_STAT;
                           if(_loc53_)
                           {
                              _loc92_ = this.TextCompare(this.GetOldActive(_loc50_,_loc57_),_loc49_,"@duration");
                              if(_loc57_ == "Invulnerable" || _loc57_ == "Armored" || int(this.m_Xml.SlotType) == 21)
                              {
                                 _loc48_ = "#8a2be2";
                                 _loc59_ += "<br/>" + "<font color=\'" + _loc48_ + "\'>" + _loc57_ + " for " + _loc92_ + " seconds" + "</font>";
                              }
                              else
                              {
                                 _loc59_ += "<br/>" + "<font color=\'" + _loc48_ + "\'>" + _loc57_ + "</font> for <font color=\'" + _loc48_ + "\'>" + _loc92_ + "</font> seconds" + "</font>";
                              }
                           }
                           _loc13_.htmlText += "\n" + _loc59_;
                        }
                     }
                  }
               }
            }
            _loc30_++;
         }
         _loc32_ = new Array();
         _loc33_ = new Array();
         _loc34_ = new Vector.<uint>();
         _loc35_ = uint(this.m_Xml.ActivateOnEquip.length());
         _loc30_ = 0;
         while(_loc30_ < _loc35_)
         {
            _loc93_ = this.m_Xml.ActivateOnEquip[_loc30_];
            _loc34_.push(uint(_loc93_.@stat));
            _loc33_[uint(_loc93_.@stat)] = uint(_loc93_.@amount);
            _loc30_++;
         }
         if(XmlData.aObjectOld[this.m_ID])
         {
            _loc94_ = XmlData.aObjectOld[this.m_ID].ActivateOnEquip;
            _loc95_ = uint(_loc94_.length());
            _loc96_ = 0;
            while(_loc96_ < _loc95_)
            {
               _loc97_ = uint(_loc94_[_loc96_].@stat);
               _loc98_ = true;
               _loc99_ = 0;
               while(_loc99_ < _loc34_.length)
               {
                  if(_loc34_[_loc99_] == _loc97_)
                  {
                     _loc98_ = false;
                  }
                  _loc99_++;
               }
               if(_loc98_)
               {
                  _loc34_.push(_loc97_);
               }
               _loc32_[_loc97_] = uint(_loc94_[_loc96_].@amount);
               _loc96_++;
            }
         }
         if(_loc35_)
         {
            _loc13_.htmlText += "\nOn Equip:";
         }
         _loc36_ = _loc34_.length;
         _loc37_ = 0;
         while(_loc37_ < _loc36_)
         {
            _loc100_ = _loc34_[_loc37_];
            if(XmlData.aObjectOld[this.m_ID] == null)
            {
               _loc32_[_loc100_] = _loc33_[_loc100_];
            }
            _loc13_.htmlText += this.TextCompareEqStat(_loc32_[_loc100_],_loc33_[_loc100_],_loc100_);
            _loc37_++;
         }
         if(_loc26_)
         {
            _loc13_.htmlText += "\nMP Cost: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + this.TextCompareStat(XmlData.aObjectOld[this.m_ID],this.m_Xml,"MpCost") + "</font>";
         }
         if(_loc27_)
         {
            _loc13_.htmlText += "\nFame Bonus: " + "<font color=\'" + Constants.COLOR_STAT + "\'>" + _loc27_ + "%" + "</font>";
         }
         _loc6_ += _loc13_.textHeight + 8;
         if(this.m_Xml.@setType != undefined)
         {
            _loc101_ = new Divider();
            _loc101_.x = 10;
            _loc101_.y = _loc6_;
            _loc6_ += _loc101_.height + 4;
            _loc102_ = Tooltip.AddTextField(10,_loc6_,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
            _loc102_.htmlText = "<b>Set</b>";
            _loc103_ = uint(this.m_Xml.@setType);
            _loc104_ = XmlData.aEqSets[_loc103_];
            _loc105_ = 0;
            _loc106_ = uint(_loc104_.Setpiece.length());
            _loc108_ = 0;
            while(_loc108_ < _loc106_)
            {
               _loc93_ = _loc104_.Setpiece[_loc108_];
               _loc110_ = uint(_loc93_.@slot);
               _loc111_ = uint(_loc93_.@itemtype);
               if(_loc110_ == 0)
               {
                  _loc107_ = _loc111_;
               }
               if(CharCompCom.Current.iItemID_Slot(_loc110_) == _loc111_)
               {
                  _loc105_++;
               }
               else
               {
                  _loc112_ = new RotMGSprite(XmlData.aObject[_loc111_],2);
                  _loc112_.y = _loc6_ + 3;
                  _loc112_.x = 95 + _loc110_ * 20;
                  _loc112_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
                  _loc3_.addChild(_loc112_);
               }
               _loc108_++;
            }
            if(_loc105_ == 4)
            {
               _loc102_.htmlText = "<font color=\'#66cc66\'><b>Set</b></font>";
               _loc102_.alpha = 1;
            }
            else
            {
               _loc102_.htmlText = "<font color=\'#FF3333\'><b>Set</b> - Missing:</font>";
               _loc102_.alpha = 0.4;
            }
            _loc109_ = uint(_loc104_.ActivateOnEquipAll.length());
            _loc30_ = 0;
            while(_loc30_ < _loc109_)
            {
               _loc93_ = _loc104_.ActivateOnEquipAll[_loc30_];
               if(_loc93_ == "IncrementStat")
               {
                  _loc113_ = uint(_loc93_.@stat);
                  _loc114_ = uint(_loc93_.@amount);
                  _loc102_.htmlText += this.TextCompareEqStat(_loc114_,_loc114_,_loc113_);
               }
               else if(_loc93_ == "ChangeSkin")
               {
                  _loc115_ = XmlData.aObject[uint(_loc93_.@skinType)];
                  _loc102_.htmlText += "Skin Change:<br/>" + _loc115_.@id;
                  _loc116_ = new RotMGSprite(_loc115_,6);
                  _loc116_.y = _loc6_ + 3;
                  _loc116_.x = 180;
                  _loc116_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_OBJECT];
                  _loc3_.addChild(_loc116_);
                  if(_loc93_.@bulletType != undefined)
                  {
                     _loc117_ = XmlData.ObjectByName(_loc93_.@bulletType);
                     _loc102_.htmlText += "Bullet Change:<br/>" + _loc93_.@bulletType;
                     _loc118_ = new RotMGSprite(_loc117_,3);
                     _loc118_.y = _loc6_ + 3 + 48 + 4 + 4 - 1;
                     _loc118_.x = 180 + 24;
                     _loc118_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
                     _loc3_.addChild(_loc118_);
                     _loc119_ = XmlData.aObject[_loc107_].Projectile.ObjectId;
                     _loc120_ = XmlData.ObjectByName(_loc119_);
                     _loc121_ = new RotMGSprite(_loc120_,3);
                     _loc121_.y = _loc6_ + 3 + 48 + 4 + 4 - 1;
                     _loc121_.x = 180 - 24;
                     _loc121_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
                     _loc3_.addChild(_loc121_);
                     _loc122_ = Tooltip.AddTextField(180 + 4,_loc6_ + 3 + 48 + 4 + 4 - 2,40,Constants.TEXT_FORMAT_TT_DESC);
                     _loc122_.htmlText = "<b>-&#62;</b>";
                     _loc4_.addChild(_loc122_);
                     _loc122_.alpha = 0.3;
                  }
               }
               _loc30_++;
            }
            _loc6_ += _loc102_.textHeight + 8;
            _loc4_.addChild(_loc102_);
            _loc3_.addChild(_loc101_);
         }
         _loc38_ = new Divider();
         _loc38_.x = 10;
         _loc38_.y = _loc6_;
         _loc6_ += _loc38_.height + 4;
         _loc39_ = Tooltip.AddTextField(10,_loc6_,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         if(this.m_Xml.Soulbound != undefined)
         {
            _loc39_.htmlText += "Soulbound";
         }
         _loc39_.htmlText += "\n<font color=\'#F2F2F2\'>" + "Feed Power: " + this.m_Xml.feedPower + "</font>";
         _loc6_ += _loc39_.textHeight + 14;
         _loc5_.width = _loc2_;
         _loc5_.height = _loc6_;
         _loc4_.addChild(_loc7_);
         _loc4_.addChild(_loc10_);
         _loc4_.addChild(_loc8_);
         _loc4_.addChild(_loc9_);
         _loc4_.addChild(_loc11_);
         _loc4_.addChild(_loc13_);
         _loc4_.addChild(_loc39_);
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(_loc12_);
         _loc3_.addChild(_loc38_);
         Tooltip.Show(_loc3_);
      }
      
      private function BagByType(param1:uint) : XML
      {
         var _loc2_:String = "Loot Bag " + param1;
         return XmlData.ObjectByName(_loc2_);
      }
      
      private function BagType(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 1280;
               break;
            case 1:
               _loc2_ = 1286;
               break;
            case 2:
               _loc2_ = 1287;
               break;
            case 3:
               _loc2_ = 1288;
               break;
            case 4:
               _loc2_ = 1289;
               break;
            case 5:
               _loc2_ = 1291;
               break;
            case 6:
               _loc2_ = 1292;
         }
         return _loc2_;
      }
      
      private function OnOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
   }
}


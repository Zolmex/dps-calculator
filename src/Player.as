package
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Player extends Sprite
   {
      private var m_ID:uint;
      
      private var m_Xml:XML;
      
      private var m_bCurrent:Boolean;
      
      public function Player(param1:XML, param2:Number = 4, param3:Boolean = false)
      {
         super();
         this.m_Xml = param1;
         this.m_ID = param1.@type;
         this.m_bCurrent = param3;
         var _loc4_:Sprite = this.getTexSprite(param2);
         _loc4_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_OBJECT];
         addChild(_loc4_);
         addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
      }
      
      private function getTexSprite(param1:Number) : Sprite
      {
         var _loc2_:XMLList = this.m_Xml.AnimatedTexture;
         var _loc3_:* = SpriteParser.GetSprite(_loc2_.File,_loc2_.Index);
         var _loc4_:Sprite = new Sprite();
         _loc4_.addChild(_loc3_);
         _loc4_.scaleX = _loc4_.scaleY = param1;
         return _loc4_;
      }
      
      private function DrawToolTip() : void
      {
         var _loc8_:Sprite = null;
         var _loc9_:int = 0;
         var _loc10_:TextField = null;
         var _loc11_:TextField = null;
         var _loc12_:TextField = null;
         var _loc13_:TextField = null;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:TextField = null;
         var _loc17_:Number = NaN;
         var _loc18_:* = undefined;
         var _loc19_:TextField = null;
         var _loc20_:TextField = null;
         var _loc21_:TextField = null;
         var _loc22_:String = null;
         var _loc23_:TextField = null;
         var _loc24_:TextField = null;
         var _loc25_:TextField = null;
         var _loc26_:TextField = null;
         var _loc27_:TextField = null;
         var _loc28_:TextField = null;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc1_:Number = 246 + 104;
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Sprite = new Sprite();
         _loc3_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         var _loc4_:Sprite = new BackgroundTooltip();
         _loc4_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc2_.addChild(_loc4_);
         var _loc5_:uint = 3;
         var _loc6_:Sprite = this.getTexSprite(3);
         _loc6_.x = _loc6_.y = 16;
         _loc6_.filters = [Constants.BLACK_OUTLINE];
         addChild(_loc6_);
         var _loc7_:TextField = Tooltip.AddTextField(50,_loc5_,150,Constants.TEXT_FORMAT_TT_HEADER);
         if(this.m_Xml.DisplayId != undefined)
         {
            _loc7_.text = Language.getString(this.m_Xml.DisplayId);
         }
         else
         {
            _loc7_.text = this.m_Xml.@id;
         }
         _loc5_ += 45;
         _loc8_ = new Divider();
         _loc8_.width += 104;
         _loc8_.x = 10;
         _loc8_.y = _loc5_;
         _loc5_ += _loc8_.height + 4;
         _loc9_ = int(Stat.TYPES.length);
         if(this.m_bCurrent)
         {
            _loc20_ = Tooltip.AddTextField(10,_loc5_,_loc1_ - 20,Constants.TEXT_FORMAT_TT_DESC_HEADER);
            _loc20_.htmlText = "Current Stats:";
            _loc3_.addChild(_loc20_);
            _loc5_ += _loc20_.textHeight + 2;
            _loc18_ = 0;
            while(_loc18_ < _loc9_)
            {
               _loc21_ = UtilUI.CreateTextField(10 + _loc18_ % 2 * 97,_loc5_ + int(_loc18_ / 2) * 16,100,Constants.TEXT_FORMAT_TT_DESC);
               _loc21_.htmlText = this.sCurrentStat(this.GetMax(this.m_Xml,Stat.TYPES[_loc18_]),_loc18_);
               _loc3_.addChild(_loc21_);
               _loc18_++;
            }
            _loc5_ += 8 / 2 * 16;
            _loc5_ = uint(_loc5_ + 4);
         }
         _loc10_ = Tooltip.AddTextField(10,_loc5_,_loc1_ - 20,Constants.TEXT_FORMAT_TT_DESC_HEADER);
         _loc10_.htmlText = "Class Stats:";
         _loc3_.addChild(_loc10_);
         _loc5_ += _loc10_.textHeight + 2;
         _loc11_ = UtilUI.CreateTextField(10 + 50 * 0,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc12_ = UtilUI.CreateTextField(10 + 54 * 1 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc13_ = UtilUI.CreateTextField(10 + 54 * 2 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc14_ = UtilUI.CreateTextField(10 + 54 * 3 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc15_ = UtilUI.CreateTextField(10 + 54 * 4 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc16_ = UtilUI.CreateTextField(10 + 54 * 5 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
         _loc11_.htmlText = "<b>Stat</b>";
         _loc12_.htmlText = "<b>Max</b>";
         _loc13_.htmlText = "<b>Avg.</b>";
         _loc14_.htmlText = "<b>Lvl Up</b>";
         _loc15_.htmlText = "<b>Base</b>";
         _loc16_.htmlText = "<b>To Max</b>";
         _loc3_.addChild(_loc11_);
         _loc3_.addChild(_loc12_);
         _loc3_.addChild(_loc13_);
         _loc3_.addChild(_loc14_);
         _loc3_.addChild(_loc15_);
         _loc3_.addChild(_loc16_);
         _loc5_ += 16;
         _loc17_ = 0;
         _loc18_ = 0;
         while(_loc18_ < _loc9_)
         {
            _loc22_ = Stat.TYPES[_loc18_];
            _loc23_ = UtilUI.CreateTextField(10 + 50 * 0,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc24_ = UtilUI.CreateTextField(10 + 54 * 1 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc25_ = UtilUI.CreateTextField(10 + 54 * 2 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc26_ = UtilUI.CreateTextField(10 + 54 * 3 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc27_ = UtilUI.CreateTextField(10 + 54 * 4 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc28_ = UtilUI.CreateTextField(10 + 54 * 5 - 18,_loc5_,70,Constants.TEXT_FORMAT_TT_DESC);
            _loc23_.htmlText = Constants.Color("<b>" + Stat.sShortFrIx(_loc18_) + "</b>:",Stat.COLORS[_loc18_]);
            _loc24_.htmlText = Constants.Color("" + this.GetMax(this.m_Xml,_loc22_),Stat.COLORS[_loc18_]);
            _loc25_.htmlText = Constants.Color("" + this.GetAvg(this.m_Xml,_loc22_),Stat.COLORS[_loc18_]);
            _loc26_.htmlText = Constants.Color("" + this.GetIncrAvg(this.m_Xml,_loc22_),Stat.COLORS[_loc18_]);
            _loc27_.htmlText = Constants.Color("" + this.GetBase(this.m_Xml,_loc22_),Stat.COLORS[_loc18_]);
            _loc30_ = _loc29_ = this.ToMaxAvg(this.m_Xml,_loc22_);
            if(_loc18_ < 2)
            {
               _loc30_ = Math.ceil(_loc29_ / 5);
            }
            _loc17_ += _loc30_;
            _loc28_.htmlText = Constants.Color("" + _loc29_,Stat.COLORS[_loc18_]);
            _loc3_.addChild(_loc23_);
            _loc3_.addChild(_loc24_);
            _loc3_.addChild(_loc25_);
            _loc3_.addChild(_loc26_);
            _loc3_.addChild(_loc27_);
            _loc3_.addChild(_loc28_);
            _loc5_ += 16;
            _loc18_++;
         }
         _loc19_ = Tooltip.AddTextField(10,_loc5_,_loc1_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         _loc19_.htmlText = "Average Pots to Max: <b>" + _loc17_ + "</b>";
         _loc5_ += _loc19_.textHeight + 8;
         _loc5_ = uint(_loc5_ + 6);
         _loc4_.width = _loc1_;
         _loc4_.height = _loc5_;
         _loc3_.addChild(_loc6_);
         _loc3_.addChild(_loc7_);
         _loc3_.addChild(_loc19_);
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc8_);
         Tooltip.Show(_loc2_);
      }
      
      public function ForceRedrawToolTip() : void
      {
         Tooltip.Hide();
         this.DrawToolTip();
      }
      
      private function OnOver(param1:MouseEvent) : void
      {
         this.DrawToolTip();
      }
      
      private function sCurrentStat(param1:int, param2:uint) : String
      {
         var _loc6_:* = undefined;
         var _loc3_:int = CharCompCom.Current.vStatsBonus[param2];
         var _loc4_:int = CharCompCom.Current.vStatsBase[param2];
         var _loc5_:* = "";
         if(_loc3_)
         {
            _loc5_ = " (" + StringUtil.AddPrefix(_loc3_) + ")";
         }
         _loc6_ = "<b>" + (_loc4_ + _loc3_) + _loc5_ + "</b>";
         if(_loc4_ >= param1)
         {
            _loc6_ = Constants.Color(_loc6_,Constants.COLOR_MAXED);
         }
         else if(_loc3_ > 0)
         {
            _loc6_ = Constants.Color(_loc6_,Constants.COLOR_BONUS);
         }
         else if(_loc3_ < 0)
         {
            _loc6_ = Constants.Color(_loc6_,Constants.COLOR_MALUS);
         }
         return Stat.sShortFrIx(param2) + " " + _loc6_;
      }
      
      private function GetIncrAvg(param1:XML, param2:String) : Number
      {
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc3_:uint = uint(param1.LevelIncrease.length());
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc5_ = param1.LevelIncrease[_loc4_];
            if(_loc6_ == param2)
            {
               return (Number(_loc5_.@min) + Number(_loc5_.@max)) / 2;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function GetMax(param1:XML, param2:String) : int
      {
         return param1[param2].@max;
      }
      
      private function GetBase(param1:XML, param2:String) : int
      {
         return param1[param2];
      }
      
      private function GetAvg(param1:XML, param2:String) : Number
      {
         var _loc3_:Number = this.GetBase(param1,param2);
         return _loc3_ + this.GetIncrAvg(param1,param2) * 19;
      }
      
      private function ToMaxAvg(param1:XML, param2:String) : Number
      {
         return this.GetMax(param1,param2) - this.GetAvg(param1,param2);
      }
      
      private function TextWis(param1:String) : String
      {
         return Constants.WisColor(param1);
      }
      
      private function TextBold(param1:String) : String
      {
         return "<b>" + param1 + "</b>";
      }
      
      private function TextCompare(param1:Number, param2:Number) : String
      {
         if(DPSCalculator.COMPARE == false || param1 == param2)
         {
            return "" + param2;
         }
         return param1 + this.TextBold(this.TextWis(" -> ")) + this.TextBold("" + param2);
      }
      
      private function OnOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
   }
}


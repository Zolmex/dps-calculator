package
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ItemSpriteListItem extends Sprite
   {
      public var sName:String;
      
      private var xml:XML;
      
      private var s:RotMGSprite;
      
      public function ItemSpriteListItem(param1:XML)
      {
         super();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(3355443,1);
         _loc2_.graphics.drawRect(0,0,20,20);
         _loc2_.graphics.endFill();
         addChild(_loc2_);
         this.Update(param1);
         addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
      }
      
      public function GetTex() : String
      {
         return String(this.xml.Texture);
      }
      
      public function Update(param1:*) : void
      {
         if(param1 != null)
         {
            this.xml = param1;
            this.sName = this.xml.@id;
            if(this.s != null && contains(this.s))
            {
               removeChild(this.s);
               this.s.filters = [];
               this.s = null;
            }
            this.s = new RotMGSprite(this.xml,2);
            this.s.x = this.s.y = 2;
            this.s.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
            addChild(this.s);
         }
      }
      
      private function OnOver(param1:MouseEvent) : void
      {
         var _loc4_:Sprite = null;
         var _loc7_:TextField = null;
         var _loc8_:XMLList = null;
         var _loc9_:uint = 0;
         var _loc10_:* = undefined;
         var _loc11_:String = null;
         var _loc12_:uint = 0;
         var _loc13_:Bitmap = null;
         var _loc14_:Sprite = null;
         var _loc15_:RotMGSprite = null;
         this.s.filters = [Constants.LIFE_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
         var _loc2_:Number = 260;
         var _loc3_:Sprite = new Sprite();
         _loc4_ = new Sprite();
         _loc4_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         var _loc5_:Sprite = new BackgroundTooltip();
         _loc5_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc3_.addChild(_loc5_);
         var _loc6_:TextField = Tooltip.AddTextField(4,0,_loc2_ - 20,Constants.TEXT_FORMAT_TT_HEADER);
         _loc6_.text = this.sName;
         if(this.xml.RandomTexture != undefined)
         {
            _loc8_ = this.xml.RandomTexture.children();
            _loc9_ = uint(_loc8_.length());
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc11_ = _loc8_[_loc10_].File;
               _loc12_ = uint(_loc8_[_loc10_].Index);
               _loc13_ = SpriteParser.GetSprite(_loc11_,_loc12_);
               _loc14_ = new Sprite();
               _loc14_.addChild(_loc13_);
               _loc14_.scaleX = _loc14_.scaleY = 4;
               _loc4_.addChild(_loc14_);
               _loc14_.x = 4 + 2 + _loc10_ * 36;
               _loc14_.y = Math.ceil(_loc6_.textHeight) + 4 + 2;
               _loc10_++;
            }
         }
         else
         {
            _loc15_ = new RotMGSprite(this.xml,4);
            _loc15_.x = 4 + 2;
            _loc15_.y = Math.ceil(_loc6_.textHeight) + 4 + 2;
            _loc15_.filters = [Constants.BLACK_OUTLINE];
            _loc4_.addChild(_loc15_);
         }
         _loc7_ = Tooltip.AddTextField(4,Math.ceil(_loc6_.textHeight) + 40,_loc2_ - 20,Constants.TEXT_FORMAT_TT_DESC);
         _loc7_.text = "";
         if(this.xml.Rotation != undefined)
         {
            _loc7_.appendText("Rotation: " + this.xml.Rotation);
         }
         _loc5_.width = _loc2_;
         _loc5_.height = _loc7_.y + Math.ceil(_loc7_.textHeight) + 4;
         _loc4_.addChild(_loc6_);
         _loc4_.addChild(_loc7_);
         _loc3_.addChild(_loc4_);
         Tooltip.Show(_loc3_);
      }
      
      private function OnOut(param1:MouseEvent) : void
      {
         this.s.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
         Tooltip.Hide();
      }
   }
}


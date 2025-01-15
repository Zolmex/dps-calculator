package
{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class Tooltip extends Sprite
   {
      public static var stage:Stage;
      
      public static var cont:Sprite;
      
      public static var mc:Sprite = new Sprite();
      
      public function Tooltip()
      {
         super();
      }
      
      public static function SetContainer(param1:Stage, param2:Sprite) : void
      {
         stage = param1;
         cont = param2;
         param2.mouseEnabled = false;
         param2.mouseChildren = false;
         cont.addChild(mc);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,OnMove);
      }
      
      public static function OnMove(param1:MouseEvent) : void
      {
         RefreshPos();
      }
      
      public static function Show(param1:Sprite) : void
      {
         cont.removeChild(mc);
         mc = null;
         mc = param1;
         cont.addChild(mc);
         RefreshPos();
         mc.visible = true;
      }
      
      public static function ShowAlt(param1:Sprite, param2:Number = 0) : void
      {
         cont.removeChild(mc);
         mc = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Sprite = new BackgroundTooltip();
         _loc4_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(param1);
         param1.y = 4;
         param1.x = 4;
         _loc4_.width = param1.width + 8 + param2;
         _loc4_.height = param1.height + 8;
         mc = _loc3_;
         cont.addChild(mc);
         RefreshPos();
         mc.visible = true;
      }
      
      public static function Hide() : void
      {
         mc.visible = false;
      }
      
      public static function RefreshPos() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(mc.height + 16 + cont.mouseY >= stage.stageHeight)
         {
            _loc1_ = -mc.height + cont.mouseY - 16;
            if(_loc1_ < 0)
            {
               mc.y = 0;
            }
            else
            {
               mc.y = _loc1_;
            }
         }
         else
         {
            mc.y = cont.mouseY + 16;
         }
         if(mc.width + 16 + cont.mouseX >= stage.stageWidth)
         {
            _loc2_ = -mc.width + cont.mouseX - 16;
            if(_loc2_ < 0)
            {
               mc.x = 0;
            }
            else
            {
               mc.x = _loc2_;
            }
         }
         else
         {
            mc.x = cont.mouseX + 16;
         }
      }
      
      public static function AddTextField(param1:Number, param2:Number, param3:Number, param4:TextFormat) : TextField
      {
         var _loc5_:TextField = new TextField();
         _loc5_.defaultTextFormat = param4;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.embedFonts = true;
         if(param3)
         {
            _loc5_.width = param3;
         }
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.mouseEnabled = false;
         _loc5_.selectable = false;
         _loc5_.condenseWhite = true;
         return _loc5_;
      }
      
      public static function ShowDefault(param1:String = "") : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc2_.defaultTextFormat = Constants.TEXT_FORMAT_TT_DESC;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.htmlText = param1;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(_loc2_);
         ShowNew(_loc3_);
      }
      
      public static function ShowNew(param1:Sprite) : void
      {
         param1.x = 4;
         param1.y = 4;
         var _loc2_:Sprite = new BackgroundTooltip();
         _loc2_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc2_.width = param1.width + 12;
         _loc2_.height = param1.height + 12;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(_loc2_);
         _loc3_.addChild(param1);
         Show(_loc3_);
      }
   }
}


package
{
   import fl.controls.TextInput;
   import fl.text.TLFTextField;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class UtilUI
   {
      public function UtilUI()
      {
         super();
      }
      
      public static function CreateCheckBox(param1:Number, param2:Number, param3:String, param4:Function, param5:TextFormatPlus) : FCheckBox
      {
         var _loc6_:FCheckBox = new FCheckBox();
         _loc6_.label = param3;
         _loc6_.textField.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.setStyle("embedFonts",true);
         _loc6_.setStyle("textFormat",param5);
         _loc6_.addEventListener(MouseEvent.CLICK,param4);
         _loc6_.x = param1;
         _loc6_.y = param2;
         return _loc6_;
      }
      
      public static function CreateTextField(param1:Number, param2:Number, param3:Number, param4:TextFormatPlus) : TextField
      {
         var _loc5_:TextField = null;
         _loc5_ = new TextField();
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
      
      public static function CreateTLFTextField(param1:Number, param2:Number, param3:Number, param4:Number, param5:TextFormatPlus) : TLFTextField
      {
         var _loc6_:TLFTextField = new TLFTextField();
         _loc6_.defaultTextFormat = param5;
         _loc6_.multiline = true;
         _loc6_.wordWrap = true;
         _loc6_.embedFonts = true;
         if(param3)
         {
            _loc6_.width = param3;
         }
         if(param4)
         {
            _loc6_.height = param4;
         }
         _loc6_.x = param1;
         _loc6_.y = param2;
         _loc6_.mouseEnabled = false;
         _loc6_.selectable = false;
         _loc6_.condenseWhite = true;
         return _loc6_;
      }
      
      public static function CreateNumStep(param1:Number, param2:Number, param3:Number, param4:Number, param5:TextFormatPlus) : FNumStep
      {
         var _loc6_:FNumStep = new FNumStep();
         _loc6_.setStyle("embedFonts",true);
         _loc6_.setStyle("textFormat",param5);
         _loc6_.setStyle("textPadding",-2);
         _loc6_.move(param1,param2);
         _loc6_.setSize(param3,param4);
         return _loc6_;
      }
      
      public static function CreateTextInput(param1:Number, param2:Number, param3:Number, param4:Number, param5:TextFormatPlus) : TextInput
      {
         var _loc6_:TextInput = new TextInput();
         _loc6_.setStyle("embedFonts",true);
         _loc6_.setStyle("textFormat",param5);
         _loc6_.setStyle("textPadding",-2);
         _loc6_.move(param1,param2);
         _loc6_.setSize(param3,param4);
         return _loc6_;
      }
   }
}


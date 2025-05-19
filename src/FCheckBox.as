package
{
   import fl.controls.CheckBox;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.text.TextFieldAutoSize;
   
   public class FCheckBox extends CheckBox
   {
      public function FCheckBox()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         removeChild(background);
         var _loc1_:Shape = new Shape();
         var _loc2_:Graphics = _loc1_.graphics;
         _loc2_.beginFill(0,0);
         _loc2_.drawRect(0,0,_width,_height);
         _loc2_.endFill();
         background = _loc1_ as DisplayObject;
         addChildAt(background,0);
      }
      
      override public function set label(param1:String) : void
      {
         super.label = param1;
         textField.multiline = false;
         textField.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}


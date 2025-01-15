package
{
   import fl.controls.Button;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   
   public class ButtonPlus extends Sprite
   {
      public var txt:TextField;
      
      public var btn:Button;
      
      public function ButtonPlus(param1:String, param2:Number, param3:Number, param4:TextFormatPlus)
      {
         super();
         this.btn = new Button();
         this.btn.setSize(param2,param3);
         this.btn.label = "";
         this.btn.setStyle("embedFonts",true);
         this.btn.setStyle("textFormat",param4);
         var _loc5_:TextFormatPlus = param4.Clone();
         _loc5_.align = TextFormatAlign.CENTER;
         this.txt = UtilUI.CreateTextField(0,0,param2,_loc5_);
         this.txt.text = param1;
         this.txt.y = param3 / 2 - this.txt.height / 2;
         addChild(this.btn);
         addChild(this.txt);
      }
      
      public function set text(param1:String) : void
      {
         this.txt.text = param1;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
   }
}


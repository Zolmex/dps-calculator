package
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   
   public class LoadUI extends Sprite
   {
      private var bar:ProgressBar;
      
      private var txt:TextField;
      
      public function LoadUI(param1:Number = 4, param2:uint = 16777215, param3:uint = 16711680)
      {
         super();
         this.bar = new ProgressBar(param1,param2,param3);
         this.bar.x = -this.bar.width / 2;
         this.bar.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_OBJECT];
         addChild(this.bar);
         var _loc4_:TextFormatPlus = Constants.TEXT_FORMAT_TT_HEADER.Clone();
         _loc4_.align = TextFormatAlign.CENTER;
         this.txt = UtilUI.CreateTextField(0,this.bar.height * 2,256,_loc4_);
         this.txt.x = -this.txt.width / 2;
         this.txt.filters = [Constants.GLOW_BLACK_OBJECT];
         addChild(this.txt);
      }
      
      public function Update(param1:Number, param2:String) : void
      {
         this.bar.progress = param1;
         this.txt.text = param2;
      }
      
      public function Reset() : void
      {
         this.bar.Reset();
         this.txt.text = "";
      }
      
      public function Destroy() : void
      {
         this.bar.filters = [];
         this.txt.filters = [];
         removeChild(this.bar);
         removeChild(this.txt);
         this.bar = null;
         this.txt = null;
      }
   }
}


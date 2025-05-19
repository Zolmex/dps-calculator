package
{
   import flash.display.Sprite;
   
   public class ProgressBar extends Sprite
   {
      private var bar:Sprite;
      
      private var frame:Sprite;
      
      public function ProgressBar(param1:Number = 4, param2:uint = 16777215, param3:uint = 16711680)
      {
         super();
         this.frame = new Sprite();
         this.frame.graphics.beginFill(param2);
         this.frame.graphics.drawRect(0,0,8,4);
         this.frame.graphics.drawRect(1,1,6,2);
         this.frame.graphics.endFill();
         this.bar = new Sprite();
         this.bar.graphics.beginFill(param3);
         this.bar.graphics.drawRect(1,1,6,2);
         this.bar.graphics.endFill();
         this.bar.scaleX = 0;
         addChild(this.bar);
         addChild(this.frame);
         scaleX = scaleY = param1;
      }
      
      public function set progress(param1:Number) : void
      {
         this.bar.scaleX = param1;
      }
      
      public function Reset() : void
      {
         this.bar.scaleX = 0;
      }
   }
}


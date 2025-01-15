package
{
   import flash.display.Sprite;
   
   public class Overlay extends Sprite
   {
      public var m_iDef:uint;
      
      public function Overlay(param1:uint, param2:Number, param3:Number, param4:Number = 0)
      {
         super();
         this.m_iDef = param1;
         graphics.beginFill(16711680,param4);
         graphics.drawRect(0,0,param2,param3);
         graphics.endFill();
      }
   }
}


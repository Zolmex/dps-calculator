package
{
   import flash.display.Sprite;
   
   public class ClassPicker extends Sprite
   {
      private var m_iClass:uint;
      
      public var item:Player;
      
      private var bg:Sprite;
      
      private var m_bCurrent:Boolean;
      
      public function ClassPicker(param1:Boolean = false)
      {
         super();
         this.m_bCurrent = param1;
         this.bg = new Sprite();
         this.bg.graphics.lineStyle(2,8947848);
         this.bg.graphics.beginFill(5526612,1);
         this.bg.graphics.drawRoundRect(0,0,8 * 5 + 8,8 * 5 + 8,16,16);
         this.bg.graphics.endFill();
         addChild(this.bg);
      }
      
      public function set iClass(param1:uint) : void
      {
         this.m_iClass = param1;
         this.Reset();
         this.item = new Player(XmlData.aPlayers[this.m_iClass],5,this.m_bCurrent);
         addChild(this.item);
         this.item.x = this.item.y = 4;
      }
      
      public function get iClass() : uint
      {
         return this.m_iClass;
      }
      
      public function Reset() : void
      {
         if(this.item != null && contains(this.item))
         {
            removeChild(this.item);
         }
      }
   }
}


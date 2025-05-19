package
{
   import flash.display.Sprite;
   
   public class ItemPicker extends Sprite
   {
      private var m_iSlotType:uint;
      
      private var m_iItem:uint;
      
      private var item:Item;
      
      private var bg:Sprite;
      
      public var wep:Weapon;
      
      public function ItemPicker()
      {
         super();
      }
      
      public function SetBackground(param1:Boolean = false, param2:Boolean = false) : *
      {
         var _loc3_:uint = 8947848;
         var _loc4_:uint = 5526612;
         if(param1 && param2)
         {
            _loc4_ = 2774058;
         }
         else if(param1)
         {
            _loc4_ = 5515818;
         }
         else if(param2)
         {
            _loc4_ = 2763348;
         }
         this.bg = new Sprite();
         this.bg.graphics.lineStyle(2,_loc3_);
         this.bg.graphics.beginFill(_loc4_,1);
         this.bg.graphics.drawRoundRect(0,0,8 * 4 + 8,8 * 4 + 8,16,16);
         this.bg.graphics.endFill();
         addChild(this.bg);
      }
      
      public function set iItem(param1:uint) : void
      {
         if(param1 == 0)
         {
            return this.Reset();
         }
         this.Reset();
         this.m_iItem = param1;
         this.item = new Item(XmlData.EqById(this.m_iItem),4);
         addChild(this.item);
         this.item.x = this.item.y = 4;
      }
      
      public function SetWep(param1:Weapon) : void
      {
         this.Reset();
         this.wep = param1;
         this.item = new Item(param1.GetXML(),4);
         addChild(this.item);
         this.item.x = this.item.y = 4;
      }
      
      public function get iItem() : uint
      {
         return this.m_iItem;
      }
      
      public function get ContItem() : Item
      {
         return this.item;
      }
      
      public function set iSlotType(param1:uint) : void
      {
         this.m_iSlotType = param1;
      }
      
      public function get iSlotType() : uint
      {
         return this.m_iSlotType;
      }
      
      public function Reset() : void
      {
         if(this.item != null && contains(this.item))
         {
            removeChild(this.item);
         }
         this.m_iItem = 0;
      }
   }
}


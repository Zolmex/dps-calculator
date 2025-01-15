package
{
   import flash.display.Sprite;
   import shared.math.Vec2;
   
   public class Particle extends Sprite
   {
      private const LIFESPAN:uint = 500;
      
      private const SPPED:uint = 30;
      
      private var m_vVel:Vec2;
      
      private var m_iLifespan:Number;
      
      private var m_iLifespanMax:Number;
      
      private var m_bRemoveMe:Boolean;
      
      private var bg:Sprite;
      
      private var m_fX:Number;
      
      private var m_fY:Number;
      
      public function Particle(param1:Number, param2:Number, param3:Vec2, param4:Number = 500, param5:uint = 16711935)
      {
         super();
         this.m_fX = param1;
         this.m_fY = param2;
         this.PixelFix();
         this.bg = new Sprite();
         this.bg.graphics.beginFill(param5,1);
         this.bg.graphics.drawRect(0,0,1,1);
         this.bg.graphics.endFill();
         addChild(this.bg);
         this.bg.filters = [Constants.BLACK_OUTLINE];
         this.m_bRemoveMe = false;
         this.m_vVel = param3;
         this.m_iLifespan = param4;
         this.m_iLifespanMax = param4;
      }
      
      public function get NeedsToBeRemoved() : Boolean
      {
         return this.m_bRemoveMe;
      }
      
      private function AdjPos(param1:Number, param2:Number) : void
      {
         this.m_fX += param1;
         this.m_fY += param2;
         this.PixelFix();
      }
      
      protected function PixelFix() : void
      {
         x = int(this.m_fX);
         y = int(this.m_fY);
      }
      
      public function Step() : void
      {
         --this.m_iLifespan;
         if(this.m_iLifespan <= 0)
         {
            this.m_bRemoveMe = true;
            return;
         }
         this.AdjPos(this.m_vVel.x,this.m_vVel.y);
         this.bg.scaleX = this.bg.scaleY = 1 + int(this.m_iLifespan / this.m_iLifespanMax * 4);
         this.bg.x = this.bg.y = -int(1 + int(this.m_iLifespan / this.m_iLifespanMax * 4) / 2);
      }
   }
}


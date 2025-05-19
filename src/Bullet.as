package
{
   import com.pfiffel.util.MathUtil;
   import flash.display.Sprite;
   import shared.math.Vec2;
   
   public class Bullet extends Sprite
   {
      private var m_vVel:Vec2;
      
      private var m_vOsc:Vec2;
      
      private var m_vOffset:Vec2;
      
      private var m_fLifespan:Number;
      
      private var m_fLifespanMax:Number;
      
      private var m_bRemoveMe:Boolean;
      
      private var m_fSineOffset:Number;
      
      private var m_fGfxRotationSpeed:Number;
      
      private var m_Sprite:SimpleSprite;
      
      private var m_iSineOffset:int;
      
      private var m_fOsc:Number = 0;
      
      private var m_fOscX:Number = 0;
      
      private var m_fOscY:Number = 0;
      
      private var fAmplitude:Number;
      
      private var fFrequency:Number;
      
      private var m_bWavy:Boolean;
      
      private var m_iParametric:int;
      
      private var m_xmlPart:XMLList;
      
      public function Bullet(param1:Vec2, param2:Vec2, param3:XML = null, param4:Number = 1000, param5:Number = 4, param6:int = 1, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Boolean = false, param12:int = 0, param13:XMLList = null)
      {
         super();
         this.m_bRemoveMe = false;
         x = param1.x;
         y = param1.y;
         this.m_vOffset = param1;
         this.m_vVel = param2;
         this.m_vOsc = param2;
         this.m_iParametric = param12;
         this.m_bWavy = param11;
         this.m_iSineOffset = param6;
         this.fAmplitude = param7;
         this.fFrequency = param8;
         this.m_Sprite = new SimpleSprite(param3);
         this.m_Sprite.scaleX = this.m_Sprite.scaleY = param5;
         addChild(this.m_Sprite);
         this.m_fLifespan = param4;
         this.m_fLifespanMax = param4;
         this.m_fGfxRotationSpeed = param9;
         rotation = this.m_vVel.getDegrees() + param10;
         this.m_xmlPart = param13;
      }
      
      public function get xmlPart() : XMLList
      {
         return this.m_xmlPart;
      }
      
      public function get NeedsToBeRemoved() : Boolean
      {
         return this.m_bRemoveMe;
      }
      
      public function Step() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vec2 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         this.m_fLifespan -= GameTime.INTERVAL;
         var _loc1_:Number = 1;
         if(this.m_fLifespan <= 0)
         {
            _loc1_ = (this.m_fLifespan + GameTime.INTERVAL) / GameTime.INTERVAL;
         }
         if(this.m_fGfxRotationSpeed)
         {
            this.m_Sprite.rotation += this.m_fGfxRotationSpeed * _loc1_;
         }
         if(Boolean(this.fAmplitude) && !this.m_iParametric)
         {
            _loc2_ = 360 / this.m_fLifespanMax;
            _loc3_ = this.m_fLifespanMax - this.m_fLifespan;
            _loc4_ = this.m_fOsc;
            _loc5_ = 50 * this.fAmplitude;
            if(this.m_bWavy)
            {
               _loc5_ *= 1 - this.m_fLifespan / this.m_fLifespanMax;
            }
            this.m_fOsc = Math.sin(MathUtil.fDegToRad * (_loc3_ * _loc2_ * this.fFrequency)) * _loc5_ * this.m_iSineOffset;
            _loc6_ = new Vec2(0,_loc4_ - this.m_fOsc);
            _loc6_.rotateSelf(this.m_vVel.getRads());
            x += _loc6_.x * _loc1_;
            y += _loc6_.y * _loc1_;
         }
         if(this.m_iParametric)
         {
            _loc2_ = 360 / this.m_fLifespanMax;
            _loc3_ = this.m_fLifespanMax - this.m_fLifespan + this.m_fLifespanMax / 4 + (this.m_iParametric - 1) * 2 * this.m_fLifespanMax / 4;
            _loc3_ *= this.m_iSineOffset;
            _loc7_ = this.m_fOscX;
            _loc8_ = this.m_fOscY;
            _loc5_ = 50 * 3;
            this.m_fOscX = Math.cos(1 * MathUtil.fDegToRad * (_loc3_ * _loc2_ * this.fFrequency)) * _loc5_ * 1;
            this.m_fOscY = Math.sin(2 * MathUtil.fDegToRad * (_loc3_ * _loc2_ * this.fFrequency)) * _loc5_ * 1;
            _loc6_ = new Vec2(this.m_fOscX,this.m_fOscY);
            _loc6_.rotateSelf(this.m_vVel.getRads());
            _loc6_.addSelf(this.m_vOffset);
            x += _loc6_.x - x;
            y += _loc6_.y - y;
         }
         else
         {
            x += this.m_vVel.x * _loc1_;
            y += this.m_vVel.y * _loc1_;
         }
         if(this.m_fLifespan <= 0)
         {
            this.m_bRemoveMe = true;
            return;
         }
      }
   }
}


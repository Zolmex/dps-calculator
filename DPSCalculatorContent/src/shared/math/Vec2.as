package shared.math
{
   public class Vec2 extends Vec2Const
   {
      public function Vec2(param1:Number = 0, param2:Number = 0)
      {
         super(param1,param2);
      }
      
      public static function swap(param1:Vec2, param2:Vec2) : void
      {
         var _loc3_:Number = Number(param1._x);
         var _loc4_:Number = Number(param1._y);
         param1._x = param2._x;
         param1._y = param2._y;
         param2._x = _loc3_;
         param2._y = _loc4_;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function copy(param1:Vec2Const) : Vec2
      {
         _x = param1._x;
         _y = param1._y;
         return this;
      }
      
      public function copyXY(param1:Number, param2:Number) : Vec2
      {
         _x = param1;
         _y = param2;
         return this;
      }
      
      public function zero() : Vec2
      {
         _x = 0;
         _y = 0;
         return this;
      }
      
      public function addSelf(param1:Vec2Const) : Vec2
      {
         _x += param1._x;
         _y += param1._y;
         return this;
      }
      
      public function addXYSelf(param1:Number, param2:Number) : Vec2
      {
         _x += param1;
         _y += param2;
         return this;
      }
      
      public function subSelf(param1:Vec2Const) : Vec2
      {
         _x -= param1._x;
         _y -= param1._y;
         return this;
      }
      
      public function subXYSelf(param1:Number, param2:Number) : Vec2
      {
         _x -= param1;
         _y -= param2;
         return this;
      }
      
      public function mulSelf(param1:Vec2Const) : Vec2
      {
         _x *= param1._x;
         _y *= param1._y;
         return this;
      }
      
      public function mulXYSelf(param1:Number, param2:Number) : Vec2
      {
         _x *= param1;
         _y *= param2;
         return this;
      }
      
      public function divSelf(param1:Vec2Const) : Vec2
      {
         _x /= param1._x;
         _y /= param1._y;
         return this;
      }
      
      public function divXYSelf(param1:Number, param2:Number) : Vec2
      {
         _x /= param1;
         _y /= param2;
         return this;
      }
      
      public function scaleSelf(param1:Number) : Vec2
      {
         _x *= param1;
         _y *= param1;
         return this;
      }
      
      public function normalizeSelf() : Vec2
      {
         var _loc1_:Number = 1 / Math.sqrt(_x * _x + _y * _y);
         _x *= _loc1_;
         _y *= _loc1_;
         return this;
      }
      
      public function rotateSelf(param1:Number) : Vec2
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = Math.sin(param1);
         _loc3_ = Math.cos(param1);
         var _loc4_:Number = _x * _loc3_ - _y * _loc2_;
         _y = _x * _loc2_ + _y * _loc3_;
         _x = _loc4_;
         return this;
      }
      
      public function normalRightSelf() : Vec2
      {
         var _loc1_:Number = Number(_x);
         _x = -_y;
         _y = _loc1_;
         return this;
      }
      
      public function normalLeftSelf() : Vec2
      {
         var _loc1_:Number = Number(_x);
         _x = _y;
         _y = -_loc1_;
         return this;
      }
      
      public function negateSelf() : Vec2
      {
         _x = -_x;
         _y = -_y;
         return this;
      }
      
      public function rotateSpinorSelf(param1:Vec2Const) : Vec2
      {
         var _loc2_:Number = _x * param1._x - _y * param1._y;
         _y = _x * param1._y + _y * param1._x;
         _x = _loc2_;
         return this;
      }
      
      public function lerpSelf(param1:Vec2Const, param2:Number) : Vec2
      {
         _x += param2 * (param1._x - _x);
         _y += param2 * (param1._y - _y);
         return this;
      }
   }
}


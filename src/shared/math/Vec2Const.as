package shared.math
{
   public class Vec2Const
   {
      public static const Zero:Vec2Const = new Vec2Const();
      
      public static const Epsilon:Number = 1e-7;
      
      public static const EpsilonSqr:Number = Epsilon * Epsilon;
      
      private static const _RadsToDeg:Number = 180 / Math.PI;
      
      internal var _x:Number;
      
      internal var _y:Number;
      
      public function Vec2Const(param1:Number = 0, param2:Number = 0)
      {
         super();
         this._x = param1;
         this._y = param2;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function clone() : Vec2
      {
         return new Vec2(this._x,this._y);
      }
      
      public function add(param1:Vec2Const) : Vec2
      {
         return new Vec2(this._x + param1._x,this._y + param1._y);
      }
      
      public function addXY(param1:Number, param2:Number) : Vec2
      {
         return new Vec2(this._x + param1,this._y + param2);
      }
      
      public function sub(param1:Vec2Const) : Vec2
      {
         return new Vec2(this._x - param1._x,this._y - param1._y);
      }
      
      public function subXY(param1:Number, param2:Number) : Vec2
      {
         return new Vec2(this._x - param1,this._y - param2);
      }
      
      public function mul(param1:Vec2Const) : Vec2
      {
         return new Vec2(this._x * param1._x,this._y * param1._y);
      }
      
      public function mulXY(param1:Number, param2:Number) : Vec2
      {
         return new Vec2(this._x * param1,this._y * param2);
      }
      
      public function div(param1:Vec2Const) : Vec2
      {
         return new Vec2(this._x / param1._x,this._y / param1._y);
      }
      
      public function divXY(param1:Number, param2:Number) : Vec2
      {
         return new Vec2(this._x / param1,this._y / param2);
      }
      
      public function scale(param1:Number) : Vec2
      {
         return new Vec2(this._x * param1,this._y * param1);
      }
      
      public function normalize() : Vec2
      {
         var _loc1_:Number = 1 / Math.sqrt(this._x * this._x + this._y * this._y);
         return new Vec2(this._x * _loc1_,this._y * _loc1_);
      }
      
      public function length() : Number
      {
         return Math.sqrt(this._x * this._x + this._y * this._y);
      }
      
      public function lengthSqr() : Number
      {
         return this._x * this._x + this._y * this._y;
      }
      
      public function distance(param1:Vec2Const) : Number
      {
         var _loc2_:Number = this._x - param1._x;
         var _loc3_:Number = this._y - param1._y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function distanceXY(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this._x - param1;
         var _loc4_:Number = this._y - param2;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public function distanceSqr(param1:Vec2Const) : Number
      {
         var _loc2_:Number = this._x - param1._x;
         var _loc3_:Number = this._y - param1._y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function distanceXYSqr(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this._x - param1;
         var _loc4_:Number = this._y - param2;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_;
      }
      
      public function equals(param1:Vec2Const) : Boolean
      {
         return this._x == param1._x && this._y == param1._y;
      }
      
      public function equalsXY(param1:Number, param2:Number) : Boolean
      {
         return this._x == param1 && this._y == param2;
      }
      
      public function isNormalized() : Boolean
      {
         return Math.abs(this._x * this._x + this._y * this._y - 1) < EpsilonSqr;
      }
      
      public function isZero() : Boolean
      {
         return this._x == 0 && this._y == 0;
      }
      
      public function isNear(param1:Vec2Const) : Boolean
      {
         return this.distanceSqr(param1) < EpsilonSqr;
      }
      
      public function isNearXY(param1:Number, param2:Number) : Boolean
      {
         return this.distanceXYSqr(param1,param2) < EpsilonSqr;
      }
      
      public function isWithin(param1:Vec2Const, param2:Number) : Boolean
      {
         return this.distanceSqr(param1) < param2 * param2;
      }
      
      public function isWithinXY(param1:Number, param2:Number, param3:Number) : Boolean
      {
         return this.distanceXYSqr(param1,param2) < param3 * param3;
      }
      
      public function isValid() : Boolean
      {
         return !isNaN(this._x) && !isNaN(this._y) && isFinite(this._x) && isFinite(this._y);
      }
      
      public function getDegrees() : Number
      {
         return this.getRads() * _RadsToDeg;
      }
      
      public function getRads() : Number
      {
         return Math.atan2(this._y,this._x);
      }
      
      public function dot(param1:Vec2Const) : Number
      {
         return this._x * param1._x + this._y * param1._y;
      }
      
      public function dotXY(param1:Number, param2:Number) : Number
      {
         return this._x * param1 + this._y * param2;
      }
      
      public function crossDet(param1:Vec2Const) : Number
      {
         return this._x * param1._y - this._y * param1._x;
      }
      
      public function crossDetXY(param1:Number, param2:Number) : Number
      {
         return this._x * param2 - this._y * param1;
      }
      
      public function rotate(param1:Number) : Vec2
      {
         var _loc2_:Number = Math.sin(param1);
         var _loc3_:Number = Math.cos(param1);
         return new Vec2(this._x * _loc3_ - this._y * _loc2_,this._x * _loc2_ + this._y * _loc3_);
      }
      
      public function normalRight() : Vec2
      {
         return new Vec2(-this._y,this._x);
      }
      
      public function normalLeft() : Vec2
      {
         return new Vec2(this._y,-this._x);
      }
      
      public function negate() : Vec2
      {
         return new Vec2(-this._x,-this._y);
      }
      
      public function rotateSpinor(param1:Vec2Const) : Vec2
      {
         return new Vec2(this._x * param1._x - this._y * param1._y,this._x * param1._y + this._y * param1._x);
      }
      
      public function spinorBetween(param1:Vec2Const) : Vec2
      {
         var _loc2_:Number = NaN;
         _loc2_ = this.lengthSqr();
         var _loc3_:Number = (param1._x * this._x + param1._y * this._y) / _loc2_;
         var _loc4_:Number = (param1._y * this._x - param1._x * this._y) / _loc2_;
         return new Vec2(_loc3_,_loc4_);
      }
      
      public function lerp(param1:Vec2Const, param2:Number) : Vec2
      {
         return new Vec2(this._x + param2 * (param1._x - this._x),this._y + param2 * (param1._y - this._y));
      }
      
      public function slerp(param1:Vec2Const, param2:Number) : Vec2
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc3_ = this.dot(param1);
         _loc4_ = Math.acos(_loc3_);
         var _loc5_:Number = Math.sin(_loc4_);
         if(_loc5_ <= Epsilon)
         {
            return param1.clone();
         }
         _loc6_ = Math.sin((1 - param2) * _loc4_) / _loc5_;
         _loc7_ = Math.sin(param2 * _loc4_) / _loc5_;
         return this.scale(_loc6_).add(param1.scale(_loc7_));
      }
      
      public function reflect(param1:Vec2Const) : Vec2
      {
         var _loc2_:Number = 2 * (this._x * param1._x + this._y * param1._y);
         return new Vec2(this._x - _loc2_ * param1._x,this._y - _loc2_ * param1._y);
      }
      
      public function toString() : String
      {
         return "[" + this._x + ", " + this._y + "]";
      }
   }
}


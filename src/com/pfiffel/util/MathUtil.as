package com.pfiffel.util
{
   public class MathUtil
   {
      public static const fRadToDeg:Number = 180 / Math.PI;
      
      public static const fDegToRad:Number = Math.PI / 180;
      
      public function MathUtil()
      {
         super();
      }
      
      public static function RangeRound(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (1 + param2 - param1)) + param1;
      }
      
      public static function Range(param1:Number, param2:Number) : Number
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      public static function Round(param1:Number, param2:int = 0) : Number
      {
         return Math.round(param1 * Math.pow(10,param2)) / Math.pow(10,param2);
      }
      
      public static function Floor(param1:Number, param2:int = 1) : Number
      {
         return Math.floor(param1 * Math.pow(10,param2)) / Math.pow(10,param2);
      }
      
      public static function Ceil(param1:Number, param2:int = 1) : Number
      {
         return Math.ceil(param1 * Math.pow(10,param2)) / Math.pow(10,param2);
      }
      
      public static function Chance(param1:Number) : Boolean
      {
         var _loc2_:Number = Math.random();
         if(_loc2_ < param1)
         {
            return true;
         }
         return false;
      }
   }
}


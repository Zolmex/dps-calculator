package
{
   import flash.utils.ByteArray;
   
   public class Utils
   {
      public function Utils()
      {
         super();
      }
      
      public static function cloneObject(param1:*) : *
      {
         return getByteArray(param1);
      }
      
      public static function getByteArray(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function fWisMod(param1:int) : Number
      {
         var _loc4_:Number = 1;
         var _loc5_:Number = param1 / (15 * 10);
         if(param1 >= 30)
         {
            _loc4_ = 1 + _loc5_;
         }
         if(_loc4_ > 5)
         {
            _loc4_ = 5;
         }
         return _loc4_;
      }
   }
}


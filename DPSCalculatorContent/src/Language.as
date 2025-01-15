package
{
   import com.adobe.serialization.json.JSON;
   
   public class Language
   {
      public static var en:Object = new Object();
      
      public function Language()
      {
         super();
      }
      
      public static function Init(param1:String) : void
      {
         var _loc2_:Array = com.adobe.serialization.json.JSON.decode(param1);
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length)
         {
            en[_loc2_[_loc3_][0]] = _loc2_[_loc3_][1];
            _loc3_++;
         }
      }
      
      public static function getString(param1:String) : String
      {
         if(param1.charAt(0) == "{")
         {
            param1 = param1.substr(1,param1.length - 2);
         }
         if(en[param1] != null)
         {
            return en[param1];
         }
         return param1;
      }
   }
}


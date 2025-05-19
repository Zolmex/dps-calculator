package
{
   public class StringUtil
   {
      public function StringUtil()
      {
         super();
      }
      
      public static function AddPrefix(param1:int) : String
      {
         if(param1 > 0)
         {
            return String("+" + param1);
         }
         return String("" + param1);
      }
   }
}


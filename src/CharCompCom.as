package
{
   public class CharCompCom
   {
      public static var m:DPSCalculator;
      
      public function CharCompCom()
      {
         super();
      }
      
      public static function set Main(param1:DPSCalculator) : void
      {
         m = param1;
      }
      
      public static function get Current() : CharComposition
      {
         return m.GetComp();
      }
   }
}


package
{
   public class Stat
   {
      public static const HP:uint = 0;
      
      public static const MP:uint = 1;
      
      public static const ATT:uint = 2;
      
      public static const DEF:uint = 3;
      
      public static const SPD:uint = 4;
      
      public static const DEX:uint = 5;
      
      public static const VIT:uint = 6;
      
      public static const WIS:uint = 7;
      
      public static const TYPES:Vector.<String> = Vector.<String>(["MaxHitPoints","MaxMagicPoints","Attack","Defense","Speed","Dexterity","HpRegen","MpRegen"]);
      
      public static const COLORS:Vector.<String> = Vector.<String>(["40ffff","c8aa1d","ab1ab1","606060","179c4b","eb8931","ce001f","4063e3"]);
      
      public function Stat()
      {
         super();
      }
      
      public static function sShortFrIx(param1:uint) : String
      {
         switch(param1)
         {
            case 0:
               return "HP";
            case 1:
               return "MP";
            case 2:
               return "ATT";
            case 3:
               return "DEF";
            case 4:
               return "SPD";
            case 5:
               return "DEX";
            case 6:
               return "VIT";
            case 7:
               return "WIS";
            default:
               return "ERROR";
         }
      }
      
      public static function sNameFrId(param1:uint) : String
      {
         switch(param1)
         {
            case 0:
               return "Maximum HP";
            case 3:
               return "Maximum MP";
            case 20:
               return "Attack";
            case 21:
               return "Defense";
            case 22:
               return "Speed";
            case 28:
               return "Dexterity";
            case 26:
               return "Vitality";
            case 27:
               return "Wisdom";
            default:
               return "ERROR";
         }
      }
      
      public static function iIxFrId(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 3:
               _loc2_ = 1;
               break;
            case 20:
               _loc2_ = 2;
               break;
            case 21:
               _loc2_ = 3;
               break;
            case 22:
               _loc2_ = 4;
               break;
            case 28:
               _loc2_ = 5;
               break;
            case 26:
               _loc2_ = 6;
               break;
            case 27:
               _loc2_ = 7;
         }
         return _loc2_;
      }
      
      public static function iIdFrIx(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 3;
               break;
            case 2:
               _loc2_ = 20;
               break;
            case 3:
               _loc2_ = 21;
               break;
            case 4:
               _loc2_ = 22;
               break;
            case 5:
               _loc2_ = 28;
               break;
            case 6:
               _loc2_ = 26;
               break;
            case 7:
               _loc2_ = 27;
         }
         return _loc2_;
      }
   }
}


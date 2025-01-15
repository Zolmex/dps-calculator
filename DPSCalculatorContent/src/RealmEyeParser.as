package
{
   import com.adobe.serialization.json.JSON;
   
   public class RealmEyeParser
   {
      public static var en:Object = new Object();
      
      public function RealmEyeParser()
      {
         super();
      }
      
      public static function GetComp(param1:String) : Vector.<CharComposition>
      {
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:CharComposition = null;
         var _loc2_:Vector.<CharComposition> = new Vector.<CharComposition>();
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(param1);
         var _loc4_:int = int(_loc3_.characters.length);
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = GetClassId(_loc3_.characters[_loc5_]["class"]);
            _loc7_ = uint(_loc3_.characters[_loc5_].equips.data_weapon_id);
            _loc8_ = new CharComposition(_loc6_,_loc3_.characters[_loc5_].stats.attack,_loc3_.characters[_loc5_].stats.dexterity,_loc3_.characters[_loc5_].stats.wisdom,_loc3_.characters[_loc5_].stats.defense,Math.max(_loc3_.characters[_loc5_].equips.data_weapon_id,0),Math.max(_loc3_.characters[_loc5_].equips.data_ability_id,0),Math.max(_loc3_.characters[_loc5_].equips.data_armor_id,0),Math.max(_loc3_.characters[_loc5_].equips.data_ring_id,0),0,0,false);
            _loc8_.SetWep(new Weapon(XmlData.aObject[_loc7_]));
            _loc8_.CalculateForWepEdit();
            _loc2_.push(_loc8_);
            _loc5_++;
         }
         return _loc2_;
      }
      
      private static function GetMaxAtt(param1:uint) : uint
      {
         return XmlData.aPlayers[param1].Attack.@max;
      }
      
      private static function GetMaxDex(param1:uint) : uint
      {
         return XmlData.aPlayers[param1].Dexterity.@max;
      }
      
      private static function GetMaxWis(param1:uint) : uint
      {
         return XmlData.aPlayers[param1].MpRegen.@max;
      }
      
      public static function GetClassId(param1:String) : int
      {
         switch(param1)
         {
            case "Rogue":
               return 0;
            case "Archer":
               return 1;
            case "Wizard":
               return 2;
            case "Priest":
               return 3;
            case "Warrior":
               return 4;
            case "Knight":
               return 5;
            case "Paladin":
               return 6;
            case "Assassin":
               return 7;
            case "Necromancer":
               return 8;
            case "Huntress":
               return 9;
            case "Mystic":
               return 10;
            case "Trickster":
               return 11;
            case "Sorcerer":
               return 12;
            case "Ninja":
               return 13;
            default:
               return -1;
         }
      }
   }
}


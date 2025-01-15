package
{
   import flash.utils.getTimer;
   
   public class XmlData
   {
      public static var xml:XML;
      
      public static var aObject:Array = new Array();
      
      public static var aEq:Array = new Array();
      
      public static var aUTs:Array = new Array();
      
      public static var aEnemies:Array = new Array();
      
      public static var aPlayers:Array = new Array();
      
      public static var aEqSets:Array = new Array();
      
      public static var aProjectiles:Array = new Array();
      
      public static var aObjectOld:Array = new Array();
      
      public function XmlData()
      {
         super();
      }
      
      public static function set SetData(param1:XML) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:* = false;
         _loc2_ = getTimer();
         var _loc4_:uint = uint(param1.Object.length());
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = uint(param1.Object[_loc5_].@type);
            _loc7_ = param1.Object[_loc5_].@id;
            aObject[_loc6_] = param1.Object[_loc5_];
            if(param1.Object[_loc5_].Class == "Equipment")
            {
               aEq.push(param1.Object[_loc5_]);
            }
            _loc8_ = true;
            if(!DPSCalculator.TESTING)
            {
               _loc8_ = !(param1.Object[_loc5_].AnimatedTexture == undefined && (param1.Object[_loc5_].Texture == undefined || param1.Object[_loc5_].Texture.File == "invisible" && param1.Object[_loc5_].AltTexture == undefined) && param1.Object[_loc5_].Portrait == undefined);
            }
            if(param1.Object[_loc5_].Enemy != undefined && _loc8_)
            {
               aEnemies.push(param1.Object[_loc5_]);
            }
            if(param1.Object[_loc5_].Class == "Player")
            {
               aPlayers.push(param1.Object[_loc5_]);
            }
            _loc5_++;
         }
         _loc3_ = getTimer();
         trace("DERP, " + (_loc3_ - _loc2_));
      }
      
      public static function SetEquipmentSets(param1:XML) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:* = 0;
         while(_loc2_ < param1.EquipmentSet.length())
         {
            _loc3_ = uint(param1.EquipmentSet[_loc2_].@type);
            aEqSets[_loc3_] = param1.EquipmentSet[_loc2_];
            _loc2_++;
         }
      }
      
      public static function EqById(param1:uint) : XML
      {
         return aObject[param1];
      }
      
      public static function ObjectByName(param1:String) : XML
      {
         var _loc4_:XML = null;
         var _loc2_:uint = aObject.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = aObject[_loc3_];
            if(_loc4_ != null)
            {
               if(String(_loc4_.@id) == param1)
               {
                  return _loc4_;
               }
            }
            _loc3_++;
         }
         throw new Error("Object not found: " + param1);
      }
      
      public static function GeneralTrace(param1:*) : void
      {
         trace(int(param1.@type) + "\t" + param1.@type + "\t" + param1.@id + "\t" + param1.Class + "\t" + "");
      }
      
      public static function ListDroppers(param1:XML) : void
      {
         var _loc7_:XML = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:String = null;
         var _loc16_:* = null;
         var _loc2_:String = param1.@id;
         var _loc3_:* = "";
         _loc3_ += "=image(\"" + "http://static.drips.pw/rotmg/wiki/Untiered/";
         _loc3_ += escape(_loc2_);
         _loc3_ += ".png" + "\")";
         _loc3_ += "\t";
         _loc3_ += param1.@id + "\t";
         _loc3_ += int(param1.@type) + "\t";
         _loc3_ += param1.@type + "\t";
         var _loc4_:uint = 0;
         var _loc5_:uint = aEnemies.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = aEnemies[_loc6_];
            if(_loc7_ != null)
            {
               if(_loc7_.SoulboundLoot != undefined)
               {
                  _loc8_ = uint(_loc7_.SoulboundLoot.length());
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_)
                  {
                     _loc10_ = _loc7_.SoulboundLoot[_loc9_];
                     _loc11_ = Number(_loc7_.SoulboundLoot[_loc9_].@prob);
                     _loc12_ = Number(_loc7_.SoulboundLoot[_loc9_].@threshold);
                     _loc13_ = Number(_loc7_.SoulboundLoot[_loc9_].@min);
                     _loc14_ = Number(_loc7_.SoulboundLoot[_loc9_].@max);
                     if(_loc10_ == _loc2_)
                     {
                        _loc15_ = _loc7_.@id;
                        _loc16_ = "";
                        _loc16_ = _loc16_ + ("=image(\"" + "http://static.drips.pw/rotmg/wiki/Enemies/");
                        _loc16_ = _loc16_ + escape(_loc15_);
                        _loc16_ = _loc16_ + (".png" + "\")");
                        _loc16_ = _loc16_ + "\t";
                        _loc16_ = _loc16_ + (_loc15_ + "\t");
                        _loc16_ = _loc16_ + (_loc11_ + "\t");
                        _loc16_ = _loc16_ + (_loc12_ + "\t");
                        _loc16_ = _loc16_ + (_loc13_ + "\t");
                        _loc16_ = _loc16_ + _loc14_;
                        if(_loc4_ == 0)
                        {
                           trace(_loc3_ + _loc16_);
                        }
                        else
                        {
                           trace("\t" + _loc10_ + "\t\t\t" + _loc16_);
                        }
                        _loc4_++;
                     }
                     _loc9_++;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public static function ListDungeonDroppers(param1:XML) : void
      {
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         var _loc13_:String = null;
         var _loc14_:* = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:* = undefined;
         var _loc2_:String = param1.@id;
         var _loc3_:* = "";
         _loc3_ += "=image(\"" + "http://static.drips.pw/rotmg/wiki/_type/";
         _loc3_ += uint(param1.@type);
         _loc3_ += ".png" + "\")";
         _loc3_ += "\t";
         _loc3_ += param1.@id + "\t";
         var _loc4_:uint = 0;
         var _loc5_:uint = aObject.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = aObject[_loc6_];
            if(_loc7_ != null)
            {
               _loc8_ = _loc7_.@id;
               if(_loc7_.Behavior != undefined)
               {
                  _loc9_ = uint(_loc7_.Behavior.length());
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc7_.Behavior[_loc10_];
                     if(_loc11_ == "MetamorphoseAtDeath")
                     {
                        _loc12_ = Number(_loc7_.Behavior[_loc10_].@prob);
                        _loc13_ = _loc7_.Behavior[_loc10_].@childId;
                        if(_loc13_ == _loc2_)
                        {
                           _loc14_ = "";
                           _loc14_ = _loc14_ + ("=image(\"" + "http://static.drips.pw/rotmg/wiki/Enemies/");
                           _loc14_ = _loc14_ + escape(_loc8_);
                           _loc14_ = _loc14_ + (".png" + "\")");
                           _loc14_ = _loc14_ + "\t";
                           _loc14_ = _loc14_ + (_loc8_ + "\t");
                           _loc14_ = _loc14_ + _loc12_;
                           if(_loc4_ == 0)
                           {
                              trace(_loc3_ + _loc14_);
                           }
                           else
                           {
                              trace("\t" + _loc13_ + "\t" + _loc14_);
                           }
                           _loc4_++;
                        }
                     }
                     _loc10_++;
                  }
               }
               if(_loc7_.State != undefined)
               {
                  _loc15_ = uint(_loc7_.State.length());
                  _loc16_ = 0;
                  while(_loc16_ < _loc15_)
                  {
                     _loc9_ = uint(_loc7_.State[_loc16_].Behavior.length());
                     _loc10_ = 0;
                     while(_loc10_ < _loc9_)
                     {
                        _loc11_ = _loc17_ = _loc7_.State[_loc16_].Behavior[_loc10_];
                        if(_loc11_ == "MetamorphoseAtDeath")
                        {
                           _loc12_ = Number(_loc17_.@prob);
                           _loc13_ = _loc17_.@childId;
                           if(_loc13_ == _loc2_)
                           {
                              _loc14_ = "";
                              _loc14_ = _loc14_ + ("=image(\"" + "http://static.drips.pw/rotmg/wiki/Enemies/");
                              _loc14_ = _loc14_ + escape(_loc8_);
                              _loc14_ = _loc14_ + (".png" + "\")");
                              _loc14_ = _loc14_ + "\t";
                              _loc14_ = _loc14_ + (_loc8_ + "\t");
                              _loc14_ = _loc14_ + _loc12_;
                              if(_loc4_ == 0)
                              {
                                 trace(_loc3_ + _loc14_);
                              }
                              else
                              {
                                 trace("\t" + _loc13_ + "\t" + _loc14_);
                              }
                              _loc4_++;
                           }
                        }
                        _loc10_++;
                     }
                     _loc16_++;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public static function ListDungeons() : void
      {
         var _loc3_:XML = null;
         var _loc4_:uint = 0;
         trace("Sprite" + "\t" + "Identifier" + "\t" + "Sprite" + "\t" + "Identifier" + "\t" + "Prob");
         var _loc1_:uint = aObject.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = aObject[_loc2_];
            if(_loc3_ != null)
            {
               _loc4_ = uint(aObject[_loc2_].@type);
               if(_loc3_.Class == "Portal" && _loc3_.@id != "Realm Portal")
               {
                  ListDungeonDroppers(aObject[_loc2_]);
               }
            }
            _loc2_++;
         }
      }
      
      public static function SetListUT() : void
      {
         var _loc3_:XML = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:uint = 0;
         var _loc8_:* = false;
         var _loc9_:* = false;
         trace("Sprite" + "\t" + "Identifier" + "\t" + "Int" + "\t" + "Hex" + "\t" + "Sprite" + "\t" + "Identifier" + "\t" + "Prob" + "\t" + "Thresh" + "\t" + "Min" + "\t" + "Max");
         var _loc1_:uint = aObject.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = aObject[_loc2_];
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.Tier != undefined;
               _loc5_ = _loc3_.Item != undefined;
               _loc6_ = _loc3_.Consumable != undefined;
               _loc7_ = uint(aObject[_loc2_].@type);
               _loc8_ = _loc7_ < 65285;
               _loc9_ = _loc3_.Soulbound != undefined;
               if(_loc3_.Class == "Equipment" && !_loc4_ && _loc5_ && !_loc6_ && _loc8_ && _loc9_)
               {
                  ListDroppers(aObject[_loc2_]);
               }
            }
            _loc2_++;
         }
      }
      
      public static function ObjectByTexture(param1:String) : XML
      {
         var _loc4_:XML = null;
         var _loc2_:uint = aEq.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = aEq[_loc3_];
            if(_loc4_ != null)
            {
               if(String(_loc4_.Texture) == param1)
               {
                  return _loc4_;
               }
            }
            _loc3_++;
         }
         throw new Error("Texture not found:\n" + param1);
      }
      
      public static function ObjectById(param1:uint) : XML
      {
         return aObject[param1];
      }
   }
}


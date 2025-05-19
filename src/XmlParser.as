package
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class XmlParser extends EventDispatcher
   {
      private static const RUNS_PER_FRAME:uint = 100;
      
      private var m_i:Number;
      
      private var m_iTotalRuns:Number;
      
      private var m_Xml:XML;
      
      private var m_aFileredIDs:Array;
      
      private var m_aFileredItems:Array;
      
      private var m_aFileredProjs:Array;
      
      private var aXML:Vector.<XML> = new Vector.<XML>();
      
      private var aCompareXML:Vector.<XML> = new Vector.<XML>();
      
      private var bCompare:Boolean = false;
      
      public function XmlParser(param1:XML)
      {
         super();
         var _loc2_:String = param1.Filter;
         this.m_aFileredIDs = _loc2_.split(",");
         var _loc3_:String = param1.ItemFilter;
         this.m_aFileredItems = _loc3_.split(",");
         var _loc4_:String = param1.ProjFilter;
         this.m_aFileredProjs = _loc4_.split(",");
      }
      
      public function AddXML(param1:XML) : void
      {
         this.aXML.push(param1);
      }
      
      public function AddCompareXML(param1:XML) : void
      {
         this.aCompareXML.push(param1);
      }
      
      private function StartNextXML() : void
      {
         this.m_i = 0;
         this.m_iTotalRuns = this.aXML[0].Object.length();
      }
      
      public function StartParsing() : void
      {
         this.StartNextXML();
         GameTime.getInstance().addEventListener(WorldEvent.STEP,this.Step);
      }
      
      public function Step(param1:Event) : void
      {
         var _loc4_:XML = null;
         var _loc5_:uint = 0;
         var _loc6_:* = false;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc2_:uint = Math.min(this.m_i + RUNS_PER_FRAME,this.m_iTotalRuns);
         var _loc3_:* = this.m_i;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.aXML[0].Object[_loc3_];
            _loc5_ = uint(_loc4_.@type);
            if(this.bCompare)
            {
               XmlData.aObjectOld[uint(_loc4_.@type)] = _loc4_;
            }
            else if(_loc4_.Enemy != undefined)
            {
               _loc6_ = true;
               if(!DPSCalculator.TESTING)
               {
                  _loc6_ = !(_loc4_.AnimatedTexture == undefined && (_loc4_.Texture == undefined || _loc4_.Texture.File == "invisible" && _loc4_.AltTexture == undefined) && _loc4_.Portrait == undefined);
               }
               if(_loc6_)
               {
                  _loc7_ = true;
                  if(!DPSCalculator.TESTING)
                  {
                     _loc8_ = this.m_aFileredIDs.length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_)
                     {
                        if(this.m_aFileredIDs[_loc9_] == uint(_loc4_.@type))
                        {
                           _loc7_ = false;
                           break;
                        }
                        _loc9_++;
                     }
                  }
                  if(_loc7_)
                  {
                     XmlData.aEnemies.push(_loc4_);
                     XmlData.aObject[uint(_loc4_.@type)] = _loc4_;
                  }
               }
            }
            else if(_loc4_.Consumable == undefined)
            {
               if(_loc4_.Class == "Equipment")
               {
                  _loc7_ = true;
                  if(!DPSCalculator.TESTING)
                  {
                     _loc8_ = this.m_aFileredItems.length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_)
                     {
                        if(this.m_aFileredItems[_loc9_] == uint(_loc4_.@type))
                        {
                           _loc7_ = false;
                           break;
                        }
                        _loc9_++;
                     }
                  }
                  if(_loc7_)
                  {
                     XmlData.aEq.push(_loc4_);
                     XmlData.aObject[uint(_loc4_.@type)] = _loc4_;
                  }
               }
               else if(_loc4_.Class == "Player")
               {
                  XmlData.aPlayers.push(_loc4_);
                  XmlData.aObject[uint(_loc4_.@type)] = _loc4_;
               }
               else if(_loc4_.Class == "Projectile" || _loc4_.Class == "Container")
               {
                  _loc7_ = true;
                  if(!DPSCalculator.TESTING)
                  {
                     _loc8_ = this.m_aFileredProjs.length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_)
                     {
                        if(this.m_aFileredProjs[_loc9_] == uint(_loc4_.@type))
                        {
                           _loc7_ = false;
                           break;
                        }
                        _loc9_++;
                     }
                  }
                  if(_loc7_)
                  {
                     if(_loc4_.Class == "Projectile")
                     {
                        XmlData.aProjectiles.push(_loc4_);
                     }
                     XmlData.aObject[uint(_loc4_.@type)] = _loc4_;
                  }
               }
               else if(_loc4_.Class == "Skin")
               {
                  XmlData.aObject[uint(_loc4_.@type)] = _loc4_;
               }
            }
            _loc3_++;
         }
         if(_loc2_ == this.m_iTotalRuns)
         {
            this.aXML.shift();
            if(this.aXML.length)
            {
               this.StartNextXML();
            }
            else
            {
               GameTime.getInstance().removeEventListener(WorldEvent.STEP,this.Step);
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
         else
         {
            this.m_i += RUNS_PER_FRAME;
         }
      }
   }
}


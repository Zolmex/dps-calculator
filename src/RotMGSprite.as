package
{
   import br.com.stimuli.loading.BulkLoader;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RotMGSprite extends Sprite
   {
      public function RotMGSprite(param1:XML, param2:Number = 4)
      {
         super();
         var _loc3_:Sprite = this.getTexSprite(param1,param2);
         addChild(_loc3_);
      }
      
      private function getTexSprite(param1:XML, param2:Number) : Sprite
      {
         var _loc3_:XMLList = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Sprite = null;
         var _loc6_:Boolean = false;
         var _loc7_:BulkLoader = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         if(param1.AnimatedTexture != undefined)
         {
            _loc3_ = param1.AnimatedTexture;
         }
         else if(param1.Portrait != undefined)
         {
            _loc3_ = param1.Portrait.AnimatedTexture;
         }
         else if(param1.RandomTexture != undefined)
         {
            _loc3_ = XMLList(param1.RandomTexture.Texture[0]);
         }
         else if(param1.Texture != undefined || param1.AltTexture[0] != undefined)
         {
            _loc6_ = param1.Texture == undefined || param1.Texture.File == "invisible";
            if((_loc6_) && param1.AltTexture[0] != undefined)
            {
               if(param1.AltTexture[0].Texture != undefined)
               {
                  _loc3_ = param1.AltTexture[0].Texture;
               }
               else if(param1.AltTexture[0].AnimatedTexture != undefined)
               {
                  _loc3_ = param1.AltTexture[0].AnimatedTexture;
               }
            }
            else
            {
               _loc3_ = param1.Texture;
            }
         }
         else
         {
            _loc3_ = Constants.ART;
         }
         if(param1.AltTexture[0] != undefined)
         {
            _loc7_ = BulkLoader.getLoader("main");
            _loc8_ = _loc7_.getXML("sorting_xml").ShowAltTexture;
            _loc9_ = _loc8_.split(",");
            _loc10_ = _loc9_.length;
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               if(_loc9_[_loc11_] == uint(param1.@type))
               {
                  _loc3_ = param1.AltTexture[0].Texture;
                  break;
               }
               _loc11_++;
            }
         }
         if(_loc3_ == undefined || _loc3_ == null || _loc3_.File == "invisible")
         {
            _loc3_ = Constants.ART;
         }
         if(param1.RemoteTexture != undefined)
         {
            _loc4_ = SpriteParser.GetSprite(param1.RemoteTexture.Id,0);
         }
         else
         {
            _loc4_ = SpriteParser.GetSprite(_loc3_.File,_loc3_.Index);
         }
         _loc5_ = new Sprite();
         _loc5_.addChild(_loc4_);
         _loc5_.scaleX = _loc5_.scaleY = param2;
         return _loc5_;
      }
   }
}


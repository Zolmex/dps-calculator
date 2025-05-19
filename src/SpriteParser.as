package
{
   import br.com.stimuli.loading.BulkLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SpriteParser
   {
      private static var m_BL:BulkLoader;
      
      private static var iSize:uint = 8;
      
      private static var iColumns:uint = 16;
      
      public function SpriteParser()
      {
         super();
      }
      
      public static function Initialize() : void
      {
         m_BL = BulkLoader.getLoader("main");
      }
      
      private static function GetFile(param1:String) : BitmapData
      {
         if(param1 == "lofiChar8x8" || param1 == "lofiChar28x8")
         {
            param1 = param1.substr(0,param1.length - 3);
         }
         if(param1 == "lofiChar216x16" || param1 == "lofiChar16x16")
         {
            param1 = param1.substr(0,param1.length - 5);
         }
         if(param1 == "lofiChar216x8" || param1 == "lofiChar16x8")
         {
            param1 = param1.substr(0,param1.length - 4);
         }
         if(param1 == "d3LofiObjEmbed16")
         {
            param1 = param1.substr(0,param1.length - 2);
         }
         if(param1 == "d2LofiObjBigEmbed")
         {
            param1 = "d2LofiObjEmbed";
         }
         if(param1 == "lofiObj5new")
         {
            param1 = "lofiObj5b";
         }
         return m_BL.getBitmapData(param1 + "_png");
      }
      
      private static function GetDimensions(param1:String, param2:Point) : Point
      {
         if(param1 == "lofiChar216x16" || param1 == "lofiChar16x16")
         {
            param2 = new Point(16,16);
         }
         if(param1 == "d3LofiObjEmbed16" || param1 == "d2LofiObjBigEmbed")
         {
            param2 = new Point(16,16);
         }
         if(param1 == "lofiChar216x8" || param1 == "lofiChar16x8" || param1 == "chars16x8dEncounters")
         {
            param2 = new Point(16,8);
         }
         return param2;
      }
      
      public static function GetSprite(param1:String, param2:uint = 0) : Bitmap
      {
         var iSkip:uint = 0;
         var iC:* = undefined;
         var rectangle:Rectangle = null;
         var bData:BitmapData = null;
         var bm:Bitmap = null;
         var _sFile:String = param1;
         var _iIndex:uint = param2;
         var bmSourceData:BitmapData = GetFile(_sFile);
         var w:uint = uint(bmSourceData.width);
         var h:uint = uint(bmSourceData.height);
         var iS:Point = new Point(0,0);
         if(w / 7 == 8)
         {
            iS.x = iS.y = 8;
            iSkip = 7;
         }
         else if(w / 7 == 16)
         {
            iS.x = iS.y = 16;
            iSkip = 7;
         }
         else if(w < 8 * 8)
         {
            iS.x = iS.y = w;
            iSkip = 1;
         }
         else
         {
            iS.x = iS.y = w / 16;
            iSkip = 1;
         }
         if(_sFile == "art" || _sFile == "invisible")
         {
            trace("NOPE: " + _sFile);
            iS.x = iS.y = 8;
            iSkip = 1;
         }
         if(_sFile == "players" || _sFile == "playerskins16")
         {
            iSkip *= 3;
         }
         iS = GetDimensions(_sFile,iS);
         iC = w / iS.x;
         rectangle = new Rectangle(_iIndex * iSkip % iC * iS.x,uint(_iIndex * iSkip / iC) * iS.y,iS.x,iS.y);
         try
         {
            bData = new BitmapData(iS.x,iS.y,true,0);
            bData.copyPixels(bmSourceData,rectangle,new Point(0,0));
            bm = new Bitmap(bData);
            if(iS.x > 8)
            {
               bm.scaleX = bm.scaleY = 0.5;
            }
         }
         catch(err:Error)
         {
            trace("File: " + _sFile + " Index: " + _iIndex);
            trace("Package error - " + err.message);
         }
         return bm;
      }
      
      public static function GetSpriteSheet(param1:String, param2:uint = 0, param3:uint = 1) : BitmapData
      {
         var _loc4_:BitmapData = GetFile(param1);
         var _loc5_:uint = _loc4_.width / 7;
         var _loc6_:Rectangle = new Rectangle(0,uint(param2) * _loc5_,_loc5_ * param3,_loc5_);
         var _loc7_:BitmapData = new BitmapData(_loc5_ * param3,_loc5_,true,0);
         _loc7_.copyPixels(_loc4_,_loc6_,new Point(0,0));
         var _loc8_:Bitmap = new Bitmap(_loc7_);
         return _loc8_.bitmapData;
      }
      
      public static function GetAttackIcon() : Bitmap
      {
         var _loc1_:BitmapData = GetFile("lofiInterface2");
         var _loc2_:Rectangle = new Rectangle(8,24,8,8);
         var _loc3_:BitmapData = new BitmapData(8,8,true,0);
         _loc3_.copyPixels(_loc1_,_loc2_,new Point(0,0));
         return new Bitmap(_loc3_);
      }
   }
}


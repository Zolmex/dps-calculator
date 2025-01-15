package
{
   import com.pfiffel.util.MathUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SimpleSprite extends Sprite
   {
      public function SimpleSprite(param1:XML)
      {
         var _loc3_:* = undefined;
         var _loc4_:Bitmap = null;
         var _loc5_:XMLList = null;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         super();
         var _loc2_:Sprite = new Sprite();
         if(param1.RandomTexture != undefined)
         {
            _loc5_ = param1.RandomTexture.children();
            _loc6_ = _loc5_.length() - 1;
            _loc7_ = MathUtil.RangeRound(0,_loc6_);
            _loc3_ = _loc5_[_loc7_];
         }
         else if(param1.Texture == undefined)
         {
            _loc3_ = Constants.ART;
         }
         else
         {
            _loc3_ = param1.Texture;
         }
         if(_loc3_ == undefined || _loc3_ == null || _loc3_.File == "invisible")
         {
            _loc3_ = Constants.ART;
         }
         _loc4_ = SpriteParser.GetSprite(_loc3_.File,_loc3_.Index);
         _loc2_.addChild(_loc4_);
         _loc4_.x = -_loc4_.width / 2;
         _loc4_.y = -_loc4_.height / 2;
         if(param1.AngleCorrection != undefined)
         {
            _loc2_.rotation = Number(param1.AngleCorrection) * 45;
         }
         addChild(_loc2_);
      }
   }
}


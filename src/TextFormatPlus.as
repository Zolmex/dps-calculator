package
{
   import flash.text.TextFormat;
   
   public class TextFormatPlus extends TextFormat
   {
      public function TextFormatPlus(param1:String = null, param2:Object = null, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:String = null, param8:String = null, param9:String = null, param10:Object = null, param11:Object = null, param12:Object = null, param13:Object = null)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      public function Clone() : TextFormatPlus
      {
         return new TextFormatPlus(font,size,color,bold,italic,underline,url,target,align,leftMargin,rightMargin,indent,leading);
      }
   }
}


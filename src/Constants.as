package
{
   import flash.filters.GlowFilter;
   import flash.text.TextFormatAlign;
   
   public class Constants
   {
      public static const aTOPS:* = [2809,2812,2821,2818,2815,2806,2824,2827,2850,2851,2852,2853,2854,2855,2856,2857,2858,2859,2860,2861,2867,3152,3161];
      
      public static const aUTS:* = [2879,2976,2977,2978,3073,3074,3075,3076,3077,3078,3079,3080,3081,3082,3083,3087,3088,3102,3113,3114,3120,3121,3122,3123,3169,3181,3182];
      
      public static const aGRAVESTONES:* = [1827,1828,1829,1830,1831,1832,1833,1834,1835,1844,1845];
      
      public static const aDUNGEONS:* = [1815,1817,1843,1816,1804,1818,1849,1819,1840,1836,2354];
      
      public static const GLOW_BLACK_OBJECT:GlowFilter = new GlowFilter(0,1,12,12,0.75,1);
      
      public static const BLACK_OUTLINE:GlowFilter = new GlowFilter(0,0.8,2,2,255,1);
      
      public static const BLACK_OUTLINE_PURE:GlowFilter = new GlowFilter(0,1,2,2,255,1);
      
      public static const LIFE_OUTLINE:GlowFilter = new GlowFilter(uint("0x" + Stat.COLORS[0]),0.8,2,2,255,1);
      
      public static const BLACK_GLOW_DEFAULT:GlowFilter = new GlowFilter(0,1,4,4,2,1);
      
      public static const BLACK_GLOW_ITEM:GlowFilter = new GlowFilter(0,0.5,4,4,1,1);
      
      public static const GLOW_BLACK_TOOLTIP:GlowFilter = new GlowFilter(0,1,16,16,1,1);
      
      public static const GLOW_BLACK_TT_CONTENT:GlowFilter = new GlowFilter(0,0.5,8,8,1,1);
      
      public static const GLOW_BLACK_CHARCOMP_TEXT:GlowFilter = new GlowFilter(0,1,4,4,1,1);
      
      public static const TEXT_FORMAT_TNR:TextFormatPlus = new TextFormatPlus("Times New Roman",10,0);
      
      public static const TEXT_FORMAT_CHARCOMP_STAT:TextFormatPlus = new TextFormatPlus("Open Sans",9,16777215);
      
      public static const TEXT_FORMAT_GRAPH_RIGHT:TextFormatPlus = new TextFormatPlus("Open Sans",9,16777215,false,false,false,null,null,TextFormatAlign.RIGHT);
      
      public static const TEXT_FORMAT_GRAPH_CENTER:TextFormatPlus = new TextFormatPlus("Open Sans",9,16777215,false,false,false,null,null,TextFormatAlign.CENTER);
      
      public static const TEXT_FORMAT_BLACK:TextFormatPlus = new TextFormatPlus("Open Sans",13,0,true);
      
      public static const TEXT_FORMAT_BLACK_BIG:TextFormatPlus = new TextFormatPlus("Open Sans",17,0,true);
      
      public static const TEXT_FORMAT_BLACK_BOTTOM:TextFormatPlus = new TextFormatPlus("Open Sans",11,0,true,null,null,null,null,null,3);
      
      public static const TEXT_FORMAT_BLACK_MAIN:TextFormatPlus = new TextFormatPlus("Open Sans",9,0,true);
      
      public static const TEXT_FORMAT_BLACK_SMALL:TextFormatPlus = new TextFormatPlus("Open Sans",9,0,true);
      
      public static const TEXT_FORMAT_WHITE:TextFormatPlus = new TextFormatPlus("Open Sans",13,16777215);
      
      public static const TEXT_FORMAT_WHITE_MAIN:TextFormatPlus = new TextFormatPlus("Open Sans",11,16777215);
      
      public static const TEXT_FORMAT_WHITE_SMALL:TextFormatPlus = new TextFormatPlus("Open Sans",11,16777215);
      
      public static const TEXT_FORMAT_STATUS_EFFECT:TextFormatPlus = new TextFormatPlus("Open Sans",14,16777215,false);
      
      public static const TEXT_FORMAT_STATUS_EFFECT_RED:TextFormatPlus = new TextFormatPlus("Open Sans",14,14500932,false);
      
      public static const TEXT_FORMAT_NUM_ENEMIES:TextFormatPlus = new TextFormatPlus("Open Sans",11,16777215,false,false,false,null,null,TextFormatAlign.RIGHT);
      
      public static const TEXT_FORMAT_GOLD:TextFormatPlus = new TextFormatPlus("Open Sans",17,16762880);
      
      public static const TEXT_FORMAT_CYAN:TextFormatPlus = new TextFormatPlus("Open Sans",15,4259839);
      
      public static const TEXT_FORMAT_TT_DESC2:TextFormatPlus = new TextFormatPlus("Open Sans",11,12303291);
      
      public static const TEXT_FORMAT_TT_DESC_ID:TextFormatPlus = new TextFormatPlus("Open Sans",9,12303291);
      
      public static const TEXT_FORMAT_TT_DESC:TextFormatPlus = new TextFormatPlus("Open Sans",13,12303291);
      
      public static const TEXT_FORMAT_TT_DESC_HEADER:TextFormatPlus = new TextFormatPlus("Open Sans",14,12303291);
      
      public static const TEXT_FORMAT_TT_DESC_ATT:TextFormatPlus = new TextFormatPlus("Open Sans",11,12303291);
      
      public static const TEXT_FORMAT_TT_HEADER:TextFormatPlus = new TextFormatPlus("Open Sans",15,16777215,true);
      
      public static const TEXT_FORMAT_TT_HEADER_TIER:TextFormatPlus = new TextFormatPlus("Open Sans",15,16777215);
      
      public static const TEXT_FORMAT_TT_FAME_HEADER_TEXT:TextFormatPlus = new TextFormatPlus("Open Sans",15,12303291,true,false,false,null,null,TextFormatAlign.RIGHT);
      
      public static const TEXT_FORMAT_TT_FAME_HEADER_VAL:TextFormatPlus = new TextFormatPlus("Open Sans",15,16762880,true);
      
      public static const TEXT_FORMAT_TT_FAME_TEXT:TextFormatPlus = new TextFormatPlus("Open Sans",13,12303291,false,false,false,null,null,TextFormatAlign.RIGHT);
      
      public static const TEXT_FORMAT_TT_FAME_VAL:TextFormatPlus = new TextFormatPlus("Open Sans",13,16762880);
      
      public static const COLOR_STAT:String = "#FFFF88";
      
      public static const COLOR_WIS:String = "#4063e3";
      
      public static const COLOR_MAXED:String = "fcdf00";
      
      public static const COLOR_BONUS:String = "5eb531";
      
      public static const COLOR_MALUS:String = "ff3838";
      
      public static const DUN_PIRATE:uint = 0;
      
      public static const DUN_SPIDER:uint = 1;
      
      public static const DUN_JUNGLE:uint = 2;
      
      public static const DUN_SNAKE:uint = 3;
      
      public static const DUN_SPRITE:uint = 4;
      
      public static const DUN_UDL:uint = 5;
      
      public static const DUN_MANOR:uint = 6;
      
      public static const DUN_ABBY:uint = 7;
      
      public static const DUN_TRENCH:uint = 8;
      
      public static const DUN_TOMB:uint = 9;
      
      public static const ORYX_KILLS:uint = 10;
      
      public static const ART:XMLList = XMLList("<Texture><File>lofiObj3</File><Index>0xFF</Index></Texture>");
      
      public function Constants()
      {
         super();
      }
      
      public static function OldColor(param1:String) : String
      {
         return "<font color=\'#303030\'>" + param1 + "</font>";
      }
      
      public static function WisColor(param1:String) : String
      {
         return "<font color=\'" + COLOR_WIS + "\'>" + param1 + "</font>";
      }
      
      public static function Color(param1:String, param2:String) : String
      {
         return "<font color=\'#" + param2 + "\'>" + param1 + "</font>";
      }
   }
}


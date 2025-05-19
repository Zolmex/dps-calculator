package
{
   import br.com.stimuli.loading.BulkLoader;
   import com.adobe.serialization.json.JSON;
   import fl.controls.Button;
   import fl.controls.TextInput;
   import fl.events.ComponentEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class UIImportRE extends Sprite
   {
      private var m_BL:BulkLoader;
      
      private var m_tiName:TextInput;
      
      private var m_btnImport:Button;
      
      private var m_txtResult:TextField;
      
      private const API_PATH:String = "https://nightfirec.at/realmeye-api/?player=";
      
      private const API_PARAMS:String = "&data_vars=true&filter=characters+stats+mp+attack+dexterity+wisdom+class+equips+data_weapon_id+data_ability_id+data_armor_id+data_ring_id";
      
      public function UIImportRE()
      {
         super();
         var _loc1_:Sprite = new BackgroundTooltip();
         _loc1_.filters = [Constants.GLOW_BLACK_TOOLTIP];
         _loc1_.width = 203 + 8;
         _loc1_.height = 48 + 8;
         _loc1_.x = -4;
         _loc1_.y = -4;
         addChild(_loc1_);
         this.m_tiName = new TextInput();
         this.m_tiName.x = 0;
         this.m_tiName.y = 0;
         this.m_tiName.setSize(130,26);
         this.m_tiName.setStyle("embedFonts",true);
         this.m_tiName.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BIG);
         this.m_tiName.restrict = "a-zA-Z";
         this.m_tiName.maxChars = 11;
         this.m_tiName.addEventListener(ComponentEvent.ENTER,this.OnEnter);
         this.m_tiName.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         addChild(this.m_tiName);
         this.m_btnImport = new Button();
         this.m_btnImport.x = 134;
         this.m_btnImport.y = 0;
         this.m_btnImport.setSize(68,26);
         this.m_btnImport.label = "Import";
         this.m_btnImport.setStyle("embedFonts",true);
         this.m_btnImport.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BIG);
         this.m_btnImport.addEventListener(MouseEvent.CLICK,this.OnImport);
         this.m_btnImport.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         addChild(this.m_btnImport);
         this.m_txtResult = Tooltip.AddTextField(-2,28,210,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.m_txtResult.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         this.m_txtResult.htmlText = "Enter a player name.";
         addChild(this.m_txtResult);
      }
      
      private function Import() : void
      {
         var _loc1_:String = this.m_tiName.text;
         if(_loc1_ == "")
         {
            this.m_txtResult.htmlText = "Enter a player name.";
            return;
         }
         this.m_BL = BulkLoader.getLoader("main");
         this.m_BL.remove("realmeye_json");
         this.m_BL.add(this.API_PATH + _loc1_ + this.API_PARAMS,{
            "weight":20,
            "id":"realmeye_json"
         });
         this.m_BL.addEventListener(BulkLoader.COMPLETE,this.onRealmEyeLoaded);
         this.m_BL.start();
         this.m_txtResult.htmlText = "Loading...";
      }
      
      public function OnEnter(param1:ComponentEvent) : *
      {
         this.Import();
      }
      
      public function OnImport(param1:MouseEvent) : *
      {
         this.Import();
      }
      
      public function onRealmEyeLoaded(param1:Event) : void
      {
         this.m_BL.removeEventListener(BulkLoader.COMPLETE,this.onRealmEyeLoaded);
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(this.m_BL.getText("realmeye_json"));
         if(_loc2_.error != undefined)
         {
            this.m_txtResult.htmlText = "" + _loc2_.error;
         }
         else if(_loc2_.characters == "hidden")
         {
            this.m_txtResult.htmlText = this.m_tiName.text + "\'s characters are hidden!";
         }
         else
         {
            this.m_txtResult.htmlText = "Characters loaded.";
            dispatchEvent(new Event("Import"));
         }
      }
   }
}


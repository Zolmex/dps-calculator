package
{
   import br.com.stimuli.loading.BulkLoader;
   import br.com.stimuli.loading.BulkProgressEvent;
   import com.pfiffel.util.MathUtil;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.ColorPicker;
   import fl.controls.ComboBox;
   import fl.controls.NumericStepper;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.hires.debug.Stats;

[SWF(frameRate="60", backgroundColor="#333333", width="800", height="600")]
   public class DPSCalculator extends Sprite
   {
      public static const TESTING:Boolean = false;
      
      public static const LOCAL:Boolean = false;
      
      public static const ADDIONAL_CACHE_BUSTER:String = "";
      
      public static var COMPARE:Boolean = false;
      
      public var __rslLoaders:Object;
      
      private var sPathDefault:String = "http://pfiffel.bplaced.net/dps/";
      
      private var sPathTesting:String = "http://pfiffel.bplaced.net/dps/secret_testing/";
      
      private var m_aFilesXML:Vector.<String> = new Vector.<String>();
      
      private var m_BL:BulkLoader;
      
      private var mc_TooltipCont:Sprite = new Sprite();
      
      private var main:Sprite = new Sprite();
      
      private var m_loadUI:LoadUI;
      
      private var m_ColorPicker:ColorPicker = new ColorPicker();
      
      private var m_ClassPicker:ClassPicker = new ClassPicker(true);
      
      private var m_Overlay:Sprite = new Sprite();
      
      private var m_OverlayBG:Sprite = new Sprite();
      
      private var m_PickContainer:Sprite = new Sprite();
      
      private var m_aItemPickers:Vector.<ItemPicker> = new Vector.<ItemPicker>();
      
      private var m_CurrentItemPicker:ItemPicker;
      
      private var m_nsAtt:NumericStepper;
      
      private var m_nsDex:NumericStepper;
      
      private var m_nsWis:NumericStepper;
      
      private var m_nsDef:NumericStepper;
      
      private var m_nsPet:NumericStepper;
      
      private var m_cbPet:ComboBox;
      
      private var txt_AvgDamagePerHit:TextField;
      
      private var txt_HitsPerSecond:TextField;
      
      private var txt_BonusAtt:TextField;
      
      private var txt_BonusDex:TextField;
      
      private var txt_BonusWis:TextField;
      
      private var txt_BonusDef:TextField;
      
      private var defStuff:Sprite = new Sprite();
      
      private var txt_DamagePerSecond:TextField;
      
      private var bChooseMode:Boolean = false;
      
      private var m_Graph:Graph;
      
      private var m_CurrentComp:CharComposition;
      
      private var m_btnPreview:Button;
      
      private var m_btnEnemies:Button;
      
      private var m_btnGraph:Button;
      
      private var m_btnAdd:Button;
      
      private var txt_Add:TextField;
      
      private var txt_Graph:TextField;
      
      private var txt_Rand:TextField;
      
      private var txt_Enems:TextField;
      
      private var txt_WepPrev:TextField;
      
      private var m_btnRand:Button;
      
      private var m_btnRE:Button;
      
      private var m_cbDamaging:CheckBox;
      
      private var m_cbWeak:CheckBox;
      
      private var m_cbBerserk:CheckBox;
      
      private var m_cbDazed:CheckBox;
      
      private var m_cbCursed:CheckBox;
      
      private var m_cbArmored:CheckBox;
      
      private var m_cbDefense:CheckBox;
      
      private var m_cbCompare:CheckBox;
      
      private var m_cbMaxed:CheckBox;
      
      private var sprComp:Sprite;
      
      private var sprMaxe:Sprite;
      
      private var m_BulletPreview:BulletPreview;
      
      private var m_EnemyViewer:EnemyViewer;
      
      private var sPath:String;
      
      private var m_Date:Date = new Date();
      
      private var sAdd:String;// = "?" + this.m_Date.getMilliseconds();
      
      private var xmlParser:XmlParser;
      
      private var bSpritesLoaded:Boolean;
      
      private var bXmlParsed:Boolean;
      
      private var m_REImport:UIImportRE;
      
      private var m_StatMeter:Stats = new Stats();
      
      private var m_WepEdit:WeaponEditor;
      
      private var o:*;
      
      private var m_aWepRemoveBtns:Array = new Array();

      //compiler removes the classes if they're not referenced :/
      private static const _:Array = [
              BackgroundTooltip,
              Button_disabledSkin,
              Button_downSkin,
              Button_emphasizedSkin,
              Button_overSkin,
              Button_selectedDisabledSkin,
              Button_selectedDownSkin,
              Button_selectedOverSkin,
              Button_selectedUpSkin,
              Button_upSkin,
              CellRenderer_disabledSkin,
         CellRenderer_downSkin,
         CellRenderer_overSkin,
         CellRenderer_selectedDisabledSkin,
         CellRenderer_selectedDownSkin,
         CellRenderer_selectedOverSkin,
         CellRenderer_selectedUpSkin,
         CellRenderer_upSkin,
              CheckBox_disabledIcon,
         CheckBox_downIcon,
         CheckBox_overIcon,
         CheckBox_selectedDisabledIcon,
         CheckBox_selectedDownIcon,
         CheckBox_selectedOverIcon,
         CheckBox_selectedUpIcon,
         CheckBox_upIcon,
              ColorPicker_backgroundSkin,
         ColorPicker_colorWell,
         ColorPicker_disabledSkin,
         ColorPicker_downSkin,
         ColorPicker_overSkin,
         ColorPicker_swatchSelectedSkin,
         ColorPicker_swatchSkin,
         ColorPicker_textFieldSkin,
         ColorPicker_upSkin,
         ColorPicker_disabledSkin,
         ColorPicker_downSkin,
         ColorPicker_overSkin,
         ColorPicker_upSkin,
              ComboBox_disabledSkin,
              ComboBox_downSkin,
              ComboBox_overSkin,
              ComboBox_upSkin,
              Divider,
              focusRectSkin,
              gfxDivider,
         List_skin,
              MainFontBold,
              MainFontBoldItalic,
              MainFontItalic,
              MainFontRegular,

         NumericStepperDownArrow_disabledSkin,
         NumericStepperDownArrow_downSkin,
         NumericStepperDownArrow_overSkin,
         NumericStepperDownArrow_upSkin,
         NumericStepperUpArrow_disabledSkin,
         NumericStepperUpArrow_downSkin,
         NumericStepperUpArrow_overSkin,
         NumericStepperUpArrow_upSkin,

         ScrollArrowDown_disabledSkin,
         ScrollArrowDown_downSkin,
         ScrollArrowDown_overSkin,
         ScrollArrowDown_upSkin,

         ScrollArrowUp_disabledSkin,
         ScrollArrowUp_downSkin,
         ScrollArrowUp_overSkin,
         ScrollArrowUp_upSkin,

              ScrollBar_thumbIcon,
              ScrollPane_disabledSkin,
              ScrollPane_upSkin,
              ScrollThumb_downSkin,
              ScrollThumb_overSkin,
              ScrollThumb_upSkin,
              ScrollTrack_skin,
              TextInput_disabledSkin,
              TextInput_upSkin
      ];
      
      public function DPSCalculator()
      {
         sAdd = "?" + this.m_Date.getMilliseconds();
         super();
         if(!TESTING)
         {
            this.sPath = this.sPathDefault;
         }
         else
         {
            this.sPath = this.sPathTesting;
         }
         if(LOCAL)
         {
            this.sPath = "";
            this.sAdd = "";
         }
         addChild(this.main);
         this.m_loadUI = new LoadUI(4,14540253,8947848);
         this.m_loadUI.x = 400;
         this.m_loadUI.y = 250;
         addChild(this.m_loadUI);
         Security.loadPolicyFile("http://nightfirec.at/crossdomain.xml");
         this.m_BL = new BulkLoader("main");
         this.m_BL.add(this.sPath + "version.txt" + this.sAdd,{
            "weight":1,
            "id":"version_txt"
         });
         this.m_BL.add(this.sPath + "xml/_files_png.xml" + this.sAdd,{
            "weight":6,
            "id":"_files_png"
         });
         this.m_BL.add(this.sPath + "xml/_files_xml.xml" + this.sAdd,{
            "weight":6,
            "id":"_files_xml"
         });
         this.m_BL.add(this.sPath + "xml/_sorting.xml" + this.sAdd,{
            "weight":15,
            "id":"sorting_xml"
         });
         this.m_BL.add(this.sPath + "xml/_wepedit.xml" + this.sAdd,{
            "weight":3,
            "id":"wepedit_xml"
         });
         this.m_BL.addEventListener(BulkLoader.COMPLETE,this.onInitXML);
         this.m_BL.addEventListener(BulkLoader.PROGRESS,this.onInitXMLProgress);
         this.m_BL.start();
         addEventListener(Event.ADDED_TO_STAGE,this.onStage);
      }
      
      private function onStage(param1:Event) : void
      {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.OnKeyDown);
      }
      
      public function onInitXML(param1:Event) : void
      {
         var _loc5_:String = null;
         this.m_BL.removeEventListener(BulkLoader.COMPLETE,this.onInitXML);
         this.m_BL.removeEventListener(BulkLoader.PROGRESS,this.onInitXMLProgress);
         if(!LOCAL)
         {
            this.sAdd = "?" + this.m_BL.getText("version_txt");
         }
         if(ADDIONAL_CACHE_BUSTER != "")
         {
            this.sAdd += ADDIONAL_CACHE_BUSTER;
         }
         var _loc2_:XML = this.m_BL.getXML("_files_xml");
         var _loc3_:uint = uint(_loc2_.ObjectList.length());
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.ObjectList[_loc4_];
            this.m_aFilesXML.push(_loc5_);
            this.m_BL.add(this.sPath + "xml/" + _loc5_ + this.sAdd,{"id":_loc5_});
            _loc4_++;
         }
         this.m_BL.add(this.sPath + "xml/EquipmentSets.xml" + this.sAdd,{
            "weight":9,
            "id":"eq_sets_xml"
         });
         this.m_BL.add(this.sPath + "xml/_language.txt" + this.sAdd,{
            "weight":381,
            "id":"language_json"
         });
         if(TESTING)
         {
            this.m_BL.add(this.sPath + "xml/horror.xml" + this.sAdd,{
               "weight":8,
               "id":"horror_xml"
            });
         }
         this.m_BL.addEventListener(BulkLoader.COMPLETE,this.onAllItemsLoaded);
         this.m_BL.addEventListener(BulkLoader.PROGRESS,this.onAllItemsProgress);
      }
      
      public function onAllItemsLoaded(param1:Event) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:* = null;
         this.m_BL.removeEventListener(BulkLoader.COMPLETE,this.onAllItemsLoaded);
         this.m_BL.removeEventListener(BulkLoader.PROGRESS,this.onAllItemsProgress);
         this.bSpritesLoaded = false;
         this.bXmlParsed = false;
         GameTime.getInstance().Start(stage);
         Language.Init(this.m_BL.getText("language_json"));
         this.xmlParser = new XmlParser(this.m_BL.getXML("sorting_xml"));
         var _loc2_:uint = this.m_aFilesXML.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.xmlParser.AddXML(this.m_BL.getXML(this.m_aFilesXML[_loc3_]));
            _loc3_++;
         }
         if(TESTING)
         {
            this.xmlParser.AddXML(this.m_BL.getXML("horror_xml"));
         }
         this.xmlParser.StartParsing();
         this.xmlParser.addEventListener(Event.COMPLETE,this.onXmlParsed);
         XmlData.SetEquipmentSets(this.m_BL.getXML("eq_sets_xml"));
         this.m_loadUI.Reset();
         var _loc4_:XML = this.m_BL.getXML("_files_png");
         var _loc5_:uint = uint(_loc4_.Sheet.length());
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc4_.Sheet[_loc6_];
            _loc8_ = _loc7_.substr(0,_loc7_.length - 4);
            _loc9_ = "";
            if(_loc8_ == "d2LofiObj")
            {
               _loc9_ = "Embed";
            }
            if(_loc8_ == "d2Chars8x8r")
            {
               _loc9_ = "Embed";
            }
            if(_loc8_ == "d3LofiObj")
            {
               _loc9_ = "Embed";
            }
            if(_loc8_ == "d3Chars16x16r")
            {
               _loc9_ = "Embed";
            }
            if(_loc8_ == "d3Chars8x8r")
            {
               _loc9_ = "Embed";
            }
            if(_loc8_ == "playersSkins16")
            {
               _loc8_ = "playerskins16";
            }
            if(_loc8_ == "d1LofiObjBig")
            {
               _loc8_ = "d1lofiObjBig";
            }
            if(_loc8_ == "d1Chars16x16r")
            {
               _loc8_ = "d1chars16x16r";
            }
            _loc10_ = _loc8_ + _loc9_ + "_png";
            this.m_BL.add(this.sPath + "png/" + _loc7_ + this.sAdd,{"id":_loc10_});
            _loc6_++;
         }
         this.m_BL.addEventListener(BulkLoader.COMPLETE,this.onAllSpritesLoaded);
         this.m_BL.addEventListener(BulkLoader.PROGRESS,this.onAllSpritesProgress);
      }
      
      public function onInitXMLProgress(param1:BulkProgressEvent) : void
      {
         this.m_loadUI.Update(param1._percentLoaded,uint(param1.weightPercent * 100) + "%" + "\n" + "Initializing");
      }
      
      public function onAllItemsProgress(param1:BulkProgressEvent) : void
      {
         this.m_loadUI.Update(param1._percentLoaded,uint(param1.weightPercent * 100) + "%" + "\n" + "Loading Game Data");
      }
      
      public function onAllSpritesProgress(param1:BulkProgressEvent) : void
      {
         this.m_loadUI.Update(param1._ratioLoaded,uint(param1._ratioLoaded * 100) + "%" + "\n" + "Loading Sprites and Parsing Data");
      }
      
      public function onXmlParsed(param1:Event) : *
      {
         this.xmlParser.removeEventListener("XML Complete",this.onXmlParsed);
         this.bXmlParsed = true;
         this.onEverythingLoaded();
      }
      
      public function onAllSpritesLoaded(param1:Event) : void
      {
         this.m_BL.removeEventListener(BulkLoader.COMPLETE,this.onAllSpritesLoaded);
         this.m_BL.removeEventListener(BulkLoader.PROGRESS,this.onAllSpritesProgress);
         this.bSpritesLoaded = true;
         this.onEverythingLoaded();
      }
      
      private function onEverythingLoaded() : void
      {
         if(!(this.bXmlParsed && this.bSpritesLoaded))
         {
            return;
         }
         this.m_loadUI.Destroy();
         removeChild(this.m_loadUI);
         this.m_loadUI = null;
         SpriteParser.Initialize();
         this.Initialize();
      }
      
      private function OnKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.C:
               if(!(stage.focus is TextField))
               {
                  this.ToggleStats();
               }
         }
      }
      
      private function CreateCheckBox(param1:Number, param2:Number, param3:String, param4:Function, param5:TextFormatPlus, param6:Boolean = false) : CheckBox
      {
         var _loc7_:* = new CheckBox();
         _loc7_.label = param3;
         _loc7_.textField.autoSize = TextFieldAutoSize.LEFT;
         if(param6)
         {
            _loc7_.textField.antiAliasType = "advanced";
            _loc7_.textField.sharpness = 20;
            _loc7_.textField.thickness = 0;
         }
         _loc7_.setStyle("embedFonts",true);
         _loc7_.setStyle("textFormat",param5);
         _loc7_.addEventListener(MouseEvent.CLICK,param4);
         _loc7_.x = param1;
         _loc7_.y = param2;
         return _loc7_;
      }
      
      private function CreateNewIcon(param1:Number, param2:Number, param3:uint) : Bitmap
      {
         var _loc4_:Bitmap = SpriteParser.GetSprite("lofiInterface2",param3);
         _loc4_.x = param1;
         _loc4_.y = param2;
         _loc4_.filters = [Constants.BLACK_OUTLINE];
         return _loc4_;
      }
      
      private function Initialize() : void
      {
         var _loc27_:ItemPicker = null;
         CharCompCom.Main = this;
         this.m_Graph = new Graph(800,544);
         this.m_Graph.y = 56;
         this.m_Graph.x = 0;
         addChild(this.m_Graph);
         this.m_WepEdit = new WeaponEditor();
         this.m_WepEdit.addEventListener("update",this.OnWepUpdate);
         this.m_BulletPreview = new BulletPreview(stage,this.m_WepEdit);
         this.m_BulletPreview.x = 400 - 100;
         this.m_BulletPreview.y = 300 + 56 / 2;
         this.m_BulletPreview.visible = false;
         addChild(this.m_BulletPreview);
         this.m_EnemyViewer = new EnemyViewer(this);
         this.m_EnemyViewer.visible = false;
         addChild(this.m_EnemyViewer);
         this.m_EnemyViewer.ui.addChild(this.defStuff);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(3355443,1);
         _loc1_.graphics.drawRect(0,0,800,56);
         _loc1_.graphics.endFill();
         _loc1_.graphics.lineStyle(1,4210752,1);
         _loc1_.graphics.moveTo(0,56);
         _loc1_.graphics.lineTo(800,56);
         addChild(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         addChild(_loc2_);
         addChild(this.m_WepEdit);
         this.m_ClassPicker.addEventListener(MouseEvent.CLICK,this.OnClassPickerClick);
         _loc2_.addChild(this.m_ClassPicker);
         this.m_ClassPicker.x = this.m_ClassPicker.y = 4;
         this.m_ClassPicker.iClass = 0;
         var _loc3_:String = XmlData.aPlayers[0].SlotTypes;
         var _loc4_:Array = _loc3_.split(",");
         var _loc5_:* = 0;
         while(_loc5_ < 4)
         {
            _loc27_ = new ItemPicker();
            _loc27_.SetBackground();
            _loc27_.iSlotType = _loc4_[_loc5_];
            _loc27_.x = 60 + 44 * _loc5_;
            _loc27_.y = 8;
            _loc27_.addEventListener(MouseEvent.CLICK,this.OnItemPickerClick);
            _loc2_.addChild(_loc27_);
            this.m_aItemPickers[_loc5_] = _loc27_;
            _loc5_++;
         }
         this.m_PickContainer.x = 4;
         this.m_PickContainer.y = 60;
         var _loc6_:TextField = Tooltip.AddTextField(240,4 + 17 * 0 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         var _loc7_:TextField = Tooltip.AddTextField(240,4 + 17 * 1 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         var _loc8_:TextField = Tooltip.AddTextField(240,4 + 17 * 2 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         var _loc9_:TextField = Tooltip.AddTextField(240,4 + 17 * 3 - 3 + 6,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         var _loc10_:TextField = Tooltip.AddTextField(365,4 + 17 * 2 - 3,300,Constants.TEXT_FORMAT_WHITE_MAIN);
         _loc6_.htmlText = "<b>ATT:</b>";
         _loc2_.addChild(_loc6_);
         _loc7_.htmlText = "<b>DEX:</b>";
         _loc2_.addChild(_loc7_);
         _loc8_.htmlText = "<b>WIS:</b>";
         _loc2_.addChild(_loc8_);
         _loc9_.htmlText = "<b>DEF:</b>";
         this.defStuff.addChild(_loc9_);
         _loc10_.htmlText = "<b>MHeal:</b>";
         _loc2_.addChild(_loc10_);
         this.m_nsAtt = new NumericStepper();
         this.m_nsDex = new NumericStepper();
         this.m_nsWis = new NumericStepper();
         this.m_nsDef = new NumericStepper();
         this.m_nsAtt.setStyle("embedFonts",true);
         this.m_nsAtt.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_nsAtt.setStyle("textPadding",-2);
         this.m_nsDex.setStyle("embedFonts",true);
         this.m_nsDex.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_nsDex.setStyle("textPadding",-2);
         this.m_nsWis.setStyle("embedFonts",true);
         this.m_nsWis.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_nsWis.setStyle("textPadding",-2);
         this.m_nsDef.setStyle("embedFonts",true);
         this.m_nsDef.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_nsDef.setStyle("textPadding",-2);
         this.m_nsAtt.addEventListener(MouseEvent.CLICK,this.OnStatChange);
         this.m_nsDex.addEventListener(MouseEvent.CLICK,this.OnStatChange);
         this.m_nsWis.addEventListener(MouseEvent.CLICK,this.OnStatChange);
         this.m_nsDef.addEventListener(MouseEvent.CLICK,this.OnStatChange);
         this.m_nsAtt.move(280,4);
         this.m_nsDex.move(280,21);
         this.m_nsWis.move(280,38);
         this.m_nsDef.move(280,38 + 17 + 6);
         this.m_nsDef.maximum = this.m_nsWis.maximum = this.m_nsAtt.maximum = this.m_nsDex.maximum = 5000;
         this.m_nsDef.width = this.m_nsWis.width = this.m_nsAtt.width = this.m_nsDex.width = 48;
         this.m_nsDef.height = this.m_nsWis.height = this.m_nsDex.height = this.m_nsAtt.height = 15;
         this.txt_BonusAtt = Tooltip.AddTextField(320 + 2 + 10,4 + 17 * 0 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.txt_BonusDex = Tooltip.AddTextField(320 + 2 + 10,4 + 17 * 1 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.txt_BonusWis = Tooltip.AddTextField(320 + 2 + 10,4 + 17 * 2 - 3,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.txt_BonusDef = Tooltip.AddTextField(320 + 2 + 10,4 + 17 * 3 - 3 + 6,40,Constants.TEXT_FORMAT_WHITE_MAIN);
         _loc2_.addChild(this.txt_BonusAtt);
         _loc2_.addChild(this.txt_BonusDex);
         _loc2_.addChild(this.txt_BonusWis);
         this.defStuff.addChild(this.txt_BonusDef);
         this.txt_BonusAtt.mouseEnabled = true;
         this.txt_BonusDex.mouseEnabled = true;
         this.txt_BonusWis.mouseEnabled = true;
         this.txt_BonusDef.mouseEnabled = true;
         this.txt_BonusAtt.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.txt_BonusAtt.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.txt_BonusDex.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.txt_BonusDex.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.txt_BonusWis.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.txt_BonusWis.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.txt_BonusDef.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.txt_BonusDef.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbDefense = this.CreateCheckBox(0,0,"Calculate:",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         var _loc11_:Sprite = new Sprite();
         _loc11_.x = 160 + 10;
         _loc11_.y = 4 + 56;
         _loc11_.scaleX = _loc11_.scaleY = 0.75;
         _loc11_.addChild(this.m_cbDefense);
         this.m_EnemyViewer.ui.addChild(_loc11_);
         this.m_cbDefense.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbDefense.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbDefense.selected = true;
         this.m_cbDefense.addEventListener(MouseEvent.CLICK,this.OnDefCalcClick);
         var _loc12_:Bitmap = this.CreateNewIcon(355 + 22 + 10 - 4,-4 + 4 + 6,49);
         var _loc13_:Bitmap = this.CreateNewIcon(450 + 22 + 10 - 4,-4 + 4 + 6,34);
         var _loc14_:Bitmap = this.CreateNewIcon(355 + 22 + 10 - 4,-4 + 21 + 6,50);
         var _loc15_:Bitmap = this.CreateNewIcon(450 + 22 + 10 - 4,-4 + 21 + 6 + 1,44);
         var _loc16_:Bitmap = this.CreateNewIcon(355 + 22 + 10 - 4,4 + 56 + 4,16);
         var _loc17_:Bitmap = this.CreateNewIcon(450 + 22 + 10 - 4,-4 + 38 + 6 + 1,58);
         this.m_cbDamaging = this.CreateCheckBox(0,0,"    Damaging",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         this.m_cbWeak = this.CreateCheckBox(0,0,"    Weak",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         this.m_cbBerserk = this.CreateCheckBox(0,0,"    Berserk",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         this.m_cbDazed = this.CreateCheckBox(0,0,"    Dazed",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         this.m_cbArmored = this.CreateCheckBox(0,0,"    Armored",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         this.m_cbCursed = this.CreateCheckBox(0,0,"    Cursed",this.OnCheckBoxClick,Constants.TEXT_FORMAT_STATUS_EFFECT,true);
         var _loc18_:Sprite = new Sprite();
         _loc18_.x = 355 + 10;
         _loc18_.y = -2 + 4;
         _loc18_.scaleX = _loc18_.scaleY = 0.75;
         var _loc19_:Sprite = new Sprite();
         _loc19_.x = 450 + 10;
         _loc19_.y = -2 + 4;
         _loc19_.scaleX = _loc19_.scaleY = 0.75;
         var _loc20_:Sprite = new Sprite();
         _loc20_.x = 355 + 10;
         _loc20_.y = -2 + 21;
         _loc20_.scaleX = _loc20_.scaleY = 0.75;
         var _loc21_:Sprite = new Sprite();
         _loc21_.x = 450 + 10;
         _loc21_.y = -2 + 21;
         _loc21_.scaleX = _loc21_.scaleY = 0.75;
         var _loc22_:Sprite = new Sprite();
         _loc22_.x = 355 + 10;
         _loc22_.y = 4 + 56;
         _loc22_.scaleX = _loc22_.scaleY = 0.75;
         var _loc23_:Sprite = new Sprite();
         _loc23_.x = 450 + 10;
         _loc23_.y = -2 + 38;
         _loc23_.scaleX = _loc23_.scaleY = 0.75;
         _loc18_.addChild(this.m_cbDamaging);
         _loc19_.addChild(this.m_cbWeak);
         _loc20_.addChild(this.m_cbBerserk);
         _loc21_.addChild(this.m_cbDazed);
         _loc22_.addChild(this.m_cbArmored);
         _loc23_.addChild(this.m_cbCursed);
         _loc2_.addChild(_loc12_);
         _loc2_.addChild(_loc13_);
         _loc2_.addChild(_loc14_);
         _loc2_.addChild(_loc15_);
         _loc2_.addChild(_loc17_);
         this.defStuff.addChild(_loc16_);
         _loc2_.addChild(_loc18_);
         _loc2_.addChild(_loc19_);
         _loc2_.addChild(_loc20_);
         _loc2_.addChild(_loc21_);
         _loc2_.addChild(_loc23_);
         this.defStuff.addChild(_loc22_);
         _loc2_.addChild(this.m_nsAtt);
         _loc2_.addChild(this.m_nsDex);
         _loc2_.addChild(this.m_nsWis);
         this.defStuff.addChild(this.m_nsDef);
         this.m_cbPet = new ComboBox();
         this.m_cbPet.textField.setStyle("embedFonts",true);
         this.m_cbPet.textField.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_cbPet.textField.setStyle("textPadding",-5);
         this.m_cbPet.dropdownWidth = 58 - 9;
         this.m_cbPet.dropdown.setStyle("cellRenderer",CustomCellRenderer);
         this.m_cbPet.dropdown.rowHeight = 16;
         this.m_cbPet.rowCount = 7;
         this.m_cbPet.setSize(58 - 10,15);
         this.m_cbPet.x = 411;
         this.m_cbPet.y = 38;
         this.m_cbPet.addItem({
            "label":"0",
            "data":0
         });
         this.m_cbPet.addItem({
            "label":"1",
            "data":1
         });
         this.m_cbPet.addItem({
            "label":"30",
            "data":30
         });
         this.m_cbPet.addItem({
            "label":"50",
            "data":50
         });
         this.m_cbPet.addItem({
            "label":"70",
            "data":70
         });
         this.m_cbPet.addItem({
            "label":"90",
            "data":90
         });
         this.m_cbPet.addItem({
            "label":"100",
            "data":100
         });
         this.m_cbPet.addEventListener(Event.CHANGE,this.onPetLevelChange);
         this.m_cbPet.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbPet.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOver);
         this.m_cbPet.textField.y -= 10;
         this.m_cbPet.selectedIndex = 4;
         _loc2_.addChild(this.m_cbPet);
         this.m_cbDamaging.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbDamaging.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbWeak.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbWeak.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbBerserk.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbBerserk.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbDazed.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbDazed.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbArmored.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbArmored.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbCursed.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbCursed.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_ColorPicker.x = 4 + 12 + 595 + 90 + 8 - 5;
         this.m_ColorPicker.y = 8;
         this.m_ColorPicker.addEventListener("close",this.OnColorPickerClose);
         _loc2_.addChild(this.m_ColorPicker);
         this.m_ColorPicker.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_ColorPicker.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_ColorPicker.height = 21;
         this.m_ColorPicker.width = 30 - 4;
         this.m_btnRand = new Button();
         this.m_btnRand.x = 4 + 12 + 595 + 90 + 8 - 5;
         this.m_btnRand.y = 33;
         this.m_btnRand.setSize(26,16);
         this.m_btnRand.label = "";
         this.txt_Rand = UtilUI.CreateTextField(this.m_btnRand.x + 2,this.m_btnRand.y,58,Constants.TEXT_FORMAT_BLACK_SMALL);
         addChild(this.txt_Rand);
         this.txt_Rand.text = "Ran";
         this.m_btnRand.setStyle("embedFonts",true);
         this.m_btnRand.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_SMALL);
         this.m_btnRand.addEventListener(MouseEvent.CLICK,this.OnRandClick);
         _loc2_.addChild(this.m_btnRand);
         this.m_btnRand.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_btnRand.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_btnPreview = new Button();
         this.m_btnPreview.x = -4 + 800 - 160 - 8 - 100 + 5;
         this.m_btnPreview.y = 8 - 1;
         this.m_btnPreview.setSize(58,42);
         this.m_btnPreview.label = "";
         this.txt_WepPrev = UtilUI.CreateTextField(this.m_btnPreview.x + 1,this.m_btnPreview.y + 1,58,Constants.TEXT_FORMAT_BLACK);
         addChild(this.txt_WepPrev);
         this.txt_WepPrev.text = "Weapon\nPreview";
         this.m_btnPreview.setStyle("embedFonts",true);
         this.m_btnPreview.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnPreview.addEventListener(MouseEvent.CLICK,this.OnSwitch);
         _loc2_.addChild(this.m_btnPreview);
         this.m_btnEnemies = new Button();
         this.m_btnEnemies.x = 4 + 12 + 12 + 800 - 160 - 8 - 100 + 5 + 68 + 8;
         this.m_btnEnemies.y = 8 - 1;
         this.m_btnEnemies.setSize(56,42);
         this.m_btnEnemies.label = "";
         this.txt_Enems = UtilUI.CreateTextField(this.m_btnEnemies.x + 1 + 2,this.m_btnEnemies.y + 1,58,Constants.TEXT_FORMAT_BLACK);
         addChild(this.txt_Enems);
         this.txt_Enems.text = "Enemy\nViewer";
         this.m_btnEnemies.setStyle("embedFonts",true);
         this.m_btnEnemies.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnEnemies.addEventListener(MouseEvent.CLICK,this.OnSwitch);
         _loc2_.addChild(this.m_btnEnemies);
         this.m_btnAdd = new Button();
         this.m_btnAdd.x = 12 + 800 - 64 - 8 - 4;
         this.m_btnAdd.y = 8 - 1;
         this.m_btnAdd.setSize(56,42);
         this.m_btnAdd.label = "";
         this.txt_Add = UtilUI.CreateTextField(this.m_btnAdd.x + 1,this.m_btnAdd.y + 1,58,Constants.TEXT_FORMAT_BLACK);
         addChild(this.txt_Add);
         this.txt_Add.text = "Copy to\nGraph";
         this.m_btnAdd.setStyle("embedFonts",true);
         this.m_btnAdd.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnAdd.addEventListener(MouseEvent.CLICK,this.OnAddClick);
         _loc2_.addChild(this.m_btnAdd);
         this.m_btnGraph = new Button();
         this.m_btnGraph.x = 4 + 12 + 800 - 160 - 8 - 100 + 5 + 68 + 8 + 68 + 8;
         this.m_btnGraph.y = 8 - 1;
         this.m_btnGraph.setSize(103 - (4 + 12),42);
         this.m_btnGraph.label = "";
         this.txt_Graph = UtilUI.CreateTextField(this.m_btnGraph.x + 1 + 6,this.m_btnGraph.y + 1 + 8,103,Constants.TEXT_FORMAT_BLACK);
         addChild(this.txt_Graph);
         this.txt_Graph.text = "DPS Graph";
         this.m_btnGraph.setStyle("embedFonts",true);
         this.m_btnGraph.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnGraph.addEventListener(MouseEvent.CLICK,this.OnSwitch);
         this.m_btnGraph.visible = this.txt_Graph.visible = false;
         _loc2_.addChild(this.m_btnGraph);
         this.m_btnRE = new Button();
         this.m_btnRE.setStyle("embedFonts",true);
         this.m_btnRE.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_btnRE.y = 544 + 20 - 56 + 16;
         this.m_btnRE.x = 800 - 140 - 4 - 120 - 4;
         this.m_btnRE.setSize(120,16);
         this.m_btnRE.label = "";
         this.m_btnRE.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_btnRE.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_btnRE.addEventListener(MouseEvent.CLICK,this.OnRealmEyeClick);
         this.m_Graph.addChild(this.m_btnRE);
         var _loc24_:TextField = Tooltip.AddTextField(10 + 800 - 140 - 4 - 120 - 4,-1 + 544 + 20 - 56 + 16,0,Constants.TEXT_FORMAT_BLACK_BOTTOM);
         _loc24_.text = "RealmEye Import";
         this.m_Graph.addChild(_loc24_);
         var _loc25_:RotMGSprite = new RotMGSprite(XmlData.ObjectById(3421),2);
         _loc25_.y = 544 + 20 - 56 + 16;
         _loc25_.x = 800 - 140 - 4 - 120 - 4 - 8;
         _loc25_.filters = [Constants.BLACK_OUTLINE];
         this.m_Graph.addChild(_loc25_);
         this.m_REImport = new UIImportRE();
         this.m_REImport.addEventListener("Import",this.onRealmEyeLoaded);
         this.m_REImport.visible = false;
         this.m_Graph.addChild(this.m_REImport);
         this.m_REImport.x = 800 - 140 - 4 - 120 - 4 + (120 - 202);
         this.m_REImport.y = 544 + 20 - 56 + 16 - 52 - 6;
         addChild(this.m_Overlay);
         this.m_Overlay.addChild(this.m_OverlayBG);
         this.m_cbCompare = this.CreateCheckBox(0,0,"Compare with Build 24",this.OnCheckBoxCompare,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.sprComp = this.ScaleComponent(this.m_cbCompare,250,14,1.25,60);
         this.m_Overlay.addChild(this.sprComp);
         this.m_cbCompare.selected = COMPARE;
         this.m_OverlayBG.addEventListener(MouseEvent.CLICK,this.OnOverlayClick);
         this.m_cbMaxed = this.CreateCheckBox(0,0,"Maxed",this.OnDummy,Constants.TEXT_FORMAT_WHITE_MAIN);
         this.m_cbMaxed.selected = true;
         this.m_cbMaxed.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbMaxed.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbCompare.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbCompare.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.sprMaxe = this.ScaleComponent(this.m_cbMaxed,56 + 10,14,1.25,-30);
         this.m_Overlay.addChild(this.sprMaxe);
         this.sprComp.visible = false;
         Tooltip.SetContainer(stage,this.mc_TooltipCont);
         addChild(this.mc_TooltipCont);
         this.m_CurrentComp = new CharComposition(0,this.GetMax(0,"Attack"),this.GetMax(0,"Dexterity"),this.GetMax(0,"MpRegen"),this.GetMax(0,"Defense"),0,0,0,0,70,0,false);
         this.ClassChosen(0);
         var _loc26_:Sprite = new Sprite();
         _loc26_.graphics.beginFill(16777215,1);
         _loc26_.graphics.drawRect(0,0,800,600);
         _loc26_.graphics.drawRect(1,1,800 - 2,600 - 2);
         _loc26_.graphics.endFill();
         addChild(_loc26_);
      }
      
      private function ScaleComponent(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number) : Sprite
      {
         var _loc6_:Sprite = new Sprite();
         _loc6_.addChild(param1);
         _loc6_.x = param2;
         _loc6_.y = param3;
         param1.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc6_.scaleX = _loc6_.scaleY = param4;
         _loc6_.graphics.beginFill(2105376,1);
         _loc6_.graphics.lineStyle(2,3158064);
         _loc6_.graphics.drawRoundRect(0,0,param1.width + param5,param1.height,8,8);
         _loc6_.graphics.endFill();
         return _loc6_;
      }
      
      public function OnOverlayClick(param1:MouseEvent) : *
      {
         this.SetStatSteppers();
         this.Calculate();
         this.EndPicking();
      }
      
      public function OnClassPickerClick(param1:MouseEvent) : *
      {
         if(this.bChooseMode)
         {
            this.SetStatSteppers();
            this.Calculate();
            this.m_ClassPicker.item.ForceRedrawToolTip();
            return this.EndPicking();
         }
         this.ChooseClass(this.m_ClassPicker.iClass);
         this.m_Overlay.visible = true;
      }
      
      public function OnItemPickerClick(param1:MouseEvent) : *
      {
         if(this.bChooseMode)
         {
            return this.EndPicking();
         }
         this.m_CurrentItemPicker = ItemPicker(param1.currentTarget);
         this.ChooseItem(this.m_CurrentItemPicker);
         this.m_Overlay.visible = true;
      }
      
      public function GetComp() : CharComposition
      {
         return this.m_CurrentComp;
      }
      
      private function Calculate() : void
      {
         var _loc1_:uint = 0;
         _loc1_ += 16 * int(this.m_cbDamaging.selected);
         _loc1_ += 8 * int(this.m_cbWeak.selected);
         _loc1_ += 4 * int(this.m_cbBerserk.selected);
         _loc1_ += 2 * int(this.m_cbDazed.selected);
         _loc1_ += 1 * int(this.m_cbArmored.selected);
         this.m_CurrentComp.Update(this.m_ClassPicker.iClass,this.m_nsAtt.value,this.m_nsDex.value,this.m_nsWis.value,this.m_nsDef.value,this.m_aItemPickers[0].iItem,this.m_aItemPickers[1].iItem,this.m_aItemPickers[2].iItem,this.m_aItemPickers[3].iItem,this.m_cbPet.selectedItem.data,_loc1_,this.m_cbCursed.selected);
         this.m_CurrentComp.vStatsBase[Stat.HP] = this.GetStat(Stat.HP);
         this.m_CurrentComp.vStatsBase[Stat.MP] = this.GetStat(Stat.MP);
         this.m_CurrentComp.vStatsBase[Stat.SPD] = this.GetStat(Stat.SPD);
         this.m_CurrentComp.vStatsBase[Stat.VIT] = this.GetStat(Stat.VIT);
         this.UpdateAfterCalculate();
      }
      
      public function UpdateAfterCalculate() : void
      {
         if(this.m_aItemPickers[1].ContItem)
         {
            this.m_aItemPickers[1].ContItem.SetWis(this.m_CurrentComp.iStatTotal(Stat.WIS));
         }
         this.m_Graph.ChangeCurrentGraph(this.m_CurrentComp);
         this.m_BulletPreview.CheckForBulletChange(this.m_CurrentComp.sChangeBullet);
         this.txt_BonusAtt.htmlText = "<b>(" + StringUtil.AddPrefix(this.m_CurrentComp.iBonusAtt) + ")</b>";
         this.txt_BonusDex.htmlText = "<b>(" + StringUtil.AddPrefix(this.m_CurrentComp.iBonusDex) + ")</b>";
         this.txt_BonusWis.htmlText = "<b>(" + StringUtil.AddPrefix(this.m_CurrentComp.iBonusWis) + ")</b>";
         this.txt_BonusDef.htmlText = "<b>(" + StringUtil.AddPrefix(this.m_CurrentComp.iBonusDef) + ")</b>";
      }
      
      private function ChooseItem(param1:ItemPicker) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Boolean = this.InitPickerItem(param1);
         if(_loc2_)
         {
            this.bChooseMode = true;
            _loc3_ = param1.x;
            _loc4_ = param1.y;
            this.m_OverlayBG.graphics.beginFill(0,0.75);
            this.m_OverlayBG.graphics.drawRect(0,0,800,600);
            this.m_OverlayBG.graphics.lineStyle(2,16777113);
            this.m_OverlayBG.graphics.drawRoundRect(_loc3_,_loc4_,8 * 4 + 8,8 * 4 + 8,16,16);
            this.m_OverlayBG.graphics.endFill();
         }
         this.sprMaxe.visible = false;
      }
      
      private function ChooseClass(param1:uint) : *
      {
         this.bChooseMode = true;
         var _loc2_:Number = this.m_ClassPicker.x;
         var _loc3_:Number = this.m_ClassPicker.y;
         this.m_OverlayBG.graphics.beginFill(0,0.75);
         this.m_OverlayBG.graphics.drawRect(0,0,800,600);
         this.m_OverlayBG.graphics.lineStyle(2,16777113);
         this.m_OverlayBG.graphics.drawRoundRect(_loc2_,_loc3_,8 * 5 + 8,8 * 5 + 8,16,16);
         this.m_OverlayBG.graphics.endFill();
         this.InitPickerClass(param1);
         this.sprMaxe.visible = true;
      }
      
      private function ClassChosen(param1:uint) : *
      {
         var _loc8_:ItemPicker = null;
         this.m_ClassPicker.iClass = param1;
         var _loc2_:String = XmlData.aPlayers[param1].SlotTypes;
         var _loc3_:Array = _loc2_.split(",");
         var _loc4_:* = 0;
         while(_loc4_ < 4)
         {
            _loc8_ = this.m_aItemPickers[_loc4_];
            _loc8_.iSlotType = _loc3_[_loc4_];
            _loc8_.Reset();
            _loc4_++;
         }
         var _loc5_:String = XmlData.aPlayers[param1].Equipment;
         var _loc6_:uint = uint(_loc5_.split(",")[0]);
         var _loc7_:Weapon = new Weapon(XmlData.aObject[_loc6_]);
         this.m_aItemPickers[0].SetWep(_loc7_);
         this.SetStatSteppers();
         this.m_CurrentComp.SetWep(_loc7_);
         this.m_BulletPreview.Change(_loc6_);
         this.m_BulletPreview.ChangeAbil(-1);
         this.Calculate();
         this.EndPicking();
      }
      
      private function SetStatSteppers() : void
      {
         if(this.m_cbMaxed.selected)
         {
            this.m_nsAtt.value = this.GetMax(this.m_ClassPicker.iClass,"Attack");
            this.m_nsDex.value = this.GetMax(this.m_ClassPicker.iClass,"Dexterity");
            this.m_nsWis.value = this.GetMax(this.m_ClassPicker.iClass,"MpRegen");
            this.m_nsDef.value = this.GetMax(this.m_ClassPicker.iClass,"Defense");
         }
         else
         {
            this.m_nsAtt.value = this.GetRoll(this.m_ClassPicker.iClass,"Attack");
            this.m_nsDex.value = this.GetRoll(this.m_ClassPicker.iClass,"Dexterity");
            this.m_nsWis.value = this.GetRoll(this.m_ClassPicker.iClass,"MpRegen");
            this.m_nsDef.value = this.GetRoll(this.m_ClassPicker.iClass,"Defense");
         }
      }
      
      private function GetStat(param1:uint, param2:Boolean = true) : int
      {
         if(this.m_cbMaxed.selected)
         {
            return this.GetMax(this.m_ClassPicker.iClass,Stat.TYPES[param1]);
         }
         return this.GetRoll(this.m_ClassPicker.iClass,Stat.TYPES[param1]);
      }
      
      private function GetMax(param1:uint, param2:String) : int
      {
         var _loc3_:XML = XmlData.aPlayers[param1];
         return _loc3_[param2].@max;
      }
      
      private function GetRoll(param1:uint, param2:String) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:XML = null;
         var _loc11_:String = null;
         var _loc3_:XML = XmlData.aPlayers[param1];
         var _loc4_:Number = Number(_loc3_[param2]);
         var _loc7_:uint = uint(_loc3_.LevelIncrease.length());
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc11_ = _loc10_ = _loc3_.LevelIncrease[_loc8_];
            if(_loc11_ == param2)
            {
               _loc5_ = int(_loc10_.@min);
               _loc6_ = int(_loc10_.@max);
               break;
            }
            _loc8_++;
         }
         var _loc9_:* = 0;
         while(_loc9_ < 19)
         {
            _loc4_ += MathUtil.RangeRound(_loc5_,_loc6_);
            _loc9_++;
         }
         return int(_loc4_);
      }
      
      private function EndPicking() : void
      {
         this.bChooseMode = false;
         this.m_OverlayBG.graphics.clear();
         if(this.m_Overlay.contains(this.m_PickContainer))
         {
            this.m_Overlay.removeChild(this.m_PickContainer);
         }
         this.m_Overlay.visible = false;
      }
      
      private function WeaponChosen(param1:Weapon) : *
      {
         var _loc2_:Weapon = param1.Clone();
         this.m_CurrentItemPicker.SetWep(_loc2_);
         this.m_CurrentComp.SetWep(_loc2_);
         this.Calculate();
         this.m_BulletPreview.ChangeWep(_loc2_);
         this.m_WepEdit.SetWep(_loc2_);
         this.EndPicking();
      }
      
      private function ItemChosen(param1:uint) : *
      {
         this.m_CurrentItemPicker.iItem = param1;
         this.Calculate();
         if(this.m_aItemPickers[1] == this.m_CurrentItemPicker)
         {
            this.m_BulletPreview.ChangeAbil(param1);
         }
         this.EndPicking();
      }
      
      private function InitPickerItem(param1:ItemPicker) : Boolean
      {
         var _loc5_:ItemPicker = null;
         var _loc6_:Sprite = null;
         var _loc7_:TextField = null;
         var _loc8_:uint = 0;
         var _loc9_:* = undefined;
         var _loc10_:Weapon = null;
         var _loc11_:XML = null;
         var _loc12_:ItemPicker = null;
         while(this.m_PickContainer.numChildren > 0)
         {
            this.m_PickContainer.removeChildAt(0);
         }
         var _loc2_:uint = 0;
         if(param1 != this.m_aItemPickers[0])
         {
            _loc5_ = new ItemPicker();
            _loc5_.SetBackground();
            _loc5_.Reset();
            _loc5_.addEventListener(MouseEvent.CLICK,this.OnPickerItemClickItem);
            this.m_PickContainer.addChild(_loc5_);
            _loc2_++;
         }
         else
         {
            _loc6_ = new Sprite();
            _loc7_ = UtilUI.CreateTextField(0,0,0,Constants.TEXT_FORMAT_WHITE_MAIN);
            _loc7_.text = "Custom Weapons";
            _loc6_.graphics.beginFill(2105376,1);
            _loc6_.graphics.lineStyle(2,3158064);
            _loc6_.graphics.drawRoundRect(0,0,_loc7_.width,_loc7_.height,8,8);
            _loc6_.x = 0;
            _loc6_.y = 240 - 30;
            _loc7_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
            _loc6_.addChild(_loc7_);
            _loc6_.scaleX = _loc6_.scaleY = 1.25;
            _loc8_ = this.m_WepEdit.vSavedWeapons.length;
            this.m_aWepRemoveBtns.length = 0;
            this.m_aWepRemoveBtns = null;
            this.m_aWepRemoveBtns = new Array();
            if(_loc8_)
            {
               this.m_PickContainer.addChild(_loc6_);
            }
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc10_ = this.m_WepEdit.vSavedWeapons[_loc9_];
               _loc11_ = _loc10_.GetXML();
               _loc12_ = new ItemPicker();
               _loc12_.SetBackground(this.bHasWeapDPSStats(_loc11_),this.bHasAbilDPSStats(_loc11_));
               _loc12_.SetWep(_loc10_);
               _loc12_.x = 48 * (_loc9_ % 12);
               _loc12_.y = 240 + 64 * uint(_loc9_ / 12);
               _loc6_ = this.CreateRemoveButton();
               this.m_aWepRemoveBtns[_loc9_] = _loc6_;
               _loc6_.x = 48 * (_loc9_ % 12) + 20 - 8;
               _loc6_.y = 240 + 64 * uint(_loc9_ / 12) + 42 + 1;
               _loc12_.addEventListener(MouseEvent.CLICK,this.OnPickerItemClickItem);
               this.m_PickContainer.addChild(_loc12_);
               this.m_PickContainer.addChild(_loc6_);
               _loc9_++;
            }
         }
         var _loc3_:uint = 0;
         var _loc4_:uint = XmlData.aEq.length;
         while(_loc3_ < _loc4_)
         {
            if(uint(XmlData.aEq[_loc3_].SlotType) == param1.iSlotType)
            {
               _loc12_ = new ItemPicker();
               _loc12_.SetBackground(this.bHasWeapDPSStats(XmlData.aEq[_loc3_]),this.bHasAbilDPSStats(XmlData.aEq[_loc3_]));
               if(param1 == this.m_aItemPickers[0])
               {
                  _loc12_.SetWep(new Weapon(XmlData.aEq[_loc3_]));
               }
               else
               {
                  _loc12_.iItem = uint(XmlData.aEq[_loc3_].@type);
               }
               _loc12_.x = 48 * (_loc2_ % 12);
               _loc12_.y = 48 * uint(_loc2_ / 12);
               if(this.bIsAblity(param1.iSlotType))
               {
                  _loc12_.ContItem.SetWis(this.m_CurrentComp.iStatTotal(Stat.WIS));
               }
               _loc12_.addEventListener(MouseEvent.CLICK,this.OnPickerItemClickItem);
               this.m_PickContainer.addChild(_loc12_);
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ == 1)
         {
            return false;
         }
         this.m_Overlay.addChild(this.m_PickContainer);
         return true;
      }
      
      private function CreateRemoveButton() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Bitmap = SpriteParser.GetSprite("lofiInterfaceBig",8);
         _loc2_.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
         _loc2_.scaleX = _loc2_.scaleY = 1;
         _loc1_.addChild(_loc2_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.OnRemoveClick);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.OnRemoveOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         return _loc1_;
      }
      
      private function OnRemoveOver(param1:MouseEvent) : void
      {
         Tooltip.ShowDefault("Delete Weapon");
      }
      
      private function OnRemoveClick(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = Sprite(param1.currentTarget);
         _loc2_.removeEventListener(MouseEvent.CLICK,this.OnRemoveClick);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.OnRemoveOver);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         var _loc3_:int = int(this.m_aWepRemoveBtns.length);
         while(_loc3_ > 0)
         {
            _loc3_--;
            if(_loc2_ == this.m_aWepRemoveBtns[_loc3_])
            {
               this.m_WepEdit.Delete(_loc3_);
            }
         }
         this.InitPickerItem(this.m_aItemPickers[0]);
      }
      
      private function InitPickerClass(param1:uint) : *
      {
         var _loc3_:ClassPicker = null;
         while(this.m_PickContainer.numChildren > 0)
         {
            this.m_PickContainer.removeChildAt(0);
         }
         var _loc2_:* = 0;
         while(_loc2_ < XmlData.aPlayers.length)
         {
            _loc3_ = new ClassPicker();
            _loc3_.iClass = _loc2_;
            _loc3_.x = 56 * (_loc2_ % 5);
            _loc3_.y = 56 * uint(_loc2_ / 5);
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnPickerItemClickClass);
            this.m_PickContainer.addChild(_loc3_);
            _loc2_++;
         }
         this.m_Overlay.addChild(this.m_PickContainer);
      }
      
      public function OnPickerItemClickClass(param1:MouseEvent) : *
      {
         var _loc2_:ClassPicker = ClassPicker(param1.currentTarget);
         this.ClassChosen(_loc2_.iClass);
      }
      
      public function OnPickerItemClickItem(param1:MouseEvent) : *
      {
         var _loc2_:ItemPicker = ItemPicker(param1.currentTarget);
         if(_loc2_.wep != null)
         {
            this.WeaponChosen(_loc2_.wep);
         }
         else
         {
            this.ItemChosen(_loc2_.iItem);
         }
      }
      
      public function OnStatChange(param1:MouseEvent) : *
      {
         this.Calculate();
      }
      
      private function OnCheckBoxClick(param1:MouseEvent) : void
      {
         this.Calculate();
         this.ForceTTRedraw();
      }
      
      private function OnCheckBoxCompare(param1:MouseEvent) : void
      {
         DPSCalculator.COMPARE = this.m_cbCompare.selected;
      }
      
      private function OnDummy(param1:MouseEvent) : void
      {
      }
      
      private function onPetLevelChange(param1:Event) : void
      {
         this.Calculate();
      }
      
      public function OnRealmEyeClick(param1:MouseEvent) : *
      {
         this.m_REImport.visible = this.m_REImport.visible ? false : true;
      }
      
      public function onRealmEyeLoaded(param1:Event) : void
      {
         var _loc3_:CharComposition = null;
         this.m_BL.removeEventListener(BulkLoader.COMPLETE,this.onRealmEyeLoaded);
         var _loc2_:Vector.<CharComposition> = RealmEyeParser.GetComp(this.m_BL.getText("realmeye_json"));
         for each(_loc3_ in _loc2_)
         {
            _loc3_.iColor = this.iRandomColor();
            this.m_Graph.AddCompGraph(_loc3_);
         }
      }
      
      public function OnAddClick(param1:MouseEvent) : *
      {
         var _loc2_:CharComposition = this.m_CurrentComp.Clone();
         this.m_Graph.AddCompGraph(_loc2_);
         this.m_ColorPicker.selectedColor = 0;
         this.m_CurrentComp.iColor = 0;
         this.m_Graph.ChangeCurrentGraph(this.m_CurrentComp);
      }
      
      public function OnColorPickerClose(param1:Event) : *
      {
         this.m_CurrentComp.iColor = this.m_ColorPicker.selectedColor;
         this.Calculate();
      }
      
      public function OnRandClick(param1:MouseEvent) : *
      {
         var _loc2_:uint = this.iRandomColor();
         this.m_ColorPicker.selectedColor = _loc2_;
         this.m_CurrentComp.iColor = _loc2_;
         this.Calculate();
      }
      
      public function iRandomColor() : uint
      {
         var _loc1_:uint = Math.random() * 255;
         _loc1_ += Math.random() * 255 << 8;
         return uint(_loc1_ + (Math.random() * 255 << 16));
      }
      
      private function bIsWeapon(param1:uint) : Boolean
      {
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 8:
            case 17:
            case 24:
               return true;
            default:
               return false;
         }
      }
      
      private function bHasWeapDPSStats(param1:XML) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.ActivateOnEquip.length())
         {
            _loc3_ = uint(param1.ActivateOnEquip[_loc2_].@stat);
            if(_loc3_ == 20 || _loc3_ == 28)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function bHasAbilDPSStats(param1:XML) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.ActivateOnEquip.length())
         {
            _loc3_ = uint(param1.ActivateOnEquip[_loc2_].@stat);
            if(_loc3_ == 27)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function bIsAblity(param1:uint) : Boolean
      {
         switch(param1)
         {
            case CharComposition.TOME:
            case CharComposition.SHIELD:
            case CharComposition.SPELL:
            case CharComposition.SEAL:
            case CharComposition.CLOAK:
            case CharComposition.QUIVER:
            case CharComposition.HELM:
            case CharComposition.POISON:
            case CharComposition.SKULL:
            case CharComposition.TRAP:
            case CharComposition.ORB:
            case CharComposition.PRISM:
            case CharComposition.SCEPTER:
            case CharComposition.SHURIKEN:
               return true;
            default:
               return false;
         }
      }
      
      private function OnSwitch(param1:MouseEvent) : *
      {
         switch(param1.currentTarget)
         {
            case this.m_btnPreview:
               this.txt_WepPrev.alpha = this.m_btnPreview.alpha = 0.5;
               this.txt_Enems.alpha = this.m_btnEnemies.alpha = 1;
               this.m_BulletPreview.visible = true;
               this.m_EnemyViewer.visible = false;
               this.ToggleGraphVisible(false);
               break;
            case this.m_btnEnemies:
               this.txt_WepPrev.alpha = this.m_btnPreview.alpha = 1;
               this.txt_Enems.alpha = this.m_btnEnemies.alpha = 0.5;
               this.m_BulletPreview.visible = false;
               this.m_EnemyViewer.visible = true;
               this.ToggleGraphVisible(false);
               break;
            case this.m_btnGraph:
               this.txt_WepPrev.alpha = this.m_btnPreview.alpha = 1;
               this.txt_Enems.alpha = this.m_btnEnemies.alpha = 1;
               this.m_BulletPreview.visible = false;
               this.m_EnemyViewer.visible = false;
               this.ToggleGraphVisible(true);
         }
      }
      
      private function OnDefCalcClick(param1:MouseEvent) : *
      {
         if(this.m_cbDefense.selected)
         {
            this.defStuff.alpha = 1;
         }
         else
         {
            this.defStuff.alpha = 0.5;
         }
      }
      
      public function get bCalcDef() : Boolean
      {
         return this.m_cbDefense.selected;
      }
      
      private function ToggleGraphVisible(param1:Boolean) : void
      {
         this.m_btnGraph.visible = this.txt_Graph.visible = !param1;
         this.m_ColorPicker.visible = param1;
         this.m_btnRand.visible = this.txt_Rand.visible = param1;
         this.m_btnAdd.visible = this.txt_Add.visible = param1;
      }
      
      public function ToggleStats() : void
      {
         if(contains(this.m_StatMeter))
         {
            removeChild(this.m_StatMeter);
         }
         else
         {
            addChild(this.m_StatMeter);
         }
      }
      
      private function ForceTTRedraw() : void
      {
         Tooltip.Hide();
         this.DrawToolTip();
      }
      
      private function OnWepUpdate(param1:Event) : void
      {
         this.m_aItemPickers[0].SetWep(this.m_WepEdit.GetWeapon());
         this.UpdateAfterCalculate();
      }
      
      private function DrawToolTip() : void
      {
         var _loc1_:* = null;
         if(this.o == this.txt_BonusAtt)
         {
            _loc1_ = "Total bonus ATT from equipment.";
         }
         else if(this.o == this.txt_BonusDex)
         {
            _loc1_ = "Total bonus DEX from equipment.";
         }
         else if(this.o == this.txt_BonusWis)
         {
            _loc1_ = "Total bonus WIS from equipment.";
         }
         else if(this.o == this.txt_BonusDef)
         {
            _loc1_ = "Total bonus DEF from equipment.";
         }
         else if(this.o == this.m_cbDefense)
         {
            _loc1_ = "<b>Calculate Player Defense</b>\nDecide whether player defense is applied to enemy attacks.";
         }
         else if(this.o == this.m_cbDamaging)
         {
            _loc1_ = "<b>Damaging</b>\nIncreases weapon damage by 50%.\nUsed by Paladin\'s Seals and Orb of Conflict." + "\nCurrent average damage: <b>" + MathUtil.Round(this.m_CurrentComp.GetDMG(0),4) + "</b>";
         }
         else if(this.o == this.m_cbWeak)
         {
            _loc1_ = "<b>Weak</b>\nReduces ATT to 0 (Base 50% weapon damage).\nUsed by many enemies, including Earth Golems,\nUrgles, Oryx and Tomb Ancients." + "\nCurrent average damage: <b>" + MathUtil.Round(this.m_CurrentComp.GetDMG(0),4) + "</b>";
         }
         else if(this.o == this.m_cbBerserk)
         {
            _loc1_ = "<b>Berserk</b>\nIncreases attack speed by 50%.\nUsed by Warrior\'s Helms and high tier Orbs." + "\nCurrent shots per second: <b>" + MathUtil.Round(this.m_CurrentComp.GetHPS(),4) + "</b>";
         }
         else if(this.o == this.m_cbDazed)
         {
            _loc1_ = "<b>Dazed</b>\nReduces DEX to 0 (Base 1.5 attacks per second).\nUsed by Snakepit Guards and Oryx." + "\nCurrent shots per second: <b>" + MathUtil.Round(this.m_CurrentComp.GetHPS(),4) + "</b>";
         }
         else if(this.o == this.m_cbArmored)
         {
            _loc1_ = "<b>Armored</b>\nDoubles player defense.\n";
         }
         else if(this.o == this.m_cbCursed)
         {
            _loc1_ = "<b>Enemy Cursed</b>\nIncreases all damage on enemies by 20%.\nCalculated after defense.";
         }
         else if(this.o == this.m_ColorPicker)
         {
            _loc1_ = "Pick graph color";
         }
         else if(this.o == this.m_btnRand)
         {
            _loc1_ = "Randomize graph color";
         }
         else if(this.o == this.m_btnRE)
         {
            _loc1_ = "Import a character list from RealmEye";
         }
         else if(this.o == this.m_cbMaxed)
         {
            _loc1_ = "Character will start with maxed stats.\nLeave unchecked to simulate a fresh level 20 roll.";
         }
         else if(this.o == this.m_cbCompare)
         {
            _loc1_ = "Enables comparison with Build 24 in item and class tool tips.\nBuild 24 was the build before class rebalances and\nthe wisdom modifiers were introduced:\n" + "<font color=\'" + Constants.COLOR_STAT + "\'>" + "Old<b>" + Constants.WisColor(" -> ") + "New</b> (<font color=\'#66cc66\'>Buff</font>/<font color=\'#cc6666\'>Nerf</font> in %)</font>\nFor abilities, New also considers wisdom bonuses.";
         }
         else if(this.o == this.m_cbPet)
         {
            _loc1_ = "Choose pet magic heal level";
         }
         if(_loc1_)
         {
            Tooltip.ShowDefault(_loc1_);
         }
      }
      
      private function OnUIOver(param1:MouseEvent) : void
      {
         this.o = param1.currentTarget;
         this.DrawToolTip();
      }
      
      private function OnUIOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
   }
}


package
{
   import br.com.stimuli.loading.BulkLoader;
   import com.pfiffel.util.MathUtil;
   import fl.containers.ScrollPane;
   import fl.controls.ColorPicker;
   import fl.controls.ComboBox;
   import fl.controls.NumericStepper;
   import fl.controls.ScrollPolicy;
   import fl.controls.TextInput;
   import fl.text.TLFTextField;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import flash.net.registerClassAlias;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   
   public class WeaponEditor extends Sprite
   {
      private static const GREYED_OUT_ALPHA:Number = 0.25;
      
      private var bl:BulkLoader;
      
      private var nsSize:FNumStep;
      
      private var cpParticle:ColorPicker;
      
      private var nsPartLT:FNumStep;
      
      private var nsSpeed:FNumStep;
      
      private var nsLifetime:FNumStep;
      
      private var nsAmp:FNumStep;
      
      private var nsFreq:FNumStep;
      
      private var nsNumProj:FNumStep;
      
      private var nsArcGap:FNumStep;
      
      private var nsRoF:FNumStep;
      
      private var nsMinDmg:FNumStep;
      
      private var nsMaxDmg:FNumStep;
      
      private var nsStat2:FNumStep;
      
      private var nsStat3:FNumStep;
      
      private var nsStat4:FNumStep;
      
      private var nsStat7:FNumStep;
      
      private var nsStat5:FNumStep;
      
      private var nsStat6:FNumStep;
      
      private var nsStat0:FNumStep;
      
      private var nsStat1:FNumStep;
      
      private var nsTier:FNumStep;
      
      private var nsBag:FNumStep;
      
      private var nsFeed:FNumStep;
      
      private var nsFame:FNumStep;
      
      private var cbMulti:FCheckBox;
      
      private var cbAP:FCheckBox;
      
      private var cbNoCover:FCheckBox;
      
      private var cbWavy:FCheckBox;
      
      private var cbParam:FCheckBox;
      
      private var cbSB:FCheckBox;
      
      private var txtRange:TextField;
      
      private var txtTrueRange:TextField;
      
      private var txtDPS:TextField;
      
      private var txtAvgDmg:TextField;
      
      private var mc_Content:MovieClip = new MovieClip();
      
      private var sp_Content:ScrollPane = new ScrollPane();
      
      private var sp_Proj:ScrollPane = new ScrollPane();
      
      private var Wep:Weapon;
      
      private var Bag:Sprite = new Sprite();
      
      private var bg:Sprite = new Sprite();
      
      private var border:Sprite = new Sprite();
      
      private var btnMinimize:Sprite;
      
      private var vProjList:Vector.<ProjListItem> = new Vector.<ProjListItem>();
      
      private var PrList:Sprite;
      
      private var PrListMarker:Sprite;
      
      private var PrSelect:ProjListItem;
      
      private var main:Sprite;
      
      private var coboxSlot:ComboBox;
      
      private var btnSave:ButtonPlus;
      
      private var btnLoad:ButtonPlus;
      
      private var btnGetXML:ButtonPlus;
      
      private var btnSetXML:ButtonPlus;
      
      private var so:SharedObject;
      
      private var txtSetXML:TLFTextField;
      
      private var tiTitle:TextInput;
      
      private var tiDescr:TextInput;
      
      public var vSavedWeapons:Vector.<Weapon>;
      
      private var m_bShift:Boolean;
      
      private var iSpeedStep:Number;
      
      private var vItemSpriteList:Vector.<ItemSpriteListItem> = new Vector.<ItemSpriteListItem>();
      
      private var ISList:Sprite;
      
      private var ISListMarker:Sprite;
      
      private var ISSelect:ItemSpriteListItem;
      
      public function WeaponEditor()
      {
         super();
         this.InitSO();
         this.LoadFromSO();
         x = 600;
         y = 56;
         this.bl = BulkLoader.getLoader("main");
         this.main = new Sprite();
         this.main.graphics.beginFill(3355443,1);
         this.main.graphics.drawRect(0,0,200,800);
         this.main.graphics.endFill();
         this.SetUpScrollPane();
         this.Populate();
         this.border.graphics.beginFill(16777215,1);
         this.border.graphics.drawRect(-1,0,200 + 2,800 + 1);
         this.border.graphics.drawRect(0,1,200,800);
         this.border.graphics.endFill();
         this.main.addChild(this.border);
         addChild(this.main);
         this.MinimizeButton();
         this.InitProjectileList();
         this.InitItemSpriteList();
         addEventListener(Event.ADDED_TO_STAGE,this.onStage);
      }
      
      private function Save() : void
      {
         this.vSavedWeapons.push(this.Wep.Clone());
         this.SaveToSO();
      }
      
      public function Delete(param1:uint) : void
      {
         this.vSavedWeapons.splice(param1,1);
         this.SaveToSO();
      }
      
      private function InitSO() : void
      {
         registerClassAlias("Weapon",Weapon);
         this.so = SharedObject.getLocal("Pfiffel/dps/WeaponEditor","/");
         this.vSavedWeapons = new Vector.<Weapon>();
      }
      
      private function SaveToSO() : void
      {
         this.so.clear();
         var _loc1_:uint = this.so.size;
         var _loc2_:uint = this.vSavedWeapons.length;
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(this.vSavedWeapons[_loc4_]);
            _loc4_++;
         }
         this.so.data["weapons"] = _loc3_;
         this.so.flush();
         this.so.close();
      }
      
      private function LoadFromSO() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = undefined;
         var _loc3_:Weapon = null;
         if(this.so.data["weapons"] != undefined)
         {
            _loc1_ = uint(this.so.data["weapons"].length);
            if(this.vSavedWeapons.length)
            {
               this.vSavedWeapons.splice(0,this.vSavedWeapons.length);
            }
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this.so.data["weapons"][_loc2_] as Weapon;
               this.vSavedWeapons.push(_loc3_);
               _loc2_++;
            }
         }
      }
      
      private function GetXML() : void
      {
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this.Wep.toString(),false);
      }
      
      private function onSetXML(param1:Event) : void
      {
         var sCB:String = null;
         var w:Weapon = null;
         var e:Event = param1;
         if(Clipboard.generalClipboard.hasFormat(ClipboardFormats.TEXT_FORMAT))
         {
            try
            {
               sCB = String(Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT));
               w = new Weapon(XML(sCB));
               if(w.iID)
               {
                  this.SetWep(w);
                  this.UpdateResults();
                  this.UpdateExtern();
                  this.setButtonText("XML Imported",2000);
               }
               else
               {
                  this.setButtonText("Invalid XML",2000);
               }
            }
            catch(err:Error)
            {
               setButtonText("Invalid XML",2000);
            }
         }
         else
         {
            this.setButtonText("Invalid XML",2000);
         }
      }
      
      private function setButtonText(param1:String, param2:Number = 0) : void
      {
         this.btnSetXML.text = param1;
         if(param2)
         {
            setTimeout(this.resetImportButton,param2);
         }
      }
      
      private function resetImportButton() : void
      {
         this.btnSetXML.text = "Import XML";
      }
      
      public function FocusFree() : Boolean
      {
         if(stage.focus == this.tiDescr.textField)
         {
            return false;
         }
         if(stage.focus == this.tiTitle.textField)
         {
            return false;
         }
         return true;
      }
      
      private function onStage(param1:Event) : void
      {
         stage.addEventListener(Event.PASTE,this.onSetXML);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.OnKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.OnKeyUp);
      }
      
      private function OnKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.SHIFT:
               this.m_bShift = true;
         }
      }
      
      private function OnKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.SHIFT:
               this.m_bShift = false;
         }
      }
      
      private function InitItemSpriteList() : void
      {
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:ItemSpriteListItem = null;
         this.ISList = new Sprite();
         var _loc1_:uint = XmlData.aEq.length;
         var _loc2_:int = 26;
         var _loc3_:int = 20 * _loc2_;
         var _loc4_:* = 0;
         while(_loc4_ < _loc1_)
         {
            _loc6_ = XmlData.aEq[_loc4_];
            _loc7_ = new ItemSpriteListItem(_loc6_);
            _loc7_.x = 2 + _loc4_ % _loc2_ * 20;
            _loc7_.y = 2 + int(_loc4_ / _loc2_) * 20;
            this.vItemSpriteList.push(_loc7_);
            this.ISList.addChild(_loc7_);
            _loc7_.addEventListener(MouseEvent.CLICK,this.OnItemSpriteSelect);
            _loc4_++;
         }
         _loc5_ = (int(_loc4_ / _loc2_) + 1) * 20;
         this.ISList.graphics.beginFill(16777215,1);
         this.ISList.graphics.drawRect(-1,-1,_loc3_ + 4 + 2,_loc5_ + 4 + 2);
         this.ISList.graphics.beginFill(3355443,1);
         this.ISList.graphics.drawRect(0,0,_loc3_ + 4,_loc5_ + 4);
         this.ISList.graphics.endFill();
         this.ISListMarker = new Sprite();
         this.ISListMarker.graphics.beginFill(16572160,1);
         this.ISListMarker.graphics.drawRect(-1,-1,20 + 2,20 + 2);
         this.ISListMarker.graphics.drawRect(1,1,20 - 2,20 - 2);
         this.ISListMarker.graphics.endFill();
         this.ISList.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         this.ISList.addChild(this.ISListMarker);
         addChild(this.ISList);
         this.ISList.x = -_loc3_ - 5 - 8;
         this.ISList.y = 8;
         this.ISList.visible = false;
      }
      
      private function UpdateItemSpriteSelect(param1:String) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:XML = XmlData.ObjectByTexture(param1);
         var _loc3_:String = _loc2_.@id;
         this.ISSelect.Update(_loc2_);
         var _loc4_:uint = this.vItemSpriteList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(this.vItemSpriteList[_loc5_].sName == _loc3_)
            {
               this.ISListMarker.x = this.vItemSpriteList[_loc5_].x;
               this.ISListMarker.y = this.vItemSpriteList[_loc5_].y;
            }
            _loc5_++;
         }
      }
      
      private function OnItemSpriteSelect(param1:MouseEvent) : void
      {
         var _loc2_:ItemSpriteListItem = ItemSpriteListItem(param1.currentTarget);
         this.ISListMarker.x = _loc2_.x;
         this.ISListMarker.y = _loc2_.y;
         this.ISSelect.Update(XmlData.ObjectByName(_loc2_.sName));
         this.UpdateWep();
         this.ISList.visible = false;
      }
      
      private function onSelectIS(param1:Event) : *
      {
         this.ISList.visible = this.ISList.visible ? false : true;
      }
      
      private function InitProjectileList() : void
      {
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:ProjListItem = null;
         this.PrList = new Sprite();
         this.sp_Proj.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.sp_Proj.setSize(600,544);
         this.sp_Proj.source = this.PrList;
         this.sp_Proj.move(-600,0);
         var _loc1_:uint = XmlData.aProjectiles.length;
         var _loc2_:int = 29;
         var _loc3_:int = 20 * _loc2_;
         var _loc4_:* = 0;
         while(_loc4_ < _loc1_)
         {
            _loc6_ = XmlData.aProjectiles[_loc4_];
            _loc7_ = new ProjListItem(_loc6_);
            _loc7_.x = 2 + _loc4_ % _loc2_ * 20;
            _loc7_.y = 2 + int(_loc4_ / _loc2_) * 20;
            this.vProjList.push(_loc7_);
            this.PrList.addChild(_loc7_);
            _loc7_.addEventListener(MouseEvent.CLICK,this.OnProjSelect);
            _loc4_++;
         }
         _loc5_ = (int(_loc4_ / _loc2_) + 1) * 20;
         this.PrList.graphics.beginFill(16777215,1);
         this.PrList.graphics.drawRect(-1,-1,_loc3_ + 4 + 2,_loc5_ + 4 + 2);
         this.PrList.graphics.beginFill(3355443,1);
         this.PrList.graphics.drawRect(0,0,_loc3_ + 4,_loc5_ + 4);
         this.PrList.graphics.endFill();
         this.PrListMarker = new Sprite();
         this.PrListMarker.graphics.beginFill(16572160,1);
         this.PrListMarker.graphics.drawRect(-1,-1,20 + 2,20 + 2);
         this.PrListMarker.graphics.drawRect(1,1,20 - 2,20 - 2);
         this.PrListMarker.graphics.endFill();
         this.PrList.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         this.PrList.addChild(this.PrListMarker);
         this.PrList.x = this.PrList.y = 1;
         this.sp_Proj.visible = false;
         addChild(this.sp_Proj);
         this.sp_Proj.update();
         this.main.visible = false;
      }
      
      private function GetSelectIndex(param1:uint) : uint
      {
         switch(param1)
         {
            case 1:
               return 0;
            case 2:
               return 1;
            case 3:
               return 2;
            case 8:
               return 3;
            case 17:
               return 4;
            case 24:
               return 5;
            default:
               return 0;
         }
      }
      
      private function InitComboBox(param1:Number, param2:Number, param3:Number, param4:Number) : ComboBox
      {
         var _loc5_:ComboBox = new ComboBox();
         _loc5_.textField.setStyle("embedFonts",true);
         _loc5_.textField.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         _loc5_.textField.setStyle("textPadding",-5);
         _loc5_.dropdownWidth = param3;
         _loc5_.dropdown.setStyle("cellRenderer",CustomCellRenderer);
         _loc5_.dropdown.rowHeight = param4;
         _loc5_.rowCount = 6;
         _loc5_.setSize(param3,param4);
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.addItem({
            "label":"Sword",
            "data":1
         });
         _loc5_.addItem({
            "label":"Dagger",
            "data":2
         });
         _loc5_.addItem({
            "label":"Bow",
            "data":3
         });
         _loc5_.addItem({
            "label":"Wand",
            "data":8
         });
         _loc5_.addItem({
            "label":"Staff",
            "data":17
         });
         _loc5_.addItem({
            "label":"Katana",
            "data":24
         });
         _loc5_.addEventListener(Event.CHANGE,this.onBoxChange);
         _loc5_.textField.y -= 10;
         this.mc_Content.addChild(_loc5_);
         return _loc5_;
      }
      
      private function UpdateProjSelect(param1:String) : void
      {
         this.PrSelect.Update(XmlData.ObjectByName(param1));
         var _loc2_:uint = this.vProjList.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.vProjList[_loc3_].sName == param1)
            {
               this.PrListMarker.x = this.vProjList[_loc3_].x;
               this.PrListMarker.y = this.vProjList[_loc3_].y;
            }
            _loc3_++;
         }
      }
      
      private function OnProjSelect(param1:MouseEvent) : void
      {
         var _loc2_:ProjListItem = ProjListItem(param1.currentTarget);
         this.PrListMarker.x = _loc2_.x;
         this.PrListMarker.y = _loc2_.y;
         this.PrSelect.Update(XmlData.ObjectByName(_loc2_.sName));
         this.UpdateWep();
         this.sp_Proj.visible = false;
      }
      
      private function ResetPos(param1:MouseEvent) : void
      {
         if(this.main.visible)
         {
            this.main.visible = false;
            this.sp_Proj.visible = false;
         }
         else
         {
            this.main.visible = true;
         }
         this.sp_Content.update();
      }
      
      private function CreateNewIcon(param1:Number, param2:Number, param3:uint) : Bitmap
      {
         var _loc4_:Bitmap = SpriteParser.GetSprite("lofiInterface2",param3);
         _loc4_.x = param1;
         _loc4_.y = param2;
         return _loc4_;
      }
      
      private function MinimizeButton() : void
      {
         this.btnMinimize = new Sprite();
         var _loc1_:Bitmap = this.CreateNewIcon(0,0,48);
         this.btnMinimize.addChild(_loc1_);
         this.btnMinimize.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
         this.btnMinimize.y = -28 - 12 - 4;
         this.btnMinimize.addEventListener(MouseEvent.CLICK,this.ResetPos);
         addChild(this.btnMinimize);
         _loc1_.scaleX = _loc1_.scaleY = 4;
         this.btnMinimize.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.btnMinimize.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
      }
      
      private function SetUpScrollPane() : void
      {
         this.sp_Content.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.sp_Content.source = this.mc_Content;
         this.main.addChild(this.sp_Content);
      }
      
      private function SetScrollPanePosSize(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.sp_Content.setSize(param3,param4);
         this.sp_Content.move(param1,param2);
      }
      
      private function CreateButton(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : ButtonPlus
      {
         var _loc6_:ButtonPlus = new ButtonPlus(param1,param4,param5,Constants.TEXT_FORMAT_BLACK);
         _loc6_.move(param2,param3);
         _loc6_.btn.addEventListener(MouseEvent.CLICK,this.onButton);
         _loc6_.btn.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         _loc6_.btn.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.main.addChild(_loc6_);
         return _loc6_;
      }
      
      private function CreateTextInput(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : TextInput
      {
         var _loc7_:TextInput = null;
         var _loc6_:TextFormatPlus = Constants.TEXT_FORMAT_BLACK_BOTTOM.Clone();
         if(param1 != "Title")
         {
            _loc6_.bold = false;
         }
         _loc7_ = UtilUI.CreateTextInput(param2,param3,param4,param5,_loc6_);
         _loc7_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc7_.addEventListener(Event.CHANGE,this.onTextChange);
         _loc7_.restrict = "0-9 a-zA-Z\\-\\^\'.,?:!";
         _loc7_.maxChars = 256;
         this.mc_Content.addChild(_loc7_);
         return _loc7_;
      }
      
      private function onFocusIn(param1:FocusEvent) : void
      {
         setTimeout(this.selectSet,50);
      }
      
      private function selectSet(param1:MouseEvent) : void
      {
         this.txtSetXML.setSelection(0,this.txtSetXML.text.length);
      }
      
      private function unselectSet() : void
      {
         this.txtSetXML.setSelection(0,0);
      }
      
      private function onFocusOut(param1:FocusEvent) : void
      {
         this.unselectSet();
      }
      
      private function Populate() : void
      {
         var _loc1_:XML = null;
         var _loc6_:* = undefined;
         var _loc7_:uint = 0;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         this.mc_Content.addChild(this.bg);
         this.mc_Content.addChild(this.Bag);
         _loc1_ = this.bl.getXML("wepedit_xml");
         var _loc2_:XMLList = _loc1_.Align;
         var _loc3_:int = int(_loc1_.Align.@colY);
         var _loc4_:Number = -_loc3_ - 4;
         var _loc5_:uint = uint(_loc1_.saveUI.length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = _loc1_.saveUI[_loc6_];
            _loc9_ = _loc8_.@prop;
            _loc10_ = int(_loc8_.@skip);
            _loc11_ = _loc8_.@type;
            _loc12_ = _loc8_;
            if(!_loc10_)
            {
               _loc4_ += _loc3_;
            }
            if(_loc11_ == "btn")
            {
               this[_loc9_] = this.CreateButton(_loc12_,int(_loc2_.@btnX) + _loc10_,int(_loc2_.@btnY) + _loc4_,int(_loc2_.@btnW) + int(_loc8_.@w),int(_loc2_.@btnH) + int(_loc8_.@h));
            }
            if(Boolean(_loc9_) && this[_loc9_] != null)
            {
               this[_loc9_].x += int(_loc8_.@x);
               this[_loc9_].y += int(_loc8_.@y);
            }
            _loc4_ += int(_loc8_.@addCol);
            _loc6_++;
         }
         this.main.graphics.lineStyle(1,4210752,1);
         this.main.graphics.moveTo(0,_loc4_ + _loc3_ + 8);
         this.main.graphics.lineTo(200,_loc4_ + _loc3_ + 8);
         this.SetScrollPanePosSize(0,1 + _loc4_ + _loc3_ + 8,200 - 1,600 - 56 - 1 - (_loc4_ + _loc3_ + 8));
         _loc4_ = -_loc3_ - 2;
         _loc7_ = uint(_loc1_.UI.length());
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc1_.UI[_loc6_];
            _loc9_ = _loc8_.@prop;
            _loc10_ = int(_loc8_.@skip);
            _loc11_ = _loc8_.@type;
            _loc12_ = _loc8_;
            if(!_loc10_)
            {
               _loc4_ += _loc3_;
            }
            if(_loc11_ == "header")
            {
               this.AddTxt("<b>" + _loc12_ + "</b>",0,_loc4_,200,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            else if(_loc11_ == "num")
            {
               this[_loc9_] = UtilUI.CreateNumStep(int(_loc2_.@nsX) + _loc10_,int(_loc2_.@nsY) + _loc4_,int(_loc2_.@nsW) + 0 * int(_loc8_.@nsW),_loc2_.@nsH,Constants.TEXT_FORMAT_BLACK_BOTTOM);
               this.SetNumStep(this[_loc9_],_loc8_.@max,_loc8_.@min,_loc8_.@step);
               this.AddTxt(_loc12_,int(_loc2_.@nsOX) + _loc10_ + int(_loc8_.@x),_loc4_ + int(_loc8_.@y),150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
               if(_loc8_.@propStep != undefined)
               {
                  this[_loc8_.@propStep] = _loc8_.@sStep;
               }
            }
            else if(_loc11_ == "chb")
            {
               this[_loc9_] = UtilUI.CreateCheckBox(0,0,"",this.onCB,Constants.TEXT_FORMAT_WHITE_MAIN);
               this.SetCheckBox(this[_loc9_],int(_loc2_.@cbX) + _loc10_,int(_loc2_.@cbY) + _loc4_,_loc2_.@cbS);
               this.AddTxt(_loc12_,int(_loc2_.@cbOX) + _loc10_,_loc4_,150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            else if(_loc11_ == "res")
            {
               this[_loc9_] = this.AddTxt("->",int(_loc2_.@txOX1) + _loc10_,_loc4_,150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
               this.AddTxt(_loc12_,int(_loc2_.@txOX2) + _loc10_,_loc4_,150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            else if(_loc11_ == "col")
            {
               this[_loc9_] = this.SetColorPicker(int(_loc2_.@cpX) + _loc10_,int(_loc2_.@cpY) + _loc4_,_loc2_.@cpW,_loc2_.@cpH);
               this.AddTxt(_loc12_,int(_loc2_.@cpOX) + _loc10_,_loc4_,150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            else if(_loc11_ == "cob")
            {
               this[_loc9_] = this.InitComboBox(int(_loc2_.@cobX) + _loc10_,int(_loc2_.@cobY) + _loc4_,_loc2_.@cobW,_loc2_.@cobH);
               this.AddTxt(_loc12_,int(_loc2_.@cobOX) + _loc10_,_loc4_,150 - _loc10_,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            else if(_loc11_ == "btn")
            {
               this[_loc9_] = this.CreateButton(_loc12_,int(_loc2_.@btnX) + _loc10_,int(_loc2_.@btnY) + _loc4_,int(_loc2_.@btnW) + int(_loc8_.@w),int(_loc2_.@btnH) + int(_loc8_.@h));
            }
            else if(_loc11_ == "tip")
            {
               this[_loc9_] = this.CreateTextInput(_loc12_,_loc10_,_loc4_,_loc8_.@w,_loc8_.@h);
            }
            else if(_loc11_ == "selectP")
            {
               this[_loc9_] = new ProjListItem(null);
               this[_loc9_].x = int(_loc2_.@selX) + _loc10_;
               this[_loc9_].y = int(_loc2_.@selY) + _loc4_;
               this.mc_Content.addChild(this[_loc9_]);
               this[_loc9_].scaleX = this[_loc9_].scaleY = Number(_loc2_.@selS);
               this[_loc9_].addEventListener(MouseEvent.CLICK,this.onSelectPr);
            }
            else if(_loc11_ == "selectIS")
            {
               this[_loc9_] = new ItemSpriteListItem(null);
               this[_loc9_].x = int(_loc2_.@selX) + _loc10_;
               this[_loc9_].y = int(_loc2_.@selY) + _loc4_;
               this.mc_Content.addChild(this[_loc9_]);
               this[_loc9_].scaleX = this[_loc9_].scaleY = Number(_loc2_.@selS);
               this[_loc9_].addEventListener(MouseEvent.CLICK,this.onSelectIS);
            }
            else
            {
               this.AddTxt(_loc12_,4,_loc4_,200,Constants.TEXT_FORMAT_WHITE_MAIN);
            }
            if(Boolean(_loc9_) && this[_loc9_] != null)
            {
               this[_loc9_].x += int(_loc8_.@x);
               this[_loc9_].y += int(_loc8_.@y);
            }
            _loc4_ += int(_loc8_.@addCol);
            _loc6_++;
         }
         this.Bag.x = this.nsBag.x;
         this.Bag.y = this.nsBag.y;
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(3355443,1);
         this.bg.graphics.drawRect(0,0,200,_loc4_ + _loc3_ + 8);
         this.bg.graphics.endFill();
         this.sp_Content.update();
      }
      
      public function GetWeapon() : Weapon
      {
         return this.Wep;
      }
      
      private function UpdateWep() : void
      {
         this.Wep.iSize = this.nsSize.value;
         this.Wep.iParticleTrail = this.cpParticle.selectedColor;
         this.Wep.iParticleLifeTime = this.nsPartLT.value;
         this.Wep.fSpeed = this.nsSpeed.value;
         this.Wep.iLifeTime = this.nsLifetime.value;
         this.Wep.fAmplitude = this.nsAmp.value;
         this.Wep.fFrequency = this.nsFreq.value;
         this.Wep.bWavy = this.cbWavy.selected;
         this.Wep.bParametric = this.cbParam.selected;
         this.Wep.iProjectiles = this.nsNumProj.value;
         this.Wep.fArcGap = this.nsArcGap.value;
         this.Wep.fRateOfFire = this.nsRoF.value / 100;
         this.Wep.iMinDamage = this.nsMinDmg.value;
         this.Wep.iMaxDamage = this.nsMaxDmg.value;
         this.Wep.bMultiHit = this.cbMulti.selected;
         this.Wep.bArmorPiercing = this.cbAP.selected;
         this.Wep.bPassesCover = this.cbNoCover.selected;
         this.Wep.vStats[2] = this.nsStat2.value;
         this.Wep.vStats[3] = this.nsStat3.value;
         this.Wep.vStats[4] = this.nsStat4.value;
         this.Wep.vStats[7] = this.nsStat7.value;
         this.Wep.vStats[5] = this.nsStat5.value;
         this.Wep.vStats[6] = this.nsStat6.value;
         this.Wep.vStats[0] = this.nsStat0.value;
         this.Wep.vStats[1] = this.nsStat1.value;
         this.Wep.iTier = this.nsTier.value;
         this.Wep.iBagType = this.nsBag.value;
         this.Wep.iFeedPower = this.nsFeed.value;
         this.Wep.iFameBonus = this.nsFame.value;
         this.Wep.bSoulbound = this.cbSB.selected;
         this.Wep.sProjId = this.PrSelect.sName;
         this.Wep.sTex = this.ISSelect.GetTex();
         this.Wep.iSlotType = this.coboxSlot.selectedItem.data;
         this.Wep.sName = this.Wep.sDisId = this.tiTitle.text;
         this.Wep.sDescr = this.tiDescr.text;
         this.UpdateExtern();
         this.UpdateResults();
      }
      
      private function UpdateExtern() : void
      {
         CharCompCom.Current.SetWep(this.Wep);
         CharCompCom.Current.CalculateForWepEdit();
         dispatchEvent(new Event("update"));
      }
      
      public function SetWep(param1:Weapon) : void
      {
         this.Wep = param1;
         this.nsSize.value = this.Wep.iSize;
         this.cpParticle.selectedColor = this.Wep.iParticleTrail;
         this.nsPartLT.value = this.Wep.iParticleLifeTime;
         this.nsSpeed.value = this.Wep.fSpeed;
         this.nsLifetime.value = this.Wep.iLifeTime;
         this.nsAmp.value = this.Wep.fAmplitude;
         this.nsFreq.value = this.Wep.fFrequency;
         this.cbWavy.selected = this.Wep.bWavy;
         this.cbParam.selected = this.Wep.bParametric;
         this.nsNumProj.value = this.Wep.iProjectiles;
         this.nsArcGap.value = this.Wep.fArcGap;
         this.nsRoF.value = this.Wep.fRateOfFire * 100;
         this.nsMinDmg.value = this.Wep.iMinDamage;
         this.nsMaxDmg.value = this.Wep.iMaxDamage;
         this.cbMulti.selected = this.Wep.bMultiHit;
         this.cbAP.selected = this.Wep.bArmorPiercing;
         this.cbNoCover.selected = this.Wep.bPassesCover;
         this.nsStat2.value = this.Wep.vStats[2];
         this.nsStat3.value = this.Wep.vStats[3];
         this.nsStat4.value = this.Wep.vStats[4];
         this.nsStat7.value = this.Wep.vStats[7];
         this.nsStat5.value = this.Wep.vStats[5];
         this.nsStat6.value = this.Wep.vStats[6];
         this.nsStat0.value = this.Wep.vStats[0];
         this.nsStat1.value = this.Wep.vStats[1];
         this.nsTier.value = this.Wep.iTier;
         this.nsBag.value = this.Wep.iBagType;
         this.nsFeed.value = this.Wep.iFeedPower;
         this.nsFame.value = this.Wep.iFameBonus;
         this.cbSB.selected = this.Wep.bSoulbound;
         this.tiTitle.text = this.Wep.sName;
         this.tiDescr.text = Language.getString(this.Wep.sDescr);
         this.UpdateProjSelect(this.Wep.sProjId);
         this.UpdateItemSpriteSelect(this.Wep.sTex);
         this.coboxSlot.selectedIndex = this.GetSelectIndex(this.Wep.iSlotType);
         this.UpdateResults();
      }
      
      private function UpdateBagType() : void
      {
         while(this.Bag.numChildren > 0)
         {
            this.Bag.removeChildAt(0);
         }
         var _loc1_:XML = this.bl.getXML("wepedit_xml");
         var _loc2_:XMLList = _loc1_.Align;
         var _loc3_:RotMGSprite = new RotMGSprite(this.BagByType(this.Wep.iBagType),Number(_loc2_.@bagS));
         _loc3_.x = Number(_loc2_.@bagX);
         _loc3_.y = Number(_loc2_.@bagY);
         _loc3_.filters = [Constants.BLACK_OUTLINE];
         this.Bag.addChild(_loc3_);
      }
      
      private function BagByType(param1:uint) : XML
      {
         var _loc2_:String = "Loot Bag";
         if(param1)
         {
            _loc2_ += " " + param1;
         }
         return XmlData.ObjectByName(_loc2_);
      }
      
      private function UpdateResults() : void
      {
         this.nsFreq.alpha = this.nsAmp.alpha = 1 - int(this.cbWavy.selected || this.cbParam.selected) * (1 - GREYED_OUT_ALPHA);
         this.nsSpeed.alpha = this.cbWavy.alpha = 1 - int(this.cbParam.selected) * (1 - GREYED_OUT_ALPHA);
         this.nsArcGap.alpha = 1 - int(this.nsNumProj.value == 1 || this.cbParam.selected) * (1 - GREYED_OUT_ALPHA);
         this.txtTrueRange.alpha = 1 - int(this.nsNumProj.value == 1 || this.nsArcGap.value == 0) * (1 - GREYED_OUT_ALPHA);
         this.nsPartLT.alpha = 1 - int(!Boolean(this.cpParticle.selectedColor)) * (1 - GREYED_OUT_ALPHA);
         this.txtRange.htmlText = "-> <b>" + MathUtil.Round(this.Wep.fRange,2) + "</b>";
         this.txtTrueRange.htmlText = "-> <b>" + MathUtil.Round(this.Wep.fTrueRange,2) + "</b>";
         this.txtDPS.htmlText = "-> <b>" + MathUtil.Round(this.Wep.fDPS,2) + "</b>";
         this.txtAvgDmg.htmlText = "-> <b>" + MathUtil.Round(this.Wep.fAverageDamage,2) + "</b>";
         this.UpdateBagType();
      }
      
      private function Reset() : void
      {
         while(this.mc_Content.numChildren > 0)
         {
            this.mc_Content.removeChildAt(0);
         }
         this.nsSize = null;
         this.cpParticle = null;
         this.nsSpeed = null;
         this.nsLifetime = null;
         this.nsAmp = null;
         this.nsFreq = null;
         this.nsNumProj = null;
         this.nsArcGap = null;
         this.nsRoF = null;
         this.nsMinDmg = null;
         this.nsMaxDmg = null;
         this.nsStat2 = null;
         this.nsStat3 = null;
         this.nsStat4 = null;
         this.nsStat7 = null;
         this.nsStat5 = null;
         this.nsStat6 = null;
         this.nsStat0 = null;
         this.nsStat1 = null;
         this.nsTier = null;
         this.nsBag = null;
         this.nsFeed = null;
         this.nsFame = null;
         this.cbMulti = null;
         this.cbAP = null;
         this.cbNoCover = null;
         this.cbWavy = null;
         this.cbParam = null;
         this.cbSB = null;
         this.txtRange = null;
         this.txtTrueRange = null;
         this.txtDPS = null;
         this.txtAvgDmg = null;
         this.PrSelect = null;
      }
      
      public function Reload() : void
      {
         this.Reset();
         this.bl.reload("wepedit_xml");
         this.bl.addEventListener(BulkLoader.COMPLETE,this.onReloaded);
         this.bl.start();
      }
      
      public function onReloaded(param1:Event) : void
      {
         this.Populate();
         this.UpdateBagType();
         this.bl.removeEventListener(BulkLoader.COMPLETE,this.onReloaded);
      }
      
      private function SetColorPicker(param1:Number, param2:Number, param3:Number, param4:Number) : ColorPicker
      {
         var _loc5_:ColorPicker = new ColorPicker();
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.addEventListener("close",this.onCP);
         this.mc_Content.addChild(_loc5_);
         _loc5_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc5_.height = param4;
         _loc5_.width = param3;
         return _loc5_;
      }
      
      private function SetNumStep(param1:NumericStepper, param2:int, param3:int, param4:Number) : void
      {
         if(!param2)
         {
            param2 = 10;
            param3 = 0;
            param4 = 1;
         }
         if(!param4)
         {
            param4 = 1;
         }
         param1.maximum = param2;
         param1.minimum = param3;
         param1.stepSize = param4;
         param1.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         param1.addEventListener(Event.CHANGE,this.onNS);
         this.mc_Content.addChild(param1);
      }
      
      private function SetCheckBox(param1:FCheckBox, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Sprite = new Sprite();
         _loc5_.x = param2;
         _loc5_.y = param3;
         _loc5_.scaleX = _loc5_.scaleY = param4;
         param1.width = 200;
         param1.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc5_.addChild(param1);
         this.mc_Content.addChild(_loc5_);
      }
      
      private function AddTxt(param1:String, param2:Number, param3:Number, param4:Number, param5:TextFormatPlus) : TextField
      {
         var _loc6_:TextField = UtilUI.CreateTextField(param2,param3,param4,param5);
         _loc6_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         _loc6_.htmlText = param1;
         this.mc_Content.addChild(_loc6_);
         return _loc6_;
      }
      
      private function onCB(param1:MouseEvent) : *
      {
         this.UpdateWep();
      }
      
      private function onButton(param1:MouseEvent) : *
      {
         if(param1.currentTarget == this.btnSave.btn)
         {
            this.Save();
         }
         else if(param1.currentTarget == this.btnGetXML.btn)
         {
            this.GetXML();
         }
         else if(param1.currentTarget == this.btnSetXML.btn)
         {
         }
      }
      
      private function onNS(param1:Event) : *
      {
         this.UpdateWep();
      }
      
      private function onTextChange(param1:Event) : *
      {
         this.UpdateWep();
      }
      
      private function onBoxChange(param1:Event) : *
      {
         this.UpdateWep();
      }
      
      public function onCP(param1:Event) : *
      {
         this.UpdateWep();
      }
      
      private function onSelectPr(param1:Event) : *
      {
         this.sp_Proj.visible = this.sp_Proj.visible ? false : true;
      }
      
      private function OnUIOver(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = param1.currentTarget;
         if(_loc2_ == this.btnMinimize)
         {
            this.btnMinimize.filters = [Constants.BLACK_OUTLINE_PURE,Constants.LIFE_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
            if(!this.main.visible)
            {
               _loc3_ = "Open Weapon Editor";
            }
            else
            {
               _loc3_ = "Close Weapon Editor";
            }
         }
         else if(_loc2_ == this.txtSetXML)
         {
            _loc3_ = "Paste to import XML from clipboard";
         }
         else if(_loc2_ == this.btnSave.btn)
         {
            _loc3_ = "Save as new custom weapon.";
         }
         else if(_loc2_ == this.btnSetXML.btn)
         {
            _loc3_ = "Click and press Ctrl+V to import XML from your clipboard.";
         }
         else if(_loc2_ == this.btnGetXML.btn)
         {
            _loc3_ = "Copy XML to clipboard.";
         }
         if(_loc3_)
         {
            Tooltip.ShowDefault(_loc3_);
         }
      }
      
      private function OnUIOut(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.currentTarget;
         _loc2_ = this.btnMinimize;
         if(_loc2_)
         {
            this.btnMinimize.filters = [Constants.BLACK_OUTLINE,Constants.GLOW_BLACK_TT_CONTENT];
         }
         Tooltip.Hide();
      }
   }
}


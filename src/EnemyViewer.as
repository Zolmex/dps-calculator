package
{
   import br.com.stimuli.loading.BulkLoader;
   import fl.containers.ScrollPane;
   import fl.controls.CheckBox;
   import fl.controls.ComboBox;
   import fl.controls.ScrollPolicy;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class EnemyViewer extends Sprite
   {
      private var aEnemyDefense:Array = new Array();
      
      private var mc_Content:MovieClip = new MovieClip();
      
      private var sp_Content:ScrollPane = new ScrollPane();
      
      private var m_BG:Sprite = new Sprite();
      
      private var m_Calc:DPSCalculator;
      
      public var ui:Sprite = new Sprite();
      
      private var aEnemies:Vector.<Enemy> = new Vector.<Enemy>();
      
      private var m_cbSort:ComboBox;
      
      private var mc_TextHeaders:Sprite;
      
      private var m_cbArmored:CheckBox;
      
      private var m_cbBroken:CheckBox;
      
      private var m_cbCursed:CheckBox;
      
      public function EnemyViewer(param1:DPSCalculator)
      {
         super();
         this.m_Calc = param1;
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(3355443,1);
         _loc2_.graphics.drawRect(0,56 + 1,800 + 200,600 - 56 + 1);
         _loc2_.graphics.endFill();
         _loc2_.graphics.lineStyle(1,4210752,1);
         _loc2_.graphics.moveTo(0,56 + 24);
         _loc2_.graphics.lineTo(800,56 + 24);
         _loc2_.graphics.moveTo(165,56);
         _loc2_.graphics.lineTo(165,56 + 24);
         _loc2_.graphics.moveTo(165 + 278,56);
         _loc2_.graphics.lineTo(165 + 278,56 + 24);
         addChild(_loc2_);
         this.SetUpScrollPane();
         this.GetDefValues();
         this.CreateComboBox();
         this.SortEnemies("New");
      }
      
      public function GetComp() : CharComposition
      {
         return this.m_Calc.GetComp();
      }
      
      private function SetUpScrollPane() : void
      {
         this.sp_Content.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.sp_Content.setSize(800 - 2,600 - 56 - 2 - 24);
         this.sp_Content.source = this.mc_Content;
         this.sp_Content.move(1,56 + 1 + 24);
         addChild(this.sp_Content);
      }
      
      private function AddItem(param1:Number, param2:Number, param3:uint, param4:uint) : Enemy
      {
         var _loc5_:Enemy = new Enemy(this,XmlData.ObjectById(param3),param4,4);
         _loc5_.x = param1;
         _loc5_.y = param2;
         this.mc_Content.addChild(_loc5_);
         return _loc5_;
      }
      
      private function GetDefValues() : void
      {
         var _loc2_:XML = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:* = 0;
         while(_loc1_ < XmlData.aEnemies.length)
         {
            _loc2_ = XmlData.aEnemies[_loc1_];
            _loc3_ = uint(_loc2_.@type);
            _loc4_ = uint(_loc2_.Defense);
            this.aEnemyDefense.push({
               "iId":_loc3_,
               "iDef":_loc4_
            });
            _loc1_++;
         }
         this.ListEnemies();
      }
      
      private function ShowDefValues() : void
      {
         trace(this.aEnemyDefense.length);
         var _loc1_:uint = 0;
         while(_loc1_ < this.aEnemyDefense.length)
         {
            trace(this.aEnemyDefense[_loc1_].iDef + " - " + (XmlData.aObject[this.aEnemyDefense[_loc1_].iId].NoMiniMap == undefined) + " - " + XmlData.aObject[this.aEnemyDefense[_loc1_].iId].@id);
            _loc1_++;
         }
      }
      
      private function ListEnemies() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc1_:String = "";
         this.mc_Content.addChild(this.m_BG);
         this.mc_TextHeaders = new Sprite();
         this.mc_Content.addChild(this.mc_TextHeaders);
         var _loc2_:BulkLoader = BulkLoader.getLoader("main");
         var _loc3_:XML = _loc2_.getXML("sorting_xml");
         var _loc4_:* = 0;
         while(_loc4_ < this.aEnemyDefense.length)
         {
            _loc5_ = uint(this.aEnemyDefense[_loc4_].iId);
            _loc6_ = 0;
            _loc7_ = uint(_loc3_.Group.length());
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = _loc3_.Group[_loc8_];
               _loc10_ = _loc9_.IDs;
               _loc11_ = _loc9_.Context;
               _loc12_ = _loc10_.split(",");
               _loc13_ = 0;
               while(_loc13_ < _loc12_.length)
               {
                  if(_loc12_[_loc13_] == _loc5_)
                  {
                     _loc6_ = uint(_loc7_ - _loc8_);
                     break;
                  }
                  _loc13_++;
               }
               _loc8_++;
            }
            _loc1_ += "0x" + _loc5_.toString(16) + ",";
            this.aEnemies.push(this.AddItem(10 + 43 * (_loc4_ % 18),8 + 43 * uint(_loc4_ / 18),_loc5_,_loc6_));
            _loc4_++;
         }
         this.sp_Content.update();
      }
      
      private function sHeaderTextString(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case "Group":
               if(param2 == "zzz")
               {
                  return "<b>Not Grouped</b>";
               }
               return "<b>" + param2 + "</b>";
               break;
            case "Terrain":
               if(param2 == "zzz")
               {
                  return "<b>No Terrain</b>";
               }
               return "<b>" + param2 + "</b>";
               break;
            default:
               return "";
         }
      }
      
      private function sHeaderText(param1:String, param2:Number) : String
      {
         var _loc3_:BulkLoader = null;
         var _loc4_:XML = null;
         var _loc5_:uint = 0;
         var _loc6_:XML = null;
         var _loc7_:* = false;
         var _loc8_:* = false;
         var _loc9_:* = null;
         switch(param1)
         {
            case "God":
               if(param2)
               {
                  return "<b>Counts as God</b>";
               }
               return "<b>Counts as Monster</b>";
               break;
            case "Cube":
               if(param2)
               {
                  return "<b>Counts as Cube</b>";
               }
               return "<b>Doesn\'t count as Cube</b>";
               break;
            case "Def":
               return "<b>" + param2 + " Defense</b>";
            case "EXP":
               return "<b>" + param2 + " EXP</b>";
            case "HP":
               return "<b>" + param2 + " HP</b>";
            case "OneHit":
               return "<b>" + param2 + "%</b> One-Hit Chance";
            case "Name":
               return "<b>" + String.fromCharCode(param2).toUpperCase() + "</b>";
            case "ID":
               return "";
            case "New":
               _loc3_ = BulkLoader.getLoader("main");
               _loc4_ = _loc3_.getXML("sorting_xml");
               if(!param2)
               {
                  return "Unsorted/Old";
               }
               _loc5_ = _loc4_.Group.length() - param2;
               _loc6_ = _loc4_.Group[_loc5_];
               _loc7_ = _loc6_.Date != undefined;
               _loc8_ = _loc6_.Build != undefined;
               _loc9_ = "<b>" + _loc6_.Context + "</b>";
               if(_loc7_ || _loc8_)
               {
                  _loc9_ += " (";
                  if(_loc7_)
                  {
                     _loc9_ += _loc6_.Date;
                  }
                  if(_loc7_ && _loc8_)
                  {
                     _loc9_ += " - ";
                  }
                  if(_loc8_)
                  {
                     _loc9_ += "Build " + _loc6_.Build;
                  }
                  _loc9_ += ")";
               }
               return _loc9_;
               break;
            default:
               return "";
         }
      }
      
      private function CreateComboBox() : void
      {
         this.ui.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         addChild(this.ui);
         this.m_cbSort = new ComboBox();
         this.m_cbSort.textField.setStyle("embedFonts",true);
         this.m_cbSort.textField.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_cbSort.textField.setStyle("textPadding",-4);
         this.m_cbSort.dropdownWidth = 150;
         this.m_cbSort.dropdown.setStyle("cellRenderer",CustomCellRenderer);
         this.m_cbSort.dropdown.rowHeight = 16;
         this.m_cbSort.setSize(150,17);
         this.m_cbSort.x = 5 + 2;
         this.m_cbSort.y = 4 + 56;
         this.m_cbSort.rowCount = 12;
         this.m_cbSort.addItem({
            "label":"Default List",
            "data":"Default"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: New",
            "data":"New"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: Name",
            "data":"Name"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: Group",
            "data":"Group"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: Terrain",
            "data":"Terrain"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: EXP",
            "data":"EXP"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: DEF",
            "data":"Def"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: HP",
            "data":"HP"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: Counts as God",
            "data":"God"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: Counts as Cube",
            "data":"Cube"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: One-Hit Chance",
            "data":"OneHit"
         });
         this.m_cbSort.addItem({
            "label":"Sort by: ID",
            "data":"ID"
         });
         this.m_cbSort.addEventListener(Event.CHANGE,this.onSortChange);
         this.m_cbSort.textField.y -= 10;
         this.m_cbSort.selectedIndex = 1;
         this.ui.addChild(this.m_cbSort);
         var _loc1_:Bitmap = this.CreateNewIcon(43 + 455 - 17 + 22 + 10 - 4,4 + 56 + 4,16);
         var _loc2_:Bitmap = this.CreateNewIcon(2 + 570 - 18 + 22 + 10 - 4,4 + 56 + 4,55);
         var _loc3_:Bitmap = this.CreateNewIcon(4 + 93 + 570 - 18 + 22 + 10 - 4,4 + 56 + 4,58);
         this.m_cbArmored = this.CreateNewCheckBox(0,0,"    Armored",true);
         this.m_cbBroken = this.CreateNewCheckBox(0,0,"    Armor Broken",true);
         this.m_cbCursed = this.CreateNewCheckBox(0,0,"    Cursed",true);
         var _loc4_:Sprite = new Sprite();
         _loc4_.x = 43 + 455 - 17 + 10;
         _loc4_.y = 4 + 56;
         _loc4_.scaleX = _loc4_.scaleY = 0.75;
         var _loc5_:Sprite = new Sprite();
         _loc5_.x = 2 + 570 - 18 + 10;
         _loc5_.y = 4 + 56;
         _loc5_.scaleX = _loc5_.scaleY = 0.75;
         var _loc6_:Sprite = new Sprite();
         _loc6_.x = 4 + 93 + 570 - 18 + 10;
         _loc6_.y = 4 + 56;
         _loc6_.scaleX = _loc6_.scaleY = 0.75;
         _loc4_.addChild(this.m_cbArmored);
         _loc5_.addChild(this.m_cbBroken);
         _loc6_.addChild(this.m_cbCursed);
         this.ui.addChild(_loc1_);
         this.ui.addChild(_loc2_);
         this.ui.addChild(_loc3_);
         this.ui.addChild(_loc4_);
         this.ui.addChild(_loc5_);
         this.ui.addChild(_loc6_);
         this.m_cbArmored.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbArmored.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbBroken.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbBroken.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         this.m_cbCursed.addEventListener(MouseEvent.MOUSE_OVER,this.OnUIOver);
         this.m_cbCursed.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIOut);
         var _loc7_:TextField = Tooltip.AddTextField(30,0,200,Constants.TEXT_FORMAT_STATUS_EFFECT_RED);
         _loc7_.text = XmlData.aEnemies.length + " Types";
         _loc7_.antiAliasType = "advanced";
         _loc7_.sharpness = 20;
         _loc7_.thickness = 0;
         var _loc8_:TextField = Tooltip.AddTextField(-360 + 3,0,50 / 0.75,Constants.TEXT_FORMAT_STATUS_EFFECT_RED);
         _loc8_.text = "Enemies:";
         _loc8_.antiAliasType = "advanced";
         _loc8_.sharpness = 20;
         _loc8_.thickness = 0;
         var _loc9_:Sprite = new Sprite();
         _loc9_.x = 715 - 2;
         _loc9_.y = 4 + 56;
         _loc9_.scaleX = _loc9_.scaleY = 0.75;
         _loc9_.addChild(_loc7_);
         _loc9_.addChild(_loc8_);
         this.ui.addChild(_loc9_);
      }
      
      private function CreateNewCheckBox(param1:Number, param2:Number, param3:String, param4:Boolean = false) : CheckBox
      {
         var _loc5_:* = new CheckBox();
         _loc5_.label = param3;
         _loc5_.textField.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.textField.antiAliasType = "advanced";
         _loc5_.textField.sharpness = 20;
         _loc5_.textField.thickness = 0;
         _loc5_.setStyle("embedFonts",true);
         if(param4)
         {
            _loc5_.setStyle("textFormat",Constants.TEXT_FORMAT_STATUS_EFFECT_RED);
         }
         else
         {
            _loc5_.setStyle("textFormat",Constants.TEXT_FORMAT_STATUS_EFFECT);
         }
         _loc5_.x = param1;
         _loc5_.y = param2;
         return _loc5_;
      }
      
      private function CreateNewIcon(param1:Number, param2:Number, param3:uint) : Bitmap
      {
         var _loc4_:Bitmap = SpriteParser.GetSprite("lofiInterface2",param3);
         _loc4_.x = param1;
         _loc4_.y = param2;
         _loc4_.filters = [Constants.BLACK_OUTLINE];
         return _loc4_;
      }
      
      private function onSortChange(param1:Event) : void
      {
         var _loc2_:String = this.m_cbSort.selectedItem.data;
         if(_loc2_ == "Name")
         {
            this.SortEnemiesName();
         }
         else if(_loc2_ == "Group" || _loc2_ == "Terrain")
         {
            this.SortEnemiesString(_loc2_);
         }
         else
         {
            this.SortEnemies(_loc2_);
         }
      }
      
      private function SortEnemiesString(param1:String) : void
      {
         var _loc3_:Enemy = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:TextField = null;
         while(this.mc_TextHeaders.numChildren > 0)
         {
            this.mc_TextHeaders.removeChildAt(0);
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.aEnemies)
         {
            _loc8_ = _loc3_.GetValueString(param1);
            _loc9_ = _loc3_.iID;
            _loc2_.push({
               "en":_loc3_,
               "sVal":_loc8_,
               "iID":_loc9_
            });
         }
         _loc2_.sortOn(["sVal","iID"],[Array.CASEINSENSITIVE,Array.NUMERIC]);
         _loc4_ = "";
         _loc5_ = 6;
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc7_].en;
            _loc8_ = _loc2_[_loc7_].sVal;
            if(_loc4_ != _loc8_)
            {
               if(_loc7_ != 0)
               {
                  _loc5_ += 43;
               }
               _loc10_ = Tooltip.AddTextField(4,_loc5_ - 5,600,Constants.TEXT_FORMAT_TT_HEADER_TIER);
               _loc10_.htmlText = this.sHeaderTextString(param1,_loc8_);
               _loc10_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
               this.mc_TextHeaders.addChild(_loc10_);
               _loc5_ += Math.ceil(_loc10_.height);
               _loc6_ = 0;
               _loc4_ = _loc8_;
            }
            if(_loc6_ >= 18)
            {
               _loc6_ = 0;
               _loc5_ += 43;
            }
            _loc3_.x = 10 + 43 * (_loc6_ % 18);
            _loc3_.y = _loc5_;
            _loc6_++;
            _loc7_++;
         }
         this.m_BG.graphics.clear();
         this.m_BG.graphics.beginFill(3355443,1);
         this.m_BG.graphics.drawRect(0,0,4,_loc5_ + 43);
         this.m_BG.graphics.endFill();
         this.sp_Content.update();
      }
      
      private function SortEnemiesName() : void
      {
         var _loc2_:Enemy = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:TextField = null;
         while(this.mc_TextHeaders.numChildren > 0)
         {
            this.mc_TextHeaders.removeChildAt(0);
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.aEnemies)
         {
            _loc7_ = _loc2_.GetName();
            _loc1_.push({
               "en":_loc2_,
               "sName":_loc7_
            });
         }
         _loc1_.sortOn(["sName"],[Array.CASEINSENSITIVE]);
         _loc3_ = 0;
         _loc4_ = 6;
         _loc5_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc6_].en;
            _loc8_ = Number(String(_loc1_[_loc6_].sName).toLowerCase().charCodeAt(0));
            if(_loc3_ < _loc8_)
            {
               if(_loc6_ != 0)
               {
                  _loc4_ += 43;
               }
               _loc9_ = Tooltip.AddTextField(4,_loc4_ - 5,600,Constants.TEXT_FORMAT_TT_HEADER_TIER);
               _loc9_.htmlText = this.sHeaderText("Name",_loc8_);
               _loc9_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
               this.mc_TextHeaders.addChild(_loc9_);
               _loc4_ += Math.ceil(_loc9_.height);
               _loc5_ = 0;
               _loc3_ = _loc8_;
            }
            if(_loc5_ >= 18)
            {
               _loc5_ = 0;
               _loc4_ += 43;
            }
            _loc2_.x = 10 + 43 * (_loc5_ % 18);
            _loc2_.y = _loc4_;
            _loc5_++;
            _loc6_++;
         }
         this.m_BG.graphics.clear();
         this.m_BG.graphics.beginFill(3355443,1);
         this.m_BG.graphics.drawRect(0,0,4,_loc4_ + 43);
         this.m_BG.graphics.endFill();
         this.sp_Content.update();
      }
      
      private function SortEnemies(param1:String) : void
      {
         var _loc3_:Enemy = null;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:* = undefined;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:TextField = null;
         while(this.mc_TextHeaders.numChildren > 0)
         {
            this.mc_TextHeaders.removeChildAt(0);
         }
         if(param1 == "Default")
         {
            _loc7_ = 0;
            while(_loc7_ < this.aEnemies.length)
            {
               this.aEnemies[_loc7_].x = 10 + 43 * (_loc7_ % 18);
               this.aEnemies[_loc7_].y = 4 + 6 + 43 * uint(_loc7_ / 18);
               _loc7_++;
            }
            this.m_BG.graphics.clear();
            this.m_BG.graphics.beginFill(3355443,1);
            this.m_BG.graphics.drawRect(0,0,4,8 - 2 + 43 * (uint(_loc7_ / 18) + 1));
            this.m_BG.graphics.endFill();
            this.sp_Content.update();
            return;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.aEnemies)
         {
            _loc8_ = _loc3_.GetValue(param1);
            _loc9_ = _loc3_.iID;
            _loc2_.push({
               "en":_loc3_,
               "fVal":_loc8_,
               "iID":_loc9_
            });
         }
         _loc2_.sortOn(["fVal","iID"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         if(param1 == "ID")
         {
            _loc2_.reverse();
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc2_[_loc7_].en.x = 10 + 43 * (_loc7_ % 18);
               _loc2_[_loc7_].en.y = 4 + 6 + 43 * uint(_loc7_ / 18);
               _loc7_++;
            }
            this.m_BG.graphics.clear();
            this.m_BG.graphics.beginFill(3355443,1);
            this.m_BG.graphics.drawRect(0,0,4,8 - 2 + 43 * (uint(_loc7_ / 18) + 1));
            this.m_BG.graphics.endFill();
            this.sp_Content.update();
            return;
         }
         _loc4_ = Number.POSITIVE_INFINITY;
         _loc5_ = 6;
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc7_].en;
            _loc8_ = Number(_loc2_[_loc7_].fVal);
            if(_loc4_ > _loc8_)
            {
               if(_loc7_ != 0)
               {
                  _loc5_ += 43;
               }
               _loc10_ = Tooltip.AddTextField(4,_loc5_ - 5,600,Constants.TEXT_FORMAT_TT_HEADER_TIER);
               _loc10_.htmlText = this.sHeaderText(param1,_loc8_);
               this.mc_TextHeaders.addChild(_loc10_);
               _loc5_ += Math.ceil(_loc10_.height);
               _loc6_ = 0;
               _loc4_ = _loc8_;
            }
            if(_loc6_ >= 18)
            {
               _loc6_ = 0;
               _loc5_ += 43;
            }
            _loc3_.x = 10 + 43 * (_loc6_ % 18);
            _loc3_.y = _loc5_;
            _loc6_++;
            _loc7_++;
         }
         this.m_BG.graphics.clear();
         this.m_BG.graphics.beginFill(3355443,1);
         this.m_BG.graphics.drawRect(0,0,4,_loc5_ + 43);
         this.m_BG.graphics.endFill();
         this.sp_Content.update();
      }
      
      private function OnUIOver(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = param1.currentTarget;
         if(_loc2_ == this.m_cbSort)
         {
            _loc3_ = "Sort all the things!";
         }
         else if(_loc2_ == this.m_cbArmored)
         {
            _loc3_ = "<b>Enemy Armored</b>\nDoubles enemy defense.";
         }
         else if(_loc2_ == this.m_cbBroken)
         {
            _loc3_ = "<b>Enemy Armor Broken</b>\nReduces enemy defense to 0.";
         }
         else if(_loc2_ == this.m_cbCursed)
         {
            _loc3_ = "<b>Enemy Cursed</b>\nIncreases all damage on enemies by 20%.\nCalculated after defense.";
         }
         if(_loc3_)
         {
            Tooltip.ShowDefault(_loc3_);
         }
      }
      
      private function OnUIOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
      
      public function get bCalcDef() : Boolean
      {
         return this.m_Calc.bCalcDef;
      }
      
      public function get bArmored() : Boolean
      {
         return this.m_cbArmored.selected;
      }
      
      public function get bBroken() : Boolean
      {
         return this.m_cbBroken.selected;
      }
      
      public function get bCursed() : Boolean
      {
         return this.m_cbCursed.selected;
      }
   }
}


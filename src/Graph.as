package
{
   import com.pfiffel.util.MathUtil;
   import fl.controls.Button;
   import fl.controls.ComboBox;
   import fl.controls.NumericStepper;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Graph extends Sprite
   {
      private const MAX_Y_DEFAULT:uint = 4000;
      
      private const ZOOM_TIER_1:uint = 50;
      
      private const ZOOM_TIER_2:uint = 250;
      
      private var aArrays:Array;
      
      private var aEnemiesWithDef:Array;
      
      private var m_fW:Number;
      
      private var m_fH:Number;
      
      private var m_fMainW:Number;
      
      private var m_fMainH:Number;
      
      private var m_iMin:int;
      
      private var m_iMax:int;
      
      private var m_Main:Sprite;
      
      private var m_Y:Sprite;
      
      private var m_Line:Sprite;
      
      private var m_iSpaceYT:Number = 8;
      
      private var m_iSpaceYB:Number = 40;
      
      private var m_iSpaceXL:Number = 40;
      
      private var m_iSpaceXR:Number = 10;
      
      private var m_CurrentComp:CharComposition;
      
      private var m_CharComps:Sprite;
      
      private var m_aComps:Array;
      
      private var m_aCompRemoveBtns:Array;
      
      private var m_OverlayCont:Sprite;
      
      private var m_aOverlays:Array;
      
      private var ZoomOverlay:Sprite;
      
      private var m_nsMinY:NumericStepper;
      
      private var m_nsMaxY:NumericStepper;
      
      private var m_btnReset:Button;
      
      private var m_btnFit:Button;
      
      private var m_cbAbilityOptions:ComboBox;
      
      private var m_iAbilityOption:int;
      
      private var SelectOverlay:Sprite;
      
      private var iZoomPos:int;
      
      private var bSelecting:Boolean = false;
      
      public function Graph(param1:Number, param2:Number)
      {
         var _loc8_:TextField = null;
         var _loc9_:Sprite = null;
         var _loc10_:Sprite = null;
         var _loc11_:Number = NaN;
         var _loc12_:Overlay = null;
         var _loc13_:TextField = null;
         this.aArrays = new Array();
         this.aEnemiesWithDef = new Array();
         this.m_Main = new Sprite();
         this.m_Y = new Sprite();
         this.m_Line = new Sprite();
         this.m_CharComps = new Sprite();
         this.m_aComps = new Array();
         this.m_aCompRemoveBtns = new Array();
         this.m_OverlayCont = new Sprite();
         this.m_aOverlays = new Array();
         this.ZoomOverlay = new Sprite();
         this.m_btnReset = new Button();
         this.m_btnFit = new Button();
         this.SelectOverlay = new Sprite();
         super();
         this.m_fW = param1;
         this.m_fH = param2;
         this.m_iAbilityOption = 1;
         this.GetDefValues();
         this.m_iMin = 0;
         this.m_iMax = this.MAX_Y_DEFAULT;
         this.m_Main.x = this.m_iSpaceXL;
         this.m_Main.y = this.m_iSpaceYT;
         this.m_fMainW = this.m_fW - this.m_iSpaceXL - this.m_iSpaceXR;
         this.m_fMainH = this.m_fH - this.m_iSpaceYB - this.m_iSpaceYT;
         var _loc3_:uint = 150;
         var _loc4_:Number = this.m_fMainW / _loc3_;
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(16711935,0);
         _loc5_.graphics.drawRect(0,0,this.m_fW,this.m_fH);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         this.m_Main.graphics.moveTo(0,0);
         this.m_Main.graphics.lineStyle(1,16777215,1,true);
         this.m_Main.graphics.lineTo(0,this.m_fMainH);
         this.m_Main.graphics.lineTo(this.m_fMainW,this.m_fMainH);
         this.m_Main.graphics.lineStyle(1,16777215,0.5,true);
         this.m_Main.graphics.lineTo(this.m_fMainW,0);
         this.m_Main.graphics.lineTo(0,0);
         var _loc6_:uint = 0;
         while(_loc6_ <= _loc3_)
         {
            if(_loc6_ % 5 == 0)
            {
               _loc13_ = Tooltip.AddTextField(_loc6_ * _loc4_ - 15,this.m_fMainH + 4 - 1,30,Constants.TEXT_FORMAT_GRAPH_CENTER);
               _loc13_.antiAliasType = "advanced";
               _loc13_.sharpness = 50;
               _loc13_.thickness = 0;
               _loc13_.text = String(_loc6_);
               this.m_Main.addChild(_loc13_);
            }
            this.m_Main.graphics.moveTo(_loc6_ * _loc4_,this.m_fMainH);
            this.m_Main.graphics.lineTo(_loc6_ * _loc4_,this.m_fMainH + 4);
            _loc11_ = 0;
            if(this.aEnemiesWithDef[_loc6_].length > 0)
            {
               _loc11_ = 0.25;
            }
            _loc12_ = new Overlay(_loc6_,_loc4_ + 1,this.m_fMainH,_loc11_);
            _loc12_.x = _loc6_ * _loc4_ - _loc4_ / 2;
            _loc12_.addEventListener(MouseEvent.MOUSE_OVER,this.OnDefOver);
            _loc12_.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
            this.m_OverlayCont.addChild(_loc12_);
            this.m_aOverlays.push(_loc12_);
            _loc6_++;
         }
         this.RedrawY();
         this.m_Main.addChild(this.m_Y);
         this.m_Y.mouseChildren = false;
         this.m_Y.mouseEnabled = false;
         var _loc7_:TextField = Tooltip.AddTextField(-50,this.m_fMainH + 20,40,Constants.TEXT_FORMAT_GRAPH_RIGHT);
         _loc7_.antiAliasType = "advanced";
         _loc7_.sharpness = 50;
         _loc7_.thickness = 0;
         _loc7_.text = "DPS";
         this.m_Main.addChild(_loc7_);
         _loc8_ = Tooltip.AddTextField(this.m_fMainW / 2,this.m_fMainH + 20,0,Constants.TEXT_FORMAT_GRAPH_CENTER);
         _loc8_.antiAliasType = "advanced";
         _loc8_.sharpness = 50;
         _loc8_.thickness = 0;
         _loc8_.text = "Defense";
         _loc8_.x -= int(_loc8_.width / 2);
         this.m_Main.addChild(_loc8_);
         addChild(this.m_Main);
         _loc9_ = new Sprite();
         _loc9_.graphics.beginFill(16711680,1);
         _loc9_.graphics.drawRect(0,-1,this.m_fMainW + 1,this.m_fMainH + 2);
         _loc9_.graphics.endFill();
         this.m_Main.addChild(_loc9_);
         _loc10_ = new Sprite();
         _loc10_.graphics.beginFill(16711680,1);
         _loc10_.graphics.drawRect(-4,1,this.m_fMainW + 8,this.m_fMainH);
         _loc10_.graphics.endFill();
         this.m_Main.addChild(_loc10_);
         this.m_Line.mask = _loc9_;
         this.m_OverlayCont.mask = _loc10_;
         this.m_Main.addChild(this.m_OverlayCont);
         this.m_Main.addChild(this.m_Line);
         this.ZoomOverlay.graphics.beginFill(255,0);
         this.ZoomOverlay.graphics.drawRect(-this.m_iSpaceXL,0,this.m_iSpaceXL - 4,this.m_fMainH);
         this.ZoomOverlay.graphics.endFill();
         this.ZoomOverlay.addEventListener(MouseEvent.MOUSE_DOWN,this.OnZoomDown);
         addEventListener(MouseEvent.MOUSE_UP,this.OnZoomUp);
         addEventListener(MouseEvent.MOUSE_MOVE,this.OnZoomSelect);
         addEventListener(MouseEvent.ROLL_OUT,this.OnZoomUp);
         this.ZoomOverlay.addEventListener(MouseEvent.MOUSE_OVER,this.OnZoomOver);
         this.ZoomOverlay.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.m_Main.addChild(this.SelectOverlay);
         this.m_Main.addChild(this.ZoomOverlay);
         this.m_Line.mouseEnabled = false;
         this.m_Main.addChild(this.m_CharComps);
         this.m_CharComps.x = this.m_fMainW - 137 - 18 + 1;
         this.m_CharComps.y = 8;
         filters = [Constants.GLOW_BLACK_TT_CONTENT];
         this.InitScroll(this.MAX_Y_DEFAULT);
         this.InitAbilityToggle();
      }
      
      public function OnZoomDown(param1:MouseEvent) : *
      {
         if(!this.bSelecting)
         {
            this.iZoomPos = this.ZoomOverlay.mouseY;
            this.bSelecting = true;
         }
      }
      
      public function OnZoomSelect(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.bSelecting)
         {
            _loc2_ = this.m_iMax / 100 - this.m_iMin / 100;
            _loc3_ = this.m_fMainH / _loc2_;
            _loc4_ = this.ZoomOverlay.mouseY;
            _loc5_ = Math.min(this.iZoomPos,_loc4_);
            _loc6_ = Math.max(this.iZoomPos,_loc4_);
            _loc5_ = Math.round(Math.max(_loc5_,0) / _loc3_);
            _loc6_ = Math.round(Math.min(_loc6_,this.m_fMainH) / _loc3_);
            this.SelectOverlay.graphics.clear();
            this.SelectOverlay.graphics.lineStyle(1,16762880,1);
            this.SelectOverlay.graphics.beginFill(16762880,0.5);
            this.SelectOverlay.graphics.drawRect(0,_loc5_ * _loc3_,this.m_fMainW,(_loc6_ - _loc5_) * _loc3_);
            this.SelectOverlay.graphics.endFill();
         }
      }
      
      public function OnZoomUp(param1:MouseEvent) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         if(this.bSelecting)
         {
            _loc2_ = this.ZoomOverlay.mouseY;
            this.bSelecting = false;
            this.SelectOverlay.graphics.clear();
            _loc3_ = this.m_iMax / 100 - this.m_iMin / 100;
            _loc4_ = this.m_fMainH / _loc3_;
            _loc5_ = this.ZoomOverlay.mouseY;
            _loc6_ = Math.min(this.iZoomPos,_loc5_);
            _loc7_ = Math.max(this.iZoomPos,_loc5_);
            _loc6_ = Math.round(Math.max(_loc6_,0) / _loc4_);
            _loc7_ = Math.round(Math.min(_loc7_,this.m_fMainH) / _loc4_);
            _loc8_ = uint(this.m_iMax - _loc7_ * 100);
            _loc9_ = uint(this.m_iMax - _loc6_ * 100);
            if(_loc9_ > _loc8_)
            {
               this.m_iMin = _loc8_;
               this.m_iMax = _loc9_;
               this.RefreshZoom();
            }
         }
      }
      
      private function RefreshZoom() : void
      {
         if(this.m_iMin == this.m_iMax)
         {
            this.m_iMin -= 100;
         }
         this.m_nsMinY.value = this.m_iMin;
         this.m_nsMaxY.value = this.m_iMax;
         this.m_nsMinY.maximum = this.m_nsMaxY.value - 100;
         this.RedrawY();
         this.RedrawGraphs();
      }
      
      private function OnZoomOver(param1:MouseEvent) : void
      {
         var _loc2_:String = "Hold and drag to zoom in on a desired range";
         Tooltip.ShowDefault(_loc2_);
      }
      
      public function InitAbilityToggle() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_cbAbilityOptions = new ComboBox();
         this.m_cbAbilityOptions.textField.setStyle("embedFonts",true);
         this.m_cbAbilityOptions.textField.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
         this.m_cbAbilityOptions.textField.setStyle("textPadding",-4);
         this.m_cbAbilityOptions.dropdownWidth = 140;
         this.m_cbAbilityOptions.dropdown.setStyle("cellRenderer",CustomCellRenderer);
         this.m_cbAbilityOptions.dropdown.rowHeight = 18;
         this.m_cbAbilityOptions.setSize(140,16);
         this.m_cbAbilityOptions.addItem({
            "label":"Separate DPS Graphs",
            "data":1
         });
         this.m_cbAbilityOptions.addItem({
            "label":"Combine DPS Graphs",
            "data":2
         });
         this.m_cbAbilityOptions.addItem({
            "label":"Hide Ability DPS",
            "data":3
         });
         this.m_cbAbilityOptions.addItem({
            "label":"Hide Weapon DPS",
            "data":4
         });
         this.m_cbAbilityOptions.addEventListener(Event.CHANGE,this.onAbilityOptionChange);
         this.m_cbAbilityOptions.addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         this.m_cbAbilityOptions.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.m_cbAbilityOptions.textField.y -= 10;
         _loc1_.addChild(this.m_cbAbilityOptions);
         _loc1_.y = this.m_fMainH + 20;
         _loc1_.x = 800 - 140 - 40 - 4;
         this.m_Main.addChild(_loc1_);
      }
      
      private function onAbilityOptionChange(param1:Event) : void
      {
         this.m_iAbilityOption = this.m_cbAbilityOptions.selectedItem.data;
         this.RedrawGraphs();
      }
      
      public function InitScroll(param1:uint) : void
      {
         var _loc2_:Sprite = new Sprite();
         this.m_nsMinY = new NumericStepper();
         this.m_nsMaxY = new NumericStepper();
         this.m_nsMinY.setStyle("embedFonts",true);
         this.m_nsMaxY.setStyle("embedFonts",true);
         this.m_nsMinY.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_nsMaxY.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_nsMinY.addEventListener("change",this.OnScrollInput);
         this.m_nsMaxY.addEventListener("change",this.OnScrollInput);
         _loc2_.addChild(this.m_nsMinY);
         _loc2_.addChild(this.m_nsMaxY);
         this.m_nsMinY.addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         this.m_nsMinY.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.m_nsMaxY.addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         this.m_nsMaxY.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.m_nsMaxY.minimum = 100;
         this.m_nsMinY.minimum = 0;
         this.m_nsMaxY.maximum = 100000;
         this.m_nsMinY.stepSize = this.m_nsMaxY.stepSize = 100;
         this.m_nsMinY.value = 0;
         this.m_nsMaxY.value = param1;
         this.m_nsMinY.maximum = this.m_nsMaxY.value - 100;
         _loc2_.y = this.m_fMainH + 20;
         _loc2_.x = -5;
         this.m_nsMaxY.x = 74;
         this.m_nsMinY.width = this.m_nsMaxY.width = 70;
         _loc2_.scaleY = _loc2_.scaleX = 0.75;
         this.m_Main.addChild(_loc2_);
         this.m_btnReset.x = 74 + 74;
         this.m_btnReset.label = "Reset";
         this.m_btnReset.setStyle("embedFonts",true);
         this.m_btnReset.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnReset.addEventListener(MouseEvent.CLICK,this.OnResetClick);
         this.m_btnReset.width = 60;
         this.m_btnReset.addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         this.m_btnReset.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         _loc2_.addChild(this.m_btnReset);
         this.m_btnFit.x = 74 + 74 + 64;
         this.m_btnFit.label = "Fit";
         this.m_btnFit.setStyle("embedFonts",true);
         this.m_btnFit.setStyle("textFormat",Constants.TEXT_FORMAT_BLACK);
         this.m_btnFit.addEventListener(MouseEvent.CLICK,this.OnFitClick);
         this.m_btnFit.width = 40;
         this.m_btnFit.addEventListener(MouseEvent.MOUSE_OVER,this.OnOver);
         this.m_btnFit.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         _loc2_.addChild(this.m_btnFit);
      }
      
      public function OnResetClick(param1:MouseEvent) : *
      {
         this.m_iMin = 0;
         this.m_iMax = this.MAX_Y_DEFAULT;
         this.RefreshZoom();
      }
      
      public function OnScrollInput(param1:Event) : *
      {
         this.m_nsMinY.maximum = this.m_nsMaxY.value - 100;
         this.m_iMin = this.m_nsMinY.value;
         this.m_iMax = this.m_nsMaxY.value;
         this.RedrawY();
         this.RedrawGraphs();
      }
      
      public function RedrawY() : void
      {
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:TextField = null;
         while(this.m_Y.numChildren > 0)
         {
            this.m_Y.removeChildAt(0);
         }
         this.m_Y.graphics.clear();
         var _loc1_:uint = this.m_iMin / 100;
         var _loc2_:uint = this.m_iMax / 100;
         var _loc3_:int = _loc2_ - _loc1_;
         var _loc4_:Number = this.m_fMainH / _loc3_;
         var _loc5_:uint = 0;
         while(_loc5_ <= _loc3_)
         {
            _loc6_ = (_loc5_ + _loc1_) % 5 == 0;
            _loc7_ = (_loc5_ + _loc1_) % 25 == 0;
            if(_loc3_ <= this.ZOOM_TIER_1 || _loc6_ && _loc3_ <= this.ZOOM_TIER_2 || _loc7_)
            {
               _loc8_ = Tooltip.AddTextField(-4 - this.m_iSpaceXL,this.m_fMainH - _loc5_ * _loc4_,this.m_iSpaceXL,Constants.TEXT_FORMAT_GRAPH_RIGHT);
               _loc8_.antiAliasType = "advanced";
               _loc8_.sharpness = 50;
               _loc8_.thickness = 0;
               _loc8_.text = String((_loc5_ + _loc1_) * 100);
               _loc8_.y -= int(_loc8_.height / 2);
               this.m_Y.addChild(_loc8_);
            }
            if(_loc3_ <= this.ZOOM_TIER_2 || _loc6_)
            {
               this.m_Y.graphics.lineStyle(1,16777215,1,true);
               this.m_Y.graphics.moveTo(0,this.m_fMainH - _loc5_ * _loc4_);
               this.m_Y.graphics.lineTo(-3,this.m_fMainH - _loc5_ * _loc4_);
            }
            if(_loc6_ && _loc5_ < _loc3_ && _loc3_ <= this.ZOOM_TIER_2 || _loc7_)
            {
               this.m_Y.graphics.lineStyle(1,16777215,0.25,true);
               this.m_Y.graphics.moveTo(0,this.m_fMainH - _loc5_ * _loc4_);
               this.m_Y.graphics.lineTo(this.m_fMainW,this.m_fMainH - _loc5_ * _loc4_);
            }
            _loc5_++;
         }
      }
      
      public function ShowComps() : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         while(this.m_CharComps.numChildren > 0)
         {
            this.m_CharComps.removeChildAt(0);
         }
         var _loc1_:int = int(this.m_aComps.length);
         var _loc2_:Sprite = this.m_CurrentComp.toSprite();
         _loc2_.y = (_loc2_.height + 2) * _loc1_;
         this.m_CharComps.addChild(_loc2_);
         while(_loc1_ > 0)
         {
            _loc1_--;
            _loc3_ = CharComposition(this.m_aComps[_loc1_]).toSprite();
            _loc3_.y = (_loc3_.height + 2) * _loc1_;
            this.m_CharComps.addChild(_loc3_);
            _loc4_ = this.m_aCompRemoveBtns[_loc1_];
            _loc4_.x = -20 - 4;
            _loc4_.y = (_loc3_.height + 2) * _loc1_;
            this.m_CharComps.addChild(_loc4_);
         }
      }
      
      private function CreateRemoveButton() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Bitmap = SpriteParser.GetSprite("lofiInterfaceBig",8);
         _loc2_.filters = [Constants.BLACK_OUTLINE];
         _loc2_.scaleX = _loc2_.scaleY = 1;
         _loc1_.addChild(_loc2_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.OnRemoveClick);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.OnRemoveOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         return _loc1_;
      }
      
      private function OnRemoveOver(param1:MouseEvent) : void
      {
         Tooltip.ShowDefault("Remove");
      }
      
      private function OnRemoveClick(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = Sprite(param1.currentTarget);
         _loc2_.removeEventListener(MouseEvent.CLICK,this.OnRemoveClick);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.OnRemoveOver);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         var _loc3_:int = int(this.m_aComps.length);
         while(_loc3_ > 0)
         {
            _loc3_--;
            if(_loc2_ == this.m_aCompRemoveBtns[_loc3_])
            {
               this.m_aComps.splice(_loc3_,1);
               this.m_aCompRemoveBtns.splice(_loc3_,1);
            }
         }
         this.ShowComps();
         this.RedrawGraphs();
      }
      
      public function ChangeCurrentGraph(param1:CharComposition) : *
      {
         this.m_CurrentComp = param1;
         var _loc2_:int = Math.ceil(param1.aDPS[0] / 100) * 100;
         this.m_iMax = Math.max(this.m_iMax,_loc2_);
         this.RefreshZoom();
         this.ShowComps();
      }
      
      public function AddCompGraph(param1:CharComposition) : *
      {
         this.m_aComps.push(param1);
         this.m_aCompRemoveBtns.push(this.CreateRemoveButton());
         this.ShowComps();
         this.RedrawGraphs();
      }
      
      public function OnFitClick(param1:MouseEvent) : *
      {
         var _loc5_:int = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = Number.POSITIVE_INFINITY;
         var _loc4_:CharComposition = this.m_CurrentComp;
         if(this.m_iAbilityOption == 2)
         {
            _loc2_ = Math.max(_loc2_,Math.ceil((_loc4_.GetDPS(0) + _loc4_.GetAbilDPS(0)) / 100) * 100);
            _loc3_ = Math.min(_loc3_,Math.floor((_loc4_.GetDPS(150) + _loc4_.GetAbilDPS(150)) / 100) * 100);
         }
         else if(this.m_iAbilityOption != 4)
         {
            _loc2_ = Math.max(_loc2_,Math.ceil(_loc4_.GetDPS(0) / 100) * 100);
            _loc3_ = Math.min(_loc3_,Math.floor(_loc4_.GetDPS(150) / 100) * 100);
         }
         if((this.m_iAbilityOption == 1 || this.m_iAbilityOption == 4) && this.m_iAbilityOption != 3)
         {
            _loc2_ = Math.max(_loc2_,Math.ceil(_loc4_.GetAbilDPS(0) / 100) * 100);
            _loc3_ = Math.min(_loc3_,Math.floor(_loc4_.GetAbilDPS(150) / 100) * 100);
         }
         _loc5_ = int(this.m_aComps.length);
         while(_loc5_ > 0)
         {
            _loc5_--;
            _loc4_ = this.m_aComps[_loc5_];
            if(this.m_iAbilityOption == 2)
            {
               _loc2_ = Math.max(_loc2_,Math.ceil((_loc4_.GetDPS(0) + _loc4_.GetAbilDPS(0)) / 100) * 100);
               _loc3_ = Math.min(_loc3_,Math.floor((_loc4_.GetDPS(150) + _loc4_.GetAbilDPS(150)) / 100) * 100);
            }
            else if(this.m_iAbilityOption != 4)
            {
               _loc2_ = Math.max(_loc2_,Math.ceil(_loc4_.GetDPS(0) / 100) * 100);
               _loc3_ = Math.min(_loc3_,Math.floor(_loc4_.GetDPS(150) / 100) * 100);
            }
            if((this.m_iAbilityOption == 1 || this.m_iAbilityOption == 4) && this.m_iAbilityOption != 3)
            {
               _loc2_ = Math.max(_loc2_,Math.ceil(_loc4_.GetAbilDPS(0) / 100) * 100);
               _loc3_ = Math.min(_loc3_,Math.floor(_loc4_.GetAbilDPS(150) / 100) * 100);
            }
         }
         this.m_iMin = _loc3_;
         this.m_iMax = _loc2_;
         this.RefreshZoom();
      }
      
      public function DrawGraph(param1:CharComposition) : *
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = 150;
         var _loc3_:Number = this.m_fMainW / _loc2_;
         var _loc4_:Number = this.m_fMainH / (this.m_iMax - this.m_iMin);
         if(this.m_iAbilityOption == 2)
         {
            _loc5_ = 0;
            this.m_Line.graphics.moveTo(_loc5_,this.m_fMainH - (param1.aDPS[_loc5_] + param1.GetAbilDPS(_loc5_) - this.m_iMin) * _loc4_);
            while(_loc5_ < 150)
            {
               _loc5_++;
               this.m_Line.graphics.lineStyle(2,param1.iColor);
               this.m_Line.graphics.lineTo(_loc5_ * _loc3_,this.m_fMainH - (param1.aDPS[_loc5_] + param1.GetAbilDPS(_loc5_) - this.m_iMin) * _loc4_);
            }
         }
         else if(this.m_iAbilityOption != 4)
         {
            _loc5_ = 0;
            this.m_Line.graphics.moveTo(_loc5_,this.m_fMainH - (param1.aDPS[_loc5_] - this.m_iMin) * _loc4_);
            while(_loc5_ < 150)
            {
               _loc5_++;
               this.m_Line.graphics.lineStyle(2,param1.iColor);
               this.m_Line.graphics.lineTo(_loc5_ * _loc3_,this.m_fMainH - (param1.aDPS[_loc5_] - this.m_iMin) * _loc4_);
            }
         }
         if((this.m_iAbilityOption == 1 || this.m_iAbilityOption == 4) && this.m_iAbilityOption != 3)
         {
            _loc6_ = 0;
            this.m_Line.graphics.moveTo(_loc6_,this.m_fMainH - (param1.GetAbilDPS(_loc6_) - this.m_iMin) * _loc4_);
            while(_loc6_ < 150)
            {
               _loc6_++;
               this.m_Line.graphics.lineStyle(1,param1.iColor,1);
               this.m_Line.graphics.lineTo(_loc6_ * _loc3_,this.m_fMainH - (param1.GetAbilDPS(_loc6_) - this.m_iMin) * _loc4_);
            }
         }
      }
      
      public function RedrawGraphs() : void
      {
         this.m_Line.graphics.clear();
         this.DrawGraph(this.m_CurrentComp);
         var _loc1_:int = int(this.m_aComps.length);
         while(_loc1_ > 0)
         {
            _loc1_--;
            this.DrawGraph(this.m_aComps[_loc1_]);
         }
      }
      
      private function GetDefValues() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ <= 150)
         {
            this.aEnemiesWithDef[_loc1_] = new Array();
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < XmlData.aEnemies.length)
         {
            _loc3_ = uint(XmlData.aEnemies[_loc2_].@type);
            _loc4_ = XmlData.aEnemies[_loc2_].@id;
            _loc5_ = uint(XmlData.aEnemies[_loc2_].Defense);
            _loc5_ = 0;
            if(XmlData.aEnemies[_loc2_].Defense != undefined)
            {
               _loc5_ = uint(XmlData.aEnemies[_loc2_].Defense);
            }
            if(_loc5_ <= 150)
            {
               this.aEnemiesWithDef[_loc5_].push(XmlData.aEnemies[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function CreateEnemyList(param1:uint) : Sprite
      {
         var _loc4_:RotMGSprite = null;
         var _loc2_:Sprite = new Sprite();
         var _loc3_:* = 0;
         while(_loc3_ < this.aEnemiesWithDef[param1].length)
         {
            _loc4_ = new RotMGSprite(this.aEnemiesWithDef[param1][_loc3_],2);
            _loc4_.x = 22 * (_loc3_ % 18);
            _loc4_.y = 22 * uint(_loc3_ / 18);
            _loc2_.addChild(_loc4_);
            _loc3_++;
         }
         _loc2_.filters = [Constants.BLACK_OUTLINE];
         return _loc2_;
      }
      
      private function OnDefOver(param1:MouseEvent) : void
      {
         var _loc8_:Sprite = null;
         var _loc9_:int = 0;
         var _loc10_:CharComposition = null;
         var _loc11_:Sprite = null;
         var _loc12_:TextField = null;
         var _loc13_:TextField = null;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:TextField = null;
         var _loc17_:Sprite = null;
         var _loc2_:uint = Overlay(param1.currentTarget).m_iDef;
         var _loc3_:Number = 0;
         var _loc4_:Sprite = new Sprite();
         _loc4_.filters = [Constants.GLOW_BLACK_TT_CONTENT];
         var _loc5_:TextField = Tooltip.AddTextField(2,_loc3_ - 2,0,Constants.TEXT_FORMAT_TT_HEADER);
         _loc5_.htmlText = "Defense: " + _loc2_;
         _loc4_.addChild(_loc5_);
         _loc3_ += Math.ceil(_loc5_.height) + 6;
         var _loc6_:Array = new Array();
         var _loc7_:int = int(this.m_aComps.length);
         while(_loc7_ > 0)
         {
            _loc7_--;
            _loc6_.push({
               "Comp":this.m_aComps[_loc7_],
               "iDPS":this.m_aComps[_loc7_].GetDPS(_loc2_)
            });
         }
         _loc6_.push({
            "Comp":this.m_CurrentComp,
            "iDPS":this.m_CurrentComp.GetDPS(_loc2_)
         });
         _loc6_.sortOn(["iDPS"],[Array.NUMERIC]);
         _loc8_ = new Sprite();
         _loc9_ = int(_loc6_.length);
         while(_loc9_ > 0)
         {
            _loc9_--;
            _loc10_ = _loc6_[_loc9_].Comp;
            _loc11_ = _loc10_.toSprite();
            _loc11_.x = 8;
            _loc11_.y = _loc3_;
            _loc8_.addChild(_loc11_);
            _loc12_ = Tooltip.AddTextField(145 + 18,_loc3_ - 2 - 6,120,Constants.TEXT_FORMAT_WHITE_SMALL);
            _loc12_.htmlText = "Av. DPS: <b>" + MathUtil.Round(_loc10_.GetDPS(_loc2_),2) + "</b>";
            _loc4_.addChild(_loc12_);
            _loc13_ = Tooltip.AddTextField(145 + 18,_loc3_ - 2 + 6,120,Constants.TEXT_FORMAT_WHITE_SMALL);
            _loc13_.htmlText = "Abil. DPS: <b>" + MathUtil.Round(_loc10_.GetAbilDPS(_loc2_),2) + "</b>";
            _loc4_.addChild(_loc13_);
            _loc14_ = Tooltip.AddTextField(260 + 18,_loc3_ - 2 - 6,120,Constants.TEXT_FORMAT_WHITE_SMALL);
            _loc14_.htmlText = "Av. Hit (x" + _loc10_.GetProjectiles() + "): <b>" + MathUtil.Round(_loc10_.GetDMG(_loc2_),2) + "</b>";
            _loc4_.addChild(_loc14_);
            _loc15_ = Tooltip.AddTextField(260 + 18,_loc3_ - 2 + 6,120,Constants.TEXT_FORMAT_WHITE_SMALL);
            _loc15_.htmlText = "Hits / Second: <b>" + MathUtil.Round(_loc10_.GetHPS(),3) + "</b>";
            _loc4_.addChild(_loc15_);
            _loc3_ += Math.ceil(_loc11_.height) + 4;
         }
         _loc4_.addChild(_loc8_);
         if(this.aEnemiesWithDef[_loc2_].length)
         {
            _loc16_ = Tooltip.AddTextField(2,_loc3_ - 2,300,Constants.TEXT_FORMAT_WHITE);
            _loc16_.htmlText = "Enemies:";
            _loc4_.addChild(_loc16_);
            _loc3_ += Math.ceil(_loc16_.height) + 2;
            _loc17_ = this.CreateEnemyList(_loc2_);
            _loc17_.x = 4;
            _loc17_.y = _loc3_ + 2;
            _loc4_.addChild(_loc17_);
         }
         Tooltip.ShowNew(_loc4_);
      }
      
      private function OnOver(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = param1.currentTarget;
         if(_loc2_ == this.m_nsMinY)
         {
            _loc3_ = "Set DPS minimum";
         }
         else if(_loc2_ == this.m_nsMaxY)
         {
            _loc3_ = "Set DPS maximum";
         }
         else if(_loc2_ == this.m_btnReset)
         {
            _loc3_ = "Reset zoom to defaults:\n0 to " + this.MAX_Y_DEFAULT;
         }
         else if(_loc2_ == this.m_btnFit)
         {
            _loc3_ = "Fit to graphs";
         }
         else if(_loc2_ == this.m_cbAbilityOptions)
         {
            _loc3_ = "Select Weapon DPS and Ability DPS graph drawing options";
         }
         if(_loc3_)
         {
            Tooltip.ShowDefault(_loc3_);
         }
      }
      
      private function OnOut(param1:MouseEvent) : void
      {
         Tooltip.Hide();
      }
   }
}


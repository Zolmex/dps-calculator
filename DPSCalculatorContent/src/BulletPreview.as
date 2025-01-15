package
{
   import com.pfiffel.util.MathUtil;
   import fl.controls.CheckBox;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import shared.math.Vec2;
   
   public class BulletPreview extends Sprite
   {
      public static const FRAMES_PER_SECOND:uint = 60;
      
      public static const FRAMES_PER_TICK:uint = 12;
      
      private static const PARTICLE_SPAWN:uint = 2;
      
      private static const OFFSET_BOT_Y:int = 4 * 50;
      
      private static const OFFSET_BOT_X:int = -5 * 50;
      
      private var m_iTick:int = 12;
      
      private var m_bMouseDown:Boolean;
      
      private var m_fFireCooldown:Number;
      
      private var m_fHitsPerSec:Number;
      
      private var m_aBullets:Vector.<Bullet>;
      
      private var m_aAbilBullets:Vector.<Bullet>;
      
      private var m_aParticles:Vector.<Particle>;
      
      private var m_xmlWeapon:XML;
      
      private var m_xmlBullet:XML;
      
      private var m_xmlAbil:XML;
      
      private var m_xmlAbilBullet:XML;
      
      private var m_iSineOffset:int;
      
      private var m_iPara:int;
      
      private var m_fRotationAbil:Number;
      
      private var m_fRotation:Number;
      
      private var m_fAbilRotation:Number;
      
      private var m_fItemRotation:Number;
      
      private var m_RangeIndicator:Sprite;
      
      private var m_AbilRangeIndicator:Sprite;
      
      private var m_bOriginBot:Boolean = false;
      
      private var m_WepEdit:WeaponEditor;
      
      private var m_BulletTraj:Sprite;
      
      private var m_Stage:Stage;
      
      private var lastMouse:Point;
      
      private var m_bAutoFire:Boolean = false;
      
      private var cbAutoFire:CheckBox;
      
      private var cbShowPath:CheckBox;
      
      private var cbOffcent:CheckBox;
      
      public function BulletPreview(param1:Stage, param2:WeaponEditor)
      {
         var _loc6_:Bitmap = null;
         super();
         this.m_WepEdit = param2;
         this.m_WepEdit.addEventListener("update",this.OnWepUpdate);
         this.m_Stage = param1;
         this.m_fFireCooldown = 1;
         this.m_aBullets = new Vector.<Bullet>();
         this.m_aParticles = new Vector.<Particle>();
         this.m_aAbilBullets = new Vector.<Bullet>();
         this.lastMouse = new Point();
         GameTime.getInstance().addEventListener("timer",this.Step);
         this.m_bMouseDown = false;
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         this.m_Stage.addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(3355443,1);
         _loc3_.graphics.drawRect(0,56 + 1,800 + 200,600 - 56 + 1);
         _loc3_.graphics.endFill();
         _loc3_.x = -400;
         _loc3_.y = -300 - 56 / 2;
         addChild(_loc3_);
         var _loc4_:int = 16 * 12;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = SpriteParser.GetSprite("lofiEnvironment",6);
            _loc6_.width = 50;
            _loc6_.height = 50;
            _loc6_.x = -300 + _loc5_ % 16 * 50;
            _loc6_.y = -300 + int(_loc5_ / 16) * 50;
            addChild(_loc6_);
            _loc5_++;
         }
         this.m_RangeIndicator = new Sprite();
         this.m_AbilRangeIndicator = new Sprite();
         addChild(this.m_AbilRangeIndicator);
         addChild(this.m_RangeIndicator);
         this.m_BulletTraj = new Sprite();
         addChild(this.m_BulletTraj);
         this.m_BulletTraj.visible = false;
         this.m_Stage.addEventListener(KeyboardEvent.KEY_DOWN,this.OnKeyDown);
         this.cbAutoFire = UtilUI.CreateCheckBox(-300 - 1,-300 + 56 / 2 - 1,"Toggle Autofire: T",this.OnCheckAutoFire,Constants.TEXT_FORMAT_WHITE_MAIN);
         addChild(this.cbAutoFire);
         this.cbAutoFire.filters = [Constants.GLOW_BLACK_OBJECT];
         this.cbShowPath = UtilUI.CreateCheckBox(-300 - 1,-300 + 56 / 2 - 1 + 18,"Show Bullet Path: R",this.OnCheckShowPath,Constants.TEXT_FORMAT_WHITE_MAIN);
         addChild(this.cbShowPath);
         this.cbShowPath.filters = [Constants.GLOW_BLACK_OBJECT];
         this.cbOffcent = UtilUI.CreateCheckBox(-300 - 1,-300 + 56 / 2 - 1 + 18 * 2,"Offcenter: X",this.OnCheckOffcenter,Constants.TEXT_FORMAT_WHITE_MAIN);
         addChild(this.cbOffcent);
         this.cbOffcent.filters = [Constants.GLOW_BLACK_OBJECT];
      }
      
      private function OnKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.X:
               if(this.m_WepEdit.FocusFree())
               {
                  this.ResetOrigin();
               }
               break;
            case Keyboard.SPACE:
               if(this.m_WepEdit.FocusFree())
               {
                  this.UseAbility();
               }
               break;
            case Keyboard.W:
               if(DPSCalculator.TESTING)
               {
                  if(this.m_WepEdit.FocusFree())
                  {
                     this.m_WepEdit.Reload();
                  }
               }
               break;
            case Keyboard.R:
               if(this.m_WepEdit.FocusFree())
               {
                  this.ToggleShowTraj();
               }
               break;
            case Keyboard.T:
               if(this.m_WepEdit.FocusFree())
               {
                  this.ToggleAutoFire();
                  break;
               }
         }
      }
      
      private function OnCheckAutoFire(param1:MouseEvent) : void
      {
         this.m_bAutoFire = this.cbAutoFire.selected;
      }
      
      private function OnCheckShowPath(param1:MouseEvent) : void
      {
         this.m_BulletTraj.visible = this.cbShowPath.selected;
      }
      
      private function OnCheckOffcenter(param1:MouseEvent) : void
      {
         this.m_bOriginBot = this.cbOffcent.selected;
         this.UpdateRangeAbil();
         this.UpdateRangeWep();
         this.DrawBulletTrajectory();
      }
      
      private function ToggleAutoFire() : void
      {
         this.m_bAutoFire = this.m_bAutoFire ? false : true;
         this.cbAutoFire.selected = false;
      }
      
      public function Step(param1:TimerEvent) : void
      {
         this.StepBullets();
      }
      
      public function AddBullet(param1:Bullet) : void
      {
         this.m_aBullets.push(param1);
         addChild(param1);
      }
      
      public function AddParticle(param1:Particle) : void
      {
         this.m_aParticles.push(param1);
         addChild(param1);
      }
      
      private function UpdateRangeAbil() : void
      {
         if(this.m_xmlAbilBullet != null)
         {
            this.UpdateRange(this.m_xmlAbil,this.m_AbilRangeIndicator,13395456,6697728);
         }
         else
         {
            this.m_AbilRangeIndicator.graphics.clear();
         }
      }
      
      private function UpdateRangeWep() : void
      {
         this.UpdateRange(this.m_xmlWeapon,this.m_RangeIndicator,52428,34952);
      }
      
      private function UpdateRange(param1:XML, param2:Sprite, param3:uint, param4:uint) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:* = undefined;
         var _loc10_:Number = NaN;
         var _loc5_:Number = param1.Projectile.LifetimeMS * param1.Projectile.Speed / 10000;
         param2.graphics.clear();
         param2.graphics.lineStyle(1,param3,1);
         param2.graphics.drawCircle(int(this.m_bOriginBot) * OFFSET_BOT_X,int(this.m_bOriginBot) * OFFSET_BOT_Y,_loc5_ * 50);
         var _loc6_:Number = Number(param1.NumProjectiles);
         var _loc7_:Number = 10;
         if(param1.ArcGap != undefined)
         {
            _loc7_ = Number(param1.ArcGap);
         }
         if(Boolean(_loc7_) && _loc6_ > 1)
         {
            _loc9_ = (_loc6_ - 1) * _loc7_;
            if(_loc9_ < 180)
            {
               _loc10_ = 0.5 / Math.cos(MathUtil.fDegToRad * (90 - _loc9_ / 2));
               _loc8_ = Math.sqrt(_loc10_ * _loc10_ - 0.5 * 0.5);
            }
         }
         if(Boolean(_loc8_) && _loc8_ < _loc5_)
         {
            param2.graphics.lineStyle(1,param4,1);
            param2.graphics.drawCircle(int(this.m_bOriginBot) * OFFSET_BOT_X,int(this.m_bOriginBot) * OFFSET_BOT_Y,_loc8_ * 50);
         }
      }
      
      public function ResetOrigin() : void
      {
         this.m_bOriginBot = this.m_bOriginBot ? false : true;
         this.cbOffcent.selected = false;
         this.UpdateRangeAbil();
         this.UpdateRangeWep();
         this.DrawBulletTrajectory();
      }
      
      private function OnWepUpdate(param1:Event) : void
      {
         this.ChangeWep(this.m_WepEdit.GetWeapon());
      }
      
      public function ChangeWep(param1:Weapon) : void
      {
         this.UpdateXML(param1.GetXML(),param1.sProjId);
         this.UpdateWep();
      }
      
      private function UpdateWep() : void
      {
         this.UpdateRangeWep();
         this.ResetSineAndPara();
         this.DrawBulletTrajectory();
         if(this.m_xmlBullet.Rotation != undefined && this.m_xmlBullet.Rotation != 0)
         {
            this.m_fItemRotation = 10 * (90 / this.m_xmlBullet.Rotation);
         }
         else
         {
            this.m_fItemRotation = 0;
         }
      }
      
      public function Change(param1:int) : void
      {
         var _loc2_:XML = XmlData.ObjectById(param1);
         this.m_WepEdit.SetWep(new Weapon(_loc2_));
         this.UpdateXML(_loc2_,_loc2_.Projectile.ObjectId);
         this.UpdateWep();
      }
      
      public function CheckForBulletChange(param1:String) : void
      {
         if(param1 == "")
         {
            param1 = this.m_xmlWeapon.Projectile.ObjectId;
         }
         this.m_xmlBullet = XmlData.ObjectByName(param1);
      }
      
      private function UpdateXML(param1:XML, param2:String) : void
      {
         this.m_xmlWeapon = param1;
         this.m_xmlBullet = XmlData.ObjectByName(param2);
      }
      
      public function ChangeAbil(param1:int) : void
      {
         var _loc2_:* = false;
         if(param1 != -1 && param1 != 0)
         {
            this.m_xmlAbil = XmlData.ObjectById(param1);
            _loc2_ = this.m_xmlAbil.Projectile != undefined;
            if(_loc2_)
            {
               this.m_xmlAbilBullet = XmlData.ObjectByName(this.m_xmlAbil.Projectile.ObjectId);
               this.UpdateRangeAbil();
               this.ResetSineAndParaAbil();
               if(this.m_xmlAbilBullet.Rotation != undefined && this.m_xmlAbilBullet.Rotation != 0)
               {
                  this.m_fAbilRotation = 10 * (90 / this.m_xmlAbilBullet.Rotation);
               }
               else
               {
                  this.m_fAbilRotation = 0;
               }
            }
            else
            {
               this.m_xmlAbilBullet = null;
            }
         }
         else
         {
            this.m_xmlAbil = null;
            this.m_xmlAbilBullet = null;
            this.UpdateRangeAbil();
         }
      }
      
      public function UpdateAttackSpeed() : void
      {
         this.m_fHitsPerSec = CharCompCom.Current.GetHPS();
         trace("Updating AttSpd: " + this.m_fHitsPerSec);
      }
      
      private function StepBullets() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Bullet = null;
         var _loc1_:Vec2 = new Vec2(mouseX - this.m_BulletTraj.x,mouseY - this.m_BulletTraj.y);
         this.m_BulletTraj.rotation = _loc1_.getDegrees();
         this.m_fRotation += this.m_fItemRotation;
         this.m_fRotationAbil += this.m_fAbilRotation;
         var _loc2_:int = int(this.m_aBullets.length);
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = this.m_aBullets[_loc3_];
            if(_loc6_.NeedsToBeRemoved)
            {
               removeChild(_loc6_);
               this.m_aBullets.splice(_loc3_,1);
            }
            else
            {
               if(_loc6_.xmlPart != undefined)
               {
                  this.CreateParticles(_loc6_.x,_loc6_.y,_loc6_.xmlPart);
               }
               _loc6_.Step();
            }
            _loc3_--;
         }
         if(this.m_fFireCooldown <= 0)
         {
            if(this.MouseInput(1) || this.m_bAutoFire)
            {
               this.Shoot();
               this.m_fFireCooldown = 60 / CharCompCom.Current.GetHPS();
            }
         }
         --this.m_fFireCooldown;
         _loc4_ = int(this.m_aParticles.length);
         _loc5_ = _loc4_ - 1;
         while(_loc5_ >= 0)
         {
            if(this.m_aParticles[_loc5_].NeedsToBeRemoved)
            {
               removeChild(this.m_aParticles[_loc5_]);
               this.m_aParticles.splice(_loc5_,1);
            }
            else
            {
               this.m_aParticles[_loc5_].Step();
            }
            _loc5_--;
         }
      }
      
      private function MouseInput(param1:uint) : Boolean
      {
         switch(param1)
         {
            case 1:
               if(this.m_bMouseDown)
               {
                  return true;
               }
               return false;
               break;
            default:
               return false;
         }
      }
      
      private function OnMouseDown(param1:MouseEvent) : void
      {
         this.m_Stage.focus = null;
         this.m_bMouseDown = true;
      }
      
      private function OnMouseUp(param1:MouseEvent) : void
      {
         this.lastMouse.x = mouseX;
         this.lastMouse.y = mouseY;
         this.m_bMouseDown = false;
      }
      
      public function UseAbility() : void
      {
         var _loc1_:Vec2 = null;
         var _loc2_:Point = null;
         var _loc3_:uint = 0;
         var _loc4_:XMLList = null;
         if(this.m_xmlAbil != null)
         {
            _loc1_ = new Vec2(mouseX,mouseY);
            _loc2_ = new Point(0,0);
            _loc2_.y += int(this.m_bOriginBot) * OFFSET_BOT_Y;
            _loc1_.y -= _loc2_.y;
            _loc2_.x += int(this.m_bOriginBot) * OFFSET_BOT_X;
            _loc1_.x -= _loc2_.x;
            if(this.m_xmlAbil.Activate == "BulletNova" || this.m_xmlAbil.Activate == "Decoy")
            {
               _loc1_.x = 1;
               _loc1_.y = 1;
               _loc3_ = 20;
               _loc4_ = this.m_xmlAbil.Activate;
               if(_loc4_.@numShots != undefined)
               {
                  _loc3_ = uint(_loc4_.@numShots);
               }
               this.m_xmlAbil.NumProjectiles = _loc3_;
               this.m_xmlAbil.ArcGap = 360 / _loc3_;
            }
            if(this.m_xmlAbilBullet != null)
            {
               this.CreateBullets(_loc2_,_loc1_,this.m_xmlAbil,this.m_xmlAbilBullet,this.m_fAbilRotation,this.m_fRotationAbil);
            }
         }
      }
      
      public function Shoot() : void
      {
         var _loc1_:Vec2 = null;
         _loc1_ = new Vec2(mouseX,mouseY);
         var _loc2_:Point = new Point(0,0);
         _loc2_.y += int(this.m_bOriginBot) * OFFSET_BOT_Y;
         _loc1_.y -= _loc2_.y;
         _loc2_.x += int(this.m_bOriginBot) * OFFSET_BOT_X;
         _loc1_.x -= _loc2_.x;
         this.CreateBullets(_loc2_,_loc1_,this.m_xmlWeapon,this.m_xmlBullet,this.m_fItemRotation,this.m_fRotation);
      }
      
      private function ResetSineAndParaAbil() : void
      {
         this.m_fRotationAbil = 0;
      }
      
      private function ResetSineAndPara() : void
      {
         this.m_iSineOffset = -1;
         this.m_iPara = 3;
         this.m_fRotation = 0;
      }
      
      private function get iSine() : int
      {
         if(this.m_iSineOffset == 1)
         {
            this.m_iSineOffset = -1;
         }
         else
         {
            this.m_iSineOffset = 1;
         }
         return this.m_iSineOffset;
      }
      
      private function get iPara() : int
      {
         ++this.m_iPara;
         this.m_iPara %= 4;
         return this.m_iPara;
      }
      
      private function CreateParticles(param1:Number, param2:Number, param3:XMLList) : *
      {
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Vec2 = null;
         var _loc4_:Number = Number(param3.@intensity);
         var _loc5_:int = int(Weapon.PARTICLE_LIFETIME);
         if(param3.@lifetimeMS != undefined)
         {
            _loc5_ = int(param3.@lifetimeMS);
         }
         _loc6_ = _loc5_ * 0.06;
         _loc7_ = uint(param3);
         if(!_loc7_)
         {
            _loc7_ = Weapon.PARTICLE_DEFAULT_COLOR;
         }
         _loc8_ = 0;
         while(_loc8_ < PARTICLE_SPAWN)
         {
            _loc9_ = (1 + Math.random() * Weapon.PARTICLE_MAXSPEED) / 12;
            _loc9_ = (-Weapon.PARTICLE_MAXSPEED + Math.random() * Weapon.PARTICLE_MAXSPEED * 2) / 12;
            _loc10_ = new Vec2(_loc9_,(-Weapon.PARTICLE_MAXSPEED + Math.random() * Weapon.PARTICLE_MAXSPEED * 2) / 10);
            this.AddParticle(new Particle(param1,param2,_loc10_,_loc6_,_loc7_));
            _loc8_++;
         }
      }
      
      private function ToggleShowTraj() : void
      {
         this.m_BulletTraj.visible = this.m_BulletTraj.visible ? false : true;
         this.cbShowPath.selected = false;
      }
      
      private function DrawBulletTrajectory() : void
      {
         var _loc6_:Bullet = null;
         var _loc1_:Vec2 = new Vec2(200,0);
         var _loc2_:Point = new Point(0,0);
         this.m_BulletTraj.x = int(this.m_bOriginBot) * OFFSET_BOT_X;
         this.m_BulletTraj.y = int(this.m_bOriginBot) * OFFSET_BOT_Y;
         var _loc3_:Vector.<Bullet> = this.CreateBullets(_loc2_,_loc1_,this.m_xmlWeapon,this.m_xmlBullet,this.m_fItemRotation,this.m_fRotation,true);
         _loc3_ = _loc3_.concat(this.CreateBullets(_loc2_,_loc1_,this.m_xmlWeapon,this.m_xmlBullet,this.m_fItemRotation,this.m_fRotation,true));
         this.m_BulletTraj.graphics.clear();
         this.m_BulletTraj.graphics.lineStyle(1,0);
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = _loc4_ - 1;
         while(_loc5_ >= 0)
         {
            this.m_BulletTraj.graphics.moveTo(0,0);
            _loc6_ = _loc3_[_loc5_];
            while(!_loc6_.NeedsToBeRemoved)
            {
               _loc6_.Step();
               this.m_BulletTraj.graphics.lineTo(_loc6_.x,_loc6_.y);
            }
            _loc3_.splice(_loc5_,1);
            _loc5_--;
         }
      }
      
      public function CreateBullets(param1:Point, param2:Vec2, param3:XML, param4:XML, param5:Number, param6:Number, param7:Boolean = false) : Vector.<Bullet>
      {
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Vector.<Bullet> = null;
         var _loc21_:uint = 0;
         var _loc22_:int = 0;
         var _loc23_:Number = NaN;
         var _loc24_:Vec2 = null;
         var _loc25_:Number = NaN;
         var _loc26_:Vec2 = null;
         var _loc27_:Vec2 = null;
         var _loc28_:Bullet = null;
         var _loc8_:XMLList = param3.Projectile.ParticleTrail;
         var _loc10_:Number = param3.Projectile.Speed / 12;
         var _loc11_:Number = Number(param3.Projectile.LifetimeMS);
         var _loc12_:int = 1;
         if(param3.NumProjectiles != undefined)
         {
            _loc12_ = int(param3.NumProjectiles);
         }
         _loc13_ = 5;
         if(param3.Projectile.Size != undefined)
         {
            _loc13_ = int(param3.Projectile.Size) / 20;
         }
         _loc14_ = false;
         if(param3.Projectile.Wavy != undefined)
         {
            _loc14_ = true;
         }
         _loc15_ = false;
         if(param3.Projectile.Parametric != undefined)
         {
            _loc15_ = true;
         }
         _loc16_ = Number(param3.Projectile.Amplitude);
         _loc17_ = Number(param3.Projectile.Frequency);
         _loc18_ = 0;
         _loc19_ = 0;
         if(_loc14_)
         {
            _loc16_ = 0.4;
            _loc17_ = 2.75;
         }
         if(_loc15_)
         {
            _loc16_ = param3.Projectile.Speed / 2;
            _loc17_ = 1;
         }
         _loc20_ = new Vector.<Bullet>();
         _loc21_ = 0;
         while(_loc21_ < _loc12_)
         {
            _loc22_ = 10;
            if(param3.ArcGap != undefined)
            {
               _loc22_ = int(param3.ArcGap);
            }
            if(_loc12_ == 1 || _loc15_)
            {
               _loc22_ = 0;
            }
            _loc23_ = _loc22_ * (_loc12_ - 1) / 2;
            if(_loc15_)
            {
               switch(this.iPara)
               {
                  case 0:
                     _loc18_ = 2;
                     _loc19_ = 1;
                     break;
                  case 1:
                     _loc18_ = 1;
                     _loc19_ = -1;
                     break;
                  case 2:
                     _loc18_ = 2;
                     _loc19_ = -1;
                     break;
                  case 3:
                     _loc18_ = 1;
                     _loc19_ = 1;
               }
            }
            else
            {
               _loc19_ = this.iSine;
            }
            _loc24_ = param2.normalize().scale(_loc10_);
            _loc25_ = _loc22_ * _loc21_ - _loc23_;
            _loc26_ = _loc24_.rotate(MathUtil.fDegToRad * _loc25_);
            _loc27_ = new Vec2(param1.x,param1.y);
            _loc28_ = new Bullet(_loc27_,_loc26_,param4,_loc11_,_loc13_,_loc19_,_loc16_,_loc17_,param5,param6,_loc14_,_loc18_,_loc8_);
            _loc20_.push(_loc28_);
            if(!param7)
            {
               this.AddBullet(_loc28_);
            }
            _loc21_++;
         }
         return _loc20_;
      }
   }
}


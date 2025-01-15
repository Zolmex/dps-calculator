package
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GameTime extends EventDispatcher
   {
      private static var instance:GameTime;
      
      public static const MS:Number = 1000;
      
      public static const TICK:Number = 200;
      
      public static const FPS:Number = 60;
      
      public static const INTERVAL:Number = MS / FPS;
      
      public function GameTime(param1:Function = null)
      {
         super();
         if(param1 != GameTime.getInstance)
         {
            throw new Error("GameTime is a singleton class, use getInstance() instead");
         }
         if(GameTime.instance != null)
         {
            throw new Error("Only one instance allowed.");
         }
      }
      
      public static function getInstance() : GameTime
      {
         if(instance == null)
         {
            instance = new GameTime(arguments.callee);
         }
         return instance;
      }
      
      public function Start(param1:Stage) : void
      {
         param1.addEventListener(Event.ENTER_FRAME,this.Step);
         var _loc2_:Timer = new Timer(INTERVAL,0);
         _loc2_.addEventListener("timer",this.Tick);
         _loc2_.start();
      }
      
      private function Step(param1:Event) : void
      {
         dispatchEvent(new WorldEvent(WorldEvent.STEP));
      }
      
      private function Tick(param1:TimerEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}


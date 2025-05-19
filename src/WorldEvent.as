package
{
   import flash.events.Event;
   
   public class WorldEvent extends Event
   {
      public static const STEP:String = "onWorldStep";
      
      public static const TICK:String = "onWorldTick";
      
      public function WorldEvent(param1:String)
      {
         super(param1,false,false);
      }
      
      override public function clone() : Event
      {
         return new WorldEvent(this.type);
      }
   }
}


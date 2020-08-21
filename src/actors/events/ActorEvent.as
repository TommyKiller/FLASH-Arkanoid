package actors.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorEvent extends Event 
	{
		
		public static const ACTOR_SPAWNED:String = "actorSpawned";
		public static const ACTOR_DISPOSED:String = "actorDisposed";
		
		public var actor:DisplayObject;
		
		public function ActorEvent(type:String, actor:DisplayObject, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.actor = actor;
		} 
		
		public override function clone():Event 
		{ 
			return new ActorEvent(type, actor, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ActorsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
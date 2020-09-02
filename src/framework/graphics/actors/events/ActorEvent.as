package framework.graphics.actors.events 
{
	import framework.graphics.actors.Actor;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorEvent extends Event 
	{
		
		public static const ACTOR_DISPOSED:String = "actorDisposed";
		public static const ADDED_TO_SCENE:String = "addedToScene";
		
		public var actor:Actor;
		
		public function ActorEvent(type:String, actor:Actor, bubbles:Boolean=false, cancelable:Boolean=false) 
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
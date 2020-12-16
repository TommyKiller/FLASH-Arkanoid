package framework.actors.events 
{
	import flash.events.Event;
	import framework.actors.Actor;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorEvent extends Event 
	{
		
		public static const ADDED:String = "actorAdded";
		public static const REMOVED:String = "actorRemoved";
		public static const ADDED_TO_SCENE:String = "addedToScene";
		public static const REMOVED_FROM_SCENE:String = "removedFromScene";
		public static const DISPOSED:String = "actorDisposed";
		
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
			return formatToString("ActorsEvent", "actor", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
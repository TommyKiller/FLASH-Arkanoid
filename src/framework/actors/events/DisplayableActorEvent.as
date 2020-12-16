package framework.actors.events 
{
	import flash.events.Event;
	import framework.actors.DisplayableActor;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class DisplayableActorEvent extends Event 
	{
		
		public static const ACTOR_PLACED:String = "actorPlaced";
		
		public var actor:DisplayableActor;
		
		public function DisplayableActorEvent(type:String, actor:DisplayableActor, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.actor = actor;
		} 
		
		public override function clone():Event 
		{ 
			return new DisplayableActorEvent(type, actor, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DisplayableActorEvent", "actor", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
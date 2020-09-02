package framework.graphics.actors.events 
{
	import framework.graphics.actors.PawnActor;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class PawnActorEvent extends ActorEvent 
	{
		
		public static const ACTOR_MOVED:String = "actorMoved";
		
		public function PawnActorEvent(type:String, actor:PawnActor, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, actor, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new PawnActorEvent(type, actor, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PawnActorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
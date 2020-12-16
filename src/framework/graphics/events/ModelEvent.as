package framework.graphics.events 
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ModelEvent extends Event 
	{
		
		public function ModelEvent(type:String, position:Point, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, position, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ModelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ModelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
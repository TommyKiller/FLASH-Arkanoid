package framework.input.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class InputControllerEvent extends Event 
	{
		
		public function InputControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new InputControllerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InputControllerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
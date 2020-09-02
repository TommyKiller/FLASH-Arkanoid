package framework.input.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActionEvent extends Event 
	{
		
		public static const ACTION_KEY_DOWN:String = "actionKeyDown";
		public static const ACTION_KEY_UP:String = "actionKeyUp";
		
		public function ActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ActionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ActionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
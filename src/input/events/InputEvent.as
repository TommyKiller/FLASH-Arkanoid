package input.events 
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/**
	 * An InputEvent object is dispatched in response to user input,
	 * indicating what key/mouse/controller was triggered.
	 * @author Tommy
	 */
	public class InputEvent extends Event 
	{
		public static const A_KEY:String = "aKey";
		public static const D_KEY:String = "dKey";
		public static const MOUSE_AXIS_X_POSITIVE:String = "mouseAxisXPositive";
		public static const MOUSE_AXIS_X_NEGATIVE:String = "mouseAxisXNegative";
		public static const MOUSE_AXIS_Y_POSITIVE:String = "mouseAxisYPositive";
		public static const MOUSE_AXIS_Y_NEGATIVE:String = "mouseAxisYNegative";
		
		public var state:String;
		
		public function InputEvent(type:String, state:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.state = state;
		}
		
		public override function clone():Event
		{
			return new InputEvent(type, state, bubbles, cancelable);
		}
		
	}

}
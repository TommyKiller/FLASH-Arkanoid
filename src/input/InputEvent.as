package input 
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
		
		public static const A_KEY_DOWN:String = "aKeyDown";
		public static const D_KEY_DOWN:String = "dKeyDown";
		public static const MOUSE_AXIS_X_POSITIVE:String = "mouseAxisXPositive";
		public static const MOUSE_AXIS_X_NEGATIVE:String = "mouseAxisXNegative";
		public static const MOUSE_AXIS_Y_POSITIVE:String = "mouseAxisYPositive";
		public static const MOUSE_AXIS_Y_NEGATIVE:String = "mouseAxisYNegative";
		
		public function InputEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new InputEvent(type, bubbles, cancelable);
		}
		
	}

}
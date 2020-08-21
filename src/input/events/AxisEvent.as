package input.events 
{
	import flash.events.Event;
	
	/**
	 * An AxisEvent object is dispatched when appropriate keys/controller axes were triggered.
	 * ActorController`s methods are implied to be bound to AxisEvents.
	 * @author Tommy
	 */
	public class AxisEvent extends Event 
	{
		
		public static const AXIS_POLLED:String = "axisPolled";
		public static const AXIS_ALTERED:String = "axisAltered";
		
		public var result:AxisEventResult;
		
		public function AxisEvent(type:String, result:AxisEventResult, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.result = result;
		}
		
		public override function clone():Event
		{
			return new AxisEvent(type, result, bubbles, cancelable);
		}
		
	}

}
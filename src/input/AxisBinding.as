package input
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Handles axis scale (_axisValue) tweaking with key down/up events.
	 * Dispatches appropriate AXIS_EVENTs when needed.
	 * @author Tommy
	 */
	public class AxisBinding extends EventDispatcher
	{
		
		private var _axisValue:Number;
		private var _bindings:Dictionary;
		
		public function AxisBinding(target:flash.events.IEventDispatcher = null)
		{
			// TODO: Copy existing events from target
			_bindings = new Dictionary();
		}
		
		private function set axisValue(value:Number):void
		{
			_axisValue = value;
			var result:Object = {value: _axisValue};
			dispatchEvent(new AxisEvent(AxisEvent.AXIS_ALTERED, result));
		}
		
		public function bindTo(event:String, scale:Number):void
		{
			_bindings[event] = function():void
			{
				_axisValue += scale
			};
		}
	
	}

}
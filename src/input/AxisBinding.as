package input
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import input.events.AxisEvent;
	import input.events.AxisEventResult;
	import input.events.InputControllerEvent;
	import input.events.InputEvent;
	import input.events.InputEventState;
	import interfaces.IDisposable;
	
	/**
	 * Handles axis scale (_axisValue) tweaking with key down/up events.
	 * Dispatches appropriate AXIS_EVENTs when needed.
	 * @author Tommy
	 */
	public class AxisBinding extends EventDispatcher implements IDisposable
	{
		
		private var _name:String;
		private var _axisValue:Number;
		private var _lowerBound:Number;
		private var _upperBound:Number;
		private var _disposed:Boolean;
		private var _bindings:Dictionary;
		
		public function AxisBinding(name:String, lowerBound:Number = -1, upperBound:Number = 1)
		{
			_name = name;
			_axisValue = 0;
			_lowerBound = lowerBound;
			_upperBound = upperBound
			_disposed = false;
			_bindings = new Dictionary();
			_bindings[InputController.INPUT_PROCESSED] = function(e:InputControllerEvent):void
			{
				if (_axisValue != 0)
				{
					dispatchEvent(new AxisEvent(AxisEvent.AXIS_POLLED, new AxisEventResult(_axisValue)));
				}
			};
			InputController.getInstance().addEventListener(InputController.INPUT_PROCESSED, _bindings[InputController.INPUT_PROCESSED]);
		}
		
		// Get/set methods //
		public function get name():String
		{
			return _name;
		}
		
		public function get axisValue():Number
		{
			return _axisValue;
		}
		
		// Should be private //
		public function set axisValue(value:Number):void
		{
			_axisValue = Math.max(lowerBound, Math.min(value, upperBound));
			
			dispatchEvent(new AxisEvent(AxisEvent.AXIS_ALTERED, new AxisEventResult(_axisValue)));
		}
		
		public function get lowerBound():Number
		{
			return _lowerBound
		}
		
		public function set lowerBound(value:Number):void
		{
			if (value < upperBound)
			{
				_lowerBound = value;
			}
			else
			{
				throw new Error("Axis` lower bound cannot be higher than axis` upper bound.");
			}
		}
		
		public function get upperBound():Number
		{
			return _upperBound
		}
		
		public function set upperBound(value:Number):void
		{
			if (value > lowerBound)
			{
				_upperBound = value;
			}
			else
			{
				throw new Error("Axis` upper bound cannot be beneath than axis` lower bound.");
			}
		}
		
		// Class functionality //
		public function bindTo(event:String, scale:Number):AxisBinding
		{
			_bindings[event] = function(event:InputEvent):void
			{
				if (event.state == InputEventState.PUSHED)
				{
					axisValue += scale;
				}
				else if (event.state == InputEventState.HANDLED)
				{
					axisValue -= scale;
				}
			};
			InputController.getInstance().addEventListener(event, _bindings[event]);
			
			return this;
		}
		
		public function dispose():void
		{
			if (!_disposed)
			{
				for (var key:String in _bindings)
				{
					InputController.getInstance().removeEventListener(key, _bindings[key]);
				}
				
				_disposed = true;
			}
		}
	
	}

}
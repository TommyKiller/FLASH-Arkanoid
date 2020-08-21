package input
{
	import input.events.AxisEvent;
	import input.events.InputEvent;
	import mx.utils.StringUtil;
	
	/**
	 * Functionates like a repositary for axis and action bindings.
	 * Singleton.
	 * @author Tommy
	 */
	public class InputLayout
	{
		
		private static var _instance:InputLayout;
		private var _axisBindings:Vector.<AxisBinding>;
		
		public function InputLayout()
		{
			if (!_instance)
			{
				_axisBindings = new Vector.<AxisBinding>();
			}
			else
			{
				throw new Error("Singleton instance has already been created");
			}
		}
		
		public static function getInstance():InputLayout
		{
			if (!_instance)
			{
				_instance = new InputLayout()
			}
			
			return _instance;
		}
		
		public function loadLayout():void
		{
			InputLayout.getInstance().createAxis("MoveRightAxis").bindTo(InputEvent.A_KEY, -1).bindTo(InputEvent.D_KEY, 1);
			//InputLayout.getInstance().getAxis("MoveRightAxis").bindTo(InputEvent.MOUSE_AXIS_X_NEGATIVE, -1).bindTo(InputEvent.MOUSE_AXIS_X_POSITIVE, 1);
		}
		
		/**
		 * Throws an error if an axis with given name already exists.
		 * @param	axisName
		 * @param	axisLowerBound - lower bound of axis value.
		 * @param	axisUpperBound - upper bound of axis value.
		 * @return reference to the created axis.
		 */
		public function createAxis(name:String, axisLowerBound:Number = -1, axisUpperBound:Number = 1):AxisBinding
		{
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					throw new Error("Axis with given name already exists!");
				}
			}
			
			var axisBinding:AxisBinding = new AxisBinding(name, axisLowerBound, axisUpperBound);
			_axisBindings.push(axisBinding);
			return axisBinding;
		}
		
		/**
		 * Throws an error if axis with required name does not exist.
		 * @param	name - name of the required axis.
		 * @return reference to the required axis.
		 */
		public function getAxis(name:String):AxisBinding
		{
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					return _axisBindings[i];
				}
			}
			
			throw new Error("Axis with given name does not exist!");
		}
		
		public function deleteAxis(name:String):void
		{
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					_axisBindings[i].dispose();
					_axisBindings.removeAt(i);
					break;
				}
			}
		}
		
		public function bindAxis(name:String, callbackPolled:Function, callbackAltered:Function = null):InputLayout
		{
			var binded:Boolean = false;
			
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					_axisBindings[i].addEventListener(AxisEvent.AXIS_POLLED, callbackPolled);
					if (callbackAltered)
					{
						_axisBindings[i].addEventListener(AxisEvent.AXIS_ALTERED, callbackAltered);
					}
					binded = true;
					break;
				}
			}
			
			if (!binded)
			{
				throw new Error(StringUtil.substitute("Can not bind to {0} axis. Check if the name is correct.", name));
			}
			
			return this;
		}
		
		public function unbindAxis(name:String, callbackPolled:Function, callbackAltered:Function = null):InputLayout
		{
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					_axisBindings[i].removeEventListener(AxisEvent.AXIS_POLLED, callbackPolled);
					if (callbackAltered)
					{
						_axisBindings[i].removeEventListener(AxisEvent.AXIS_ALTERED, callbackAltered);
					}
					break;
				}
			}
			
			return this;
		}
	
	}

}
package input
{
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
		
		/**
		 * Throws an error if an axis with given name already exists.
		 * @param	axisName
		 * @param	axisLowerBound - lower bound of axis value.
		 * @param	axisUpperBound - upper bound of axis value.
		 * @return reference to the created axis.
		 */
		public function createAxis(name:String, axisLowerBound:Number = -1, axisUpperBound:Number = 1):AxisBinding
		{
			for each(var axis:AxisBinding in _axisBindings)
			{
				if (axis.name == name)
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
			for each(var axis:AxisBinding in _axisBindings)
			{
				if (axis.name == name)
				{
					return axis;
				}
			}
			
			throw new Error("Axis with given name does not exist!");
		}
		
		public function deleteAxis(name:String):void
		{
			for (var index:int in _axisBindings)
			{
				if (_axisBindings[index].name == name)
				{
					_axisBindings[index].Dispose();
					_axisBindings.removeAt(index);
					break;
				}
			}
		}
		
		public function bindAxis(name:String, callback:Function):InputLayout
		{
			var binded:Boolean = false;
			
			for each(var axis:AxisBinding in _axisBindings)
			{
				if (axis.name == name)
				{
					axis.addEventListener(AxisEvent.AXIS_ALTERED, callback);
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
		
		public function unbindAxis(name:String, callback:Function):InputLayout
		{
			for each(var axis:AxisBinding in _axisBindings)
			{
				if (axis.name == name)
				{
					axis.removeEventListener(AxisEvent.AXIS_ALTERED, callback);
					break;
				}
			}
			
			return this;
		}
	
	}

}
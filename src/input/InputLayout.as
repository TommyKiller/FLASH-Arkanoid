package input
{
	
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
		
		public function createAxis(axisName:String, axisLowerBound:Number = -1, axisUpperBound:Number = 1):AxisBinding
		{
			// TODO: Check if axis with that name already exists, then create if not.
			var axis:AxisBinding = new AxisBinding(axisName, axisLowerBound, axisUpperBound);
			_axisBindings.push(axis);
			return axis;
		}
		
		/*public function getAxis(name:String):AxisBinding
		{
			// TODO: Searching an axis by name
		}*/
		
		public function deleteAxis(name:String):void
		{
			var index:int = -1;
			
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					index = i;
				}
			}
			
			if (index >= 0)
			{
				_axisBindings[index].Dispose();
				_axisBindings.removeAt(index);
			}
		}
	
	}

}
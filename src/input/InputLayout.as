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
		private var _actionBindings:Vector.<ActionBinding>;
		
		public function InputLayout()
		{
			if (!_instance)
			{
				_axisBindings = new Vector.<AxisBinding>();
				_actionBindings = new Vector.<ActionBinding>();
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
			createAxis("MoveRightAxis").bindTo(InputEvent.A_KEY, -1).bindTo(InputEvent.D_KEY, 1);
			getAxis("MoveRightAxis").bindTo(InputEvent.LEFT_ARROW_KEY, -1).bindTo(InputEvent.RIGHT_ARROW_KEY, 1);
			createAction("BackToMenu").bindTo(InputEvent.ESC_KEY);
			createAction("ThrowBall").bindTo(InputEvent.SPACEBAR_KEY);
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
		 * Throws an error if an action with given name already exists.
		 * @param	actionName
		 * @return reference to the created action.
		 */
		public function createAction(name:String):ActionBinding
		{
			for (var i:int = 0; i < _actionBindings.length; i++)
			{
				if (_actionBindings[i].name == name)
				{
					throw new Error("Action with given name already exists!");
				}
			}
			
			var actionBinding:ActionBinding = new ActionBinding(name);
			_actionBindings.push(actionBinding);
			return actionBinding;
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
		
		/**
		 * Throws an error if action with required name does not exist.
		 * @param	name - name of the required action.
		 * @return reference to the required action.
		 */
		public function getAction(name:String):ActionBinding
		{
			for (var i:int = 0; i < _actionBindings.length; i++)
			{
				if (_actionBindings[i].name == name)
				{
					return _actionBindings[i];
				}
			}
			
			throw new Error("Action with given name does not exist!");
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
		
		public function deleteAction(name:String):void
		{
			for (var i:int = 0; i < _actionBindings.length; i++)
			{
				if (_actionBindings[i].name == name)
				{
					_actionBindings[i].dispose();
					_actionBindings.removeAt(i);
					break;
				}
			}
		}
		
		public function bindAxis(name:String, callback:Function):InputLayout
		{
			var binded:Boolean = false;
			
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					_axisBindings[i].addEventListener(AxisEvent.AXIS_ALTERED, callback);
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
			for (var i:int = 0; i < _axisBindings.length; i++)
			{
				if (_axisBindings[i].name == name)
				{
					_axisBindings[i].removeEventListener(AxisEvent.AXIS_ALTERED, callback);
					break;
				}
			}
			
			return this;
		}
		
		public function bindAction(name:String, actionEvent:String, callback:Function):InputLayout
		{
			var binded:Boolean = false;
			
			for (var i:int = 0; i < _actionBindings.length; i++)
			{
				if (_actionBindings[i].name == name)
				{
					_actionBindings[i].addEventListener(actionEvent, callback);
					binded = true;
					break;
				}
			}
			
			if (!binded)
			{
				throw new Error(StringUtil.substitute("Can not bind to {0} action. Check if the name is correct.", name));
			}
			
			return this;
		}
		
		public function unbindAction(name:String, actionEvent:String, callback:Function):InputLayout
		{
			for (var i:int = 0; i < _actionBindings.length; i++)
			{
				if (_actionBindings[i].name == name)
				{
					_actionBindings[i].removeEventListener(actionEvent, callback);
					break;
				}
			}
			
			return this;
		}
	
	}

}
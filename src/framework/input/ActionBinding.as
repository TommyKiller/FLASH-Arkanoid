package framework.input 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import framework.input.events.ActionEvent;
	import framework.input.events.InputEvent;
	import framework.input.events.InputEventState;
	import framework.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActionBinding extends EventDispatcher implements IDisposable 
	{
		
		private var _name:String;
		private var _disposed:Boolean;
		private var _bindings:Dictionary;
		
		public function ActionBinding(name:String) 
		{
			_name = name;
			_disposed = false;
			_bindings = new Dictionary();
			
		}
		
		// Get/set methods //
		public function get name():String
		{
			return _name;
		}
		
		// Class functionality //
		public function bindTo(event:String):ActionBinding
		{
			_bindings[event] = function(event:InputEvent):void
			{
				if (event.state == InputEventState.PUSHED)
				{
					dispatchEvent(new ActionEvent(ActionEvent.ACTION_KEY_DOWN));
				}
				else if (event.state == InputEventState.HANDLED)
				{
					dispatchEvent(new ActionEvent(ActionEvent.ACTION_KEY_UP));
				}
			};
			InputController.getInstance().addEventListener(event, _bindings[event]);
			
			return this;
		}
		
		public function unbind(event:String):ActionBinding
		{
			if (_bindings[event] !== undefined)
			{
				InputController.getInstance().removeEventListener(event, _bindings[event]);
				
				return _bindings[event];
			}
			else
			{
				throw new Error("Such a binding does not exist.");
			}
		}
		
		/* INTERFACE interfaces.IDisposable */
		
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
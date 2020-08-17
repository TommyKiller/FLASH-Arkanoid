package input
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * Singleton class that handles axis to key bidings
	 * and dispatch appropriate *_KEY_DOWN events.
	 * @author Tommy
	 */
	public class InputController extends EventDispatcher
	{
		private static var _instance:InputController;
		
		private var _keyBindings:Dictionary;
		
		public function InputController(target:flash.events.IEventDispatcher = null)
		{
			// TODO: Copy existing events from target
			this.
			
			if (_instance)
			{
				throw new Error("Singleton instance has been already created");
			}
			else
			{
				super(target);
				fullFillKeyBindings();
				_instance = this;
				
				// Subscribing to events //
				addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandler);
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveEventHandler);
			}
		}
		
		private function fullFillKeyBindings():void
		{
			_keyBindings = new Dictionary();
			_keyBindings[65] = InputEvent.A_KEY_DOWN;
			_keyBindings[68] = InputEvent.D_KEY_DOWN;
		}
		
		public static function getInstance():InputController
		{
			return _instance;
		}
		
		// Event handlers //
		private function onKeyDownEventHandler(e:KeyboardEvent):void
		{
			dispatchEvent(_keyBindings[e.keyCode]);
		}
		
		private function onMouseMoveEventHandler(e:MouseEvent):void 
		{
			if (e.movementX < 0)
			{
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_X_NEGATIVE));
			}
			else if (e.movementX > 0)
			{
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_X_POSITIVE));
			}
			
			if (e.movementY < 0)
			{
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_Y_POSITIVE));
			}
			else if (e.movementY > 0)
			{
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_Y_NEGATIVE));
			}
		}
	
	}

}
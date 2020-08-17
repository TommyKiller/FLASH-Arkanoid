package input
{
	import flash.display.Stage;
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
		private var _inputSource:IEventDispatcher;
		private var _keyBindings:Dictionary;
		private var _mouse:Object = {x: undefined, y: undefined};
		
		public function InputController(inputSource:IEventDispatcher)
		{
			if (!_instance)
			{
				fullFillKeyBindings();
				_instance = this;
				_inputSource = inputSource;
				
				// Subscribing to events //
				_inputSource.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandler);
				_inputSource.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveEventHandler);
			}
			else
			{
				throw new Error("Singleton instance has already been created");
			}
		}
		
		private function fullFillKeyBindings():void
		{
			_keyBindings = new Dictionary();
			_keyBindings[65] = InputEvent.A_KEY_DOWN;
			_keyBindings[68] = InputEvent.D_KEY_DOWN;
		}
		
		public static function getInstance(inputSource:IEventDispatcher = null):InputController
		{
			if (!_instance)
			{
				if (inputSource)
				{
					_instance = new InputController(inputSource);
				}
				else
				{
					throw new Error("First, create an instance!");
				}
			}
			
			return _instance;
		}
		
		// Event handlers //
		private function onKeyDownEventHandler(e:KeyboardEvent):void
		{
			if (_keyBindings[e.keyCode] !== undefined)
			{
				dispatchEvent(new InputEvent(_keyBindings[e.keyCode]));
			}
		}
		
		private function onMouseMoveEventHandler(e:MouseEvent):void
		{
			if (_mouse.x === undefined)
			{
				_mouse.x = e.localX;
			}
			if (_mouse.y === undefined)
			{
				_mouse.y = e.localY;
			}
			
			if (e.localX < _mouse.x)
			{
				_mouse.x = e.localX;
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_X_NEGATIVE));
			}
			else if (e.localX > _mouse.x)
			{
				_mouse.x = e.localX;
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_X_POSITIVE));
			}
			
			if (e.localY < _mouse.y)
			{
				_mouse.y = e.localY;
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_Y_POSITIVE));
			}
			else if (e.localY > _mouse.y)
			{
				_mouse.y = e.localY;
				dispatchEvent(new InputEvent(InputEvent.MOUSE_AXIS_Y_NEGATIVE));
			}
		}
	
	}

}
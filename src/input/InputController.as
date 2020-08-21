package input
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import input.events.InputControllerEvent;
	import input.events.InputEvent;
	import input.events.InputEventState;
	
	/**
	 * Singleton class that handles axis to key bidings
	 * and dispatch appropriate *_KEY_DOWN events.
	 * @author Tommy
	 */
	public class InputController extends EventDispatcher
	{
		public static const INPUT_PROCESSED:String = "inputProcessed";
		
		private static var _instance:InputController;
		private var _stage:Stage;
		private var _keys:Dictionary;
		private var _mouse:Mouse;
		private var _inputEventsQueue:Vector.<InputEvent>;
		private var _inputEventsBuffer:Vector.<InputEvent>;
		
		public function InputController(stage:Stage)
		{
			if (!_instance)
			{
				fullFillKeyBindings();
				_instance = this;
				_stage = stage;
				_inputEventsQueue = new Vector.<InputEvent>();
				_inputEventsBuffer = new Vector.<InputEvent>();
				_mouse = new Mouse(_stage.mouseX, _stage.mouseY);
				
				// Subscribing to events //
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandler);
				_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandler);
				_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveEventHandler);
				_stage.addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
				_mouse.addEventListener(Mouse.MOUSE_STOP, onMouseStopEventHandler);
			}
			else
			{
				throw new Error("Singleton instance has already been created");
			}
		}
		
		private function fullFillKeyBindings():void
		{
			_keys = new Dictionary();
			_keys[65] = InputEvent.A_KEY;
			_keys[68] = InputEvent.D_KEY;
		}
		
		public static function getInstance(stage:Stage = null):InputController
		{
			if (!_instance)
			{
				if (stage)
				{
					_instance = new InputController(stage);
				}
				else
				{
					throw new Error("First, create an instance!");
				}
			}
			
			return _instance;
		}
		
		// Input events queue methods //
		private function setPushed(event:String):void
		{
			for (var i:int = 0; i < _inputEventsQueue.length; i++)
			{
				if (_inputEventsQueue[i].type == event)
				{
					return;
				}
			}
			
			_inputEventsQueue.push(new InputEvent(event, InputEventState.PUSHED));
		}
		
		private function setHandled(event:String):void
		{
			for (var i:int = 0; i < _inputEventsQueue.length; i++)
			{
				if (_inputEventsQueue[i].type == event)
				{
					_inputEventsQueue[i].state = InputEventState.HANDLED;
					
					return;
				}
			}
		}
		
		private function pollEvents():void
		{
			while (_inputEventsQueue.length != 0)
			{
				var event:InputEvent = _inputEventsQueue.shift();
				
				if (event.state != InputEventState.REPEAT)
				{
					dispatchEvent(event);
				}
				
				if (event.state == InputEventState.PUSHED)
				{
					event.state = InputEventState.REPEAT;
				}
				
				if (event.state == InputEventState.REPEAT)
				{
					_inputEventsBuffer.push(event);
				}
			}
		}
		
		private function swapBuffers():void
		{
			for (var i:int = 0; i < _inputEventsBuffer.length; i++ )
			{
				_inputEventsQueue.push(_inputEventsBuffer[i]);
			}
			
			if (_inputEventsBuffer.length > 0)
			{
				_inputEventsBuffer = new Vector.<InputEvent>();
			}
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(e:Event):void 
		{
			_mouse.pollEvents();
			pollEvents();
			swapBuffers();
			
			dispatchEvent(new InputControllerEvent(INPUT_PROCESSED));
		}
		
		private function onKeyDownEventHandler(e:KeyboardEvent):void
		{
			if (_keys[e.keyCode] !== undefined)
			{
				setPushed(_keys[e.keyCode]);
			}
		}
		
		private function onKeyUpEventHandler(e:KeyboardEvent):void 
		{
			if (_keys[e.keyCode] !== undefined)
			{
				setHandled(_keys[e.keyCode]);
			}
		}
		
		private function onMouseMoveEventHandler(e:MouseEvent):void
		{
			_mouse.newX = e.movementX;
			_mouse.newY = e.movementX;
			
			if (_mouse.x < _mouse.newX)
			{
				setPushed(InputEvent.MOUSE_AXIS_X_POSITIVE);
			}
			else if (_mouse.x > _mouse.newX)
			{
				setPushed(InputEvent.MOUSE_AXIS_X_NEGATIVE);
			}
			
			if (_mouse.y < _mouse.newY)
			{
				setPushed(InputEvent.MOUSE_AXIS_Y_POSITIVE);
			}
			else if (_mouse.y > _mouse.newY)
			{
				setPushed(InputEvent.MOUSE_AXIS_Y_NEGATIVE);
			}
		}
		
		private function onMouseStopEventHandler(e:MouseEvent):void
		{
			if (_mouse.x == _mouse.newX)
			{
				setHandled(InputEvent.MOUSE_AXIS_X_POSITIVE);
				setHandled(InputEvent.MOUSE_AXIS_X_NEGATIVE);
			}
			
			if (_mouse.y == _mouse.newY)
			{
				setHandled(InputEvent.MOUSE_AXIS_Y_POSITIVE);
				setHandled(InputEvent.MOUSE_AXIS_Y_NEGATIVE);
			}
		}
	
	}

}
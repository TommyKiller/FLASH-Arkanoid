package actors
{
	import actors.ActorsManager;
	import actors.events.ActorEvent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import input.InputLayout;
	import input.events.AxisEvent;
	import interfaces.IDisposable;
	import mx.utils.NameUtil
	import physics.Vector2D;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Platform extends Sprite implements IDisposable,
	{
		
		public static const PLATFORM_MOVED:String = "platformMoved";
		
		private var _width:Number;
		private var _height:Number;
		private var _speed:uint;
		private var _color:uint;
		private var _disposed:Boolean;
		private var _friction:Number;
		private var _velocity:Vector2D;
		
		public function Platform(width:Number, height:Number, speed:uint, color:uint, friction:Number, x:Number = 0, y:Number = 0, name:String = null)
		{
			this.width = width;
			this.height = height;
			_speed = speed;
			_color = color;
			this.x = x;
			this.y = y;
			this.friction = friction;
			this.name = name ? name : NameUtil.createUniqueName(this);
			_disposed = false;
			_velocity = new Vector2D();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
			InputLayout.getInstance().bindAxis("MoveRightAxis", onMoveRightEventHandler);
			render();
		}
		
		// Get/set methods //
		public function get speed():Number
		{
			return _speed;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public override function get width():Number
		{
			return _width;
		}
		
		public override function set width(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Width of the platform must be greater than 0.");
			}
			
			_width = value;
		}
		
		public override function get height():Number
		{
			return _height;
		}
		
		public override function set height(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Height of the platform must be greater than 0.");
			}
			
			_height = value;
		}
		
		public function get friction():Number
		{
			return _friction;
		}
		
		public function set friction(value:Number):void
		{
			if (value < 0 || value > 1)
			{
				throw new Error("Friction of the platform must be between 0 and 1.");
			}
			
			_friction = value;
		}
		
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(event:Event):void
		{
			var newX:Number = x + velocity.x * speed;
			
			if (newX >= 0 && newX + width <= stage.stageWidth)
			{
				x = newX;
				
				dispatchEvent(new ActorEvent(PLATFORM_MOVED, this));
			}
		}
		
		private function onMoveRightEventHandler(event:AxisEvent):void
		{
			_velocity.x = event.result.axisValue;
		}
		
		private function render():void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				// Unsubscribe from events //
				InputLayout.getInstance().unbindAxis("MoveRightAxis", onMoveRightEventHandler);
				removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
				ActorsManager.removeObject(this);
				
				_disposed = true;
			}
		}
	
	}

}
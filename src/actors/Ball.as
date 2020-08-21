package actors 
{
	import actors.ActorsManager;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import interfaces.IDisposable;
	import interfaces.IRenderable;
	import mx.utils.NameUtil;
	import physics.CollisionManager;
	import physics.Vector2D;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Ball extends Sprite implements IDisposable, IRenderable
	{
		
		private var _radius:Number;
		private var _speed:uint;
		private var _color:uint;
		private var _disposed:Boolean;
		private var _velocity:Vector2D;
		
		public function Ball(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null) 
		{
			_radius = radius;
			_speed = speed;
			_color = color;
			this.x = x;
			this.y = y;
			this.name = name ? name : NameUtil.createUniqueName(this);
			_disposed = false;
			_velocity = new Vector2D(0, -1);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
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
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function set radius(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Radius of the ball must be greater than 0.");
			}
			
			_radius = value;
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(event:Event):void
		{
			var oldX:Number = x;
			var oldY:Number = y;
			x += _velocity.x * speed;
			y += _velocity.y * speed;
			
			var collisions:Array = CollisionManager.getInstance().checkCollisions(this);
			
			for (var i:int = 0; i < collisions.length; i++)
			{
				var brick:Brick = collisions[i].object2 as Brick;
				if (brick)
				{
					brick.dispose();
				}
				else if (this !== collisions[i].object1)
				{
					brick = collisions[i].object1 as Brick;
					
					if (brick)
					{
						brick.dispose();
					}
				}
				
				var angle:Number = Math.PI - collisions[i].angle;
				_velocity.rotate(angle);
				
				/*var platform:Platform = collisions[i].object2 as Platform;
				if (platform)
				{
					_velocity.x += platform.friction * platform.velocity.x;
				}
				else if (this !== collisions[i].object1)
				{
					platform = collisions[i].object1 as Platform;
					
					if (platform)
					{
						_velocity.x += platform.friction * platform.velocity.x;
					}
				}*/
				
				_velocity.unit();
			}
			
			x = oldX + _velocity.x * speed;
			y = oldY + _velocity.y * speed;
			
			if (y > stage.stageHeight)
			{
				dispose();
			}
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				// Unsubscribe from events //
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
				ActorsManager.removeObject(this);
				
				_disposed = true;
			}
		}
		
		/* INTERFACE interfaces.IRenderable */
		
		public function render():void
		{
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
		
	}

}
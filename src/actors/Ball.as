package actors
{
	import framework.graphics.actors.PawnActor;
	import framework.graphics.actors.events.ActorEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import framework.input.InputLayout;
	import framework.input.events.ActionEvent;
	import framework.interfaces.IDisposable;
	import mx.utils.NameUtil;
	import framework.physics.CollisionManager;
	import framework.math.Vector2D;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Ball extends PawnActor
	{
		
		public static const BALL_DESTROYED:String = "ballDestroyed";
		
		public function Ball(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null)
		{
			var model:Sprite = new Sprite();
			model.graphics.beginFill(color);
			model.graphics.drawCircle(x, y, radius);
			model.graphics.endFill();
			super(model, speed, name);
			velocity.y = -1;
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(event:Event):void
		{
			var oldX:Number = x;
			var oldY:Number = y;
			x += _velocity.x * speed;
			y += _velocity.y * speed;
			
			var collisions:Array = CollisionManager.getInstance().checkCollisions(this);
			
			if (collisions)
			{
				for (var i:int = 0; i < collisions.length; i++)
				{
					var brick:Brick = collisions[i].object2 as Brick;
					if (brick)
					{
						brick.hit();
					}
					else if (this !== collisions[i].object1)
					{
						brick = collisions[i].object1 as Brick;
						
						if (brick)
						{
							brick.hit();
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
			}
			
			x = oldX + _velocity.x * speed;
			y = oldY + _velocity.y * speed;
			
			if (y > stage.stageHeight)
			{
				dispatchEvent(new ActorEvent(BALL_DESTROYED, this));
				
				dispose();
			}
		}
		
		private function onPlatformMovedEventHandler(event:ActorEvent):void
		{
			var platform:Platform = event.actor as Platform;
			x += platform.speed * platform.velocity.x;
		}
		
		private function startBouncing(event:ActionEvent):void
		{
			InputLayout.getInstance().getAction("ThrowBall").removeEventListener(ActionEvent.ACTION_KEY_DOWN, startBouncing);
			_platform.removeEventListener(Platform.PLATFORM_MOVED, onPlatformMovedEventHandler);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
		}
		
		public function stickToPlatform(platform:Platform):void
		{
			_platform = platform;
			platform.addEventListener(Platform.PLATFORM_MOVED, onPlatformMovedEventHandler);
			x = platform.x + platform.width / 2 - radius;
			y = platform.y - radius;
			
			InputLayout.getInstance().getAction("ThrowBall").addEventListener(ActionEvent.ACTION_KEY_DOWN, startBouncing);
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				_model.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
				
				_disposed = true;
			}
		}
	
	}

}
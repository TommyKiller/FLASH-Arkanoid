package actors 
{
	import actors.Ball;
	import actors.Brick;
	import actors.Platform;
	import actors.events.ActorEvent;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import physics.CollisionManager;
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorsManager extends EventDispatcher
	{
		private static var _stage:Stage;
		private static var _eventDispatcher:EventDispatcher;
		
		public static function initialize(stage:Stage):void
		{
			_stage = stage;
			_eventDispatcher = new EventDispatcher();
		}
		
		public static function createPlatform(width:Number, height:Number, speed:uint, color:uint, friction:Number, x:Number = 0, y:Number = 0, collision:Boolean = true, name:String = null):Platform
		{
			var platform:Platform = new Platform(width, height, speed, color, friction, x, y, name);
			_stage.addChild(platform);
			CollisionManager.getInstance().addItem(platform);
			_eventDispatcher.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_SPAWNED, platform));
			
			return platform;
		}
		
		public static function createBall(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, collision:Boolean = true, name:String = null):Ball
		{
			var ball:Ball = new Ball(radius, speed, color, x, y, name);
			_stage.addChild(ball);
			CollisionManager.getInstance().addItem(ball);
			_eventDispatcher.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_SPAWNED, ball));
			
			return ball;
		}
		
		public static function createBrick(width:Number, height:Number, color:uint, x:Number = 0, y:Number = 0, collision:Boolean = true, name:String = null):Brick
		{
			var brick:Brick = new Brick(width, height, color, x, y, name);
			_stage.addChild(brick);
			CollisionManager.getInstance().addItem(brick);
			_eventDispatcher.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_SPAWNED, brick));
			
			return brick;
		}
		
		public static function createWall(width:Number, height:Number, color:uint, x:Number = 0, y:Number = 0, collision:Boolean = true, name:String = null):Wall
		{
			var wall:Wall = new Wall(width, height, color, x, y, name);
			_stage.addChild(wall);
			CollisionManager.getInstance().addItem(wall);
			_eventDispatcher.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_SPAWNED, wall));
			
			return wall;
		}
		
		public static function removeObject(object:DisplayObject):void
		{
			_stage.removeChild(object);
			CollisionManager.getInstance().removeItem(object);
			_eventDispatcher.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_DISPOSED, object));
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			_eventDispatcher.addEventListener(type, listener);
		}
		
		public static function removeEventListener(type:String, listener:Function):void
		{
			_eventDispatcher.removeEventListener(type, listener);
		}
	}

}
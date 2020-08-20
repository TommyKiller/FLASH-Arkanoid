package actors 
{
	import actors.Ball;
	import actors.Brick;
	import actors.Platform;
	import com.coreyoneil.collision.CollisionList;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorsManager
	{
		private static var _stage:Stage;
		private static var _collisionList:CollisionList;
		
		public static function initialize(stage:Stage):void
		{
			_stage = stage;
			_collisionList = new CollisionList(stage);
		}
		
		public static function createPlatform(width:Number, height:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null):Platform
		{
			var platform:Platform = new Platform(_stage, width, height, speed, color, x, y, name);
			_collisionList.addItem(platform);
			
			return platform;
		}
		
		public static function createBall(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null):Ball
		{
			var ball:Ball = new Ball(_stage, radius, speed, color, x, y, name);
			_collisionList.addItem(ball);
			
			return ball;
		}
		
		public static function createBrick(width:Number, height:Number, color:uint, x:Number = 0, y:Number = 0, name:String = null):Brick
		{
			var brick:Brick = new Brick(_stage, width, height, color, x, y, name);
			_collisionList.addItem(brick);
			
			return brick;
		}
		
		public static function removeObject(object:DisplayObject):void
		{
			_stage.removeChild(object);
			_collisionList.removeItem(object);
		}
	}

}
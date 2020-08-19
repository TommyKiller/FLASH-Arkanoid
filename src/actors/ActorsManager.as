package actors 
{
	import actors.controllers.PlatformController;
	import actors.models.Platform;
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
		
		public static function createPlatform(width:Number, height:Number, speed:uint, color:uint, name:String = null, x:Number = 0, y:Number = 0):Platform
		{
			var platform:Platform = new Platform(width, height, speed, color, name, x, y);
			_collisionList.addItem(platform);
			_stage.addChild(platform);
			PlatformController.activate(platform);
			
			return platform;
		}
		
		public static function removeObject(object:DisplayObject):void
		{
			_stage.removeChild(object);
			_collisionList.removeItem(object);
		}
	}

}
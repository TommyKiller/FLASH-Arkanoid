package framework.physics 
{
	import com.coreyoneil.collision.CollisionList;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Tommy
	 */
	public class CollisionManager 
	{
		
		private static var _instance:CollisionManager;
		private var _collisionList:Vector.<DisplayObject>;
		private var _target:DisplayObject;
		
		public function CollisionManager() 
		{
			if (!_instance)
			{
				_collisionList = new Vector.<flash.display.DisplayObject>();
			}
			else
			{				
				throw new Error("Singleton instance has already been created");
			}
		}
		
		public static function getInstance():CollisionManager
		{
			if (!_instance)
			{
				_instance = new CollisionManager();
			}
			
			return _instance;
		}
		
		public function addItem(object:DisplayObject):void
		{
			for (var i:int = 0; i < _collisionList.length; i++)
			{
				if (_collisionList[i] === object)
				{
					return;
				}
			}
			
			_collisionList.push(object);
		}
		
		public function removeItem(object:DisplayObject):void
		{
			for (var i:int = 0; i < _collisionList.length; i++)
			{
				if (_collisionList[i] === object)
				{
					_collisionList.removeAt(i);
					
					return;
				}
			}
		}
		
		public function swapTarget(target:DisplayObject):void
		{
			if (_target !== target)
			{
				_target = target;
			}
		}
		
		public function checkCollisions(target:DisplayObject):Array
		{
			if (_collisionList.length < 2)
			{
				return null;
			}
			
			swapTarget(target);
			
			var collisions:CollisionList = new CollisionList(_target);
			collisions.returnAngle = true;
			for (var i:int = 0; i < _collisionList.length; i++)
			{
				if (_collisionList[i] !== target)
				{
					collisions.addItem(_collisionList[i]);
				}
			}
			
			return collisions.checkCollisions();
		}
		
	}

}
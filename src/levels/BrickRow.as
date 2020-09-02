package levels 
{
	import actors.Brick;
	import framework.graphics.actors.events.ActorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import framework.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class BrickRow extends EventDispatcher implements IDisposable
	{
		
		public static const ROW_DESTROYED:String = "rowDestroyed";
		
		private var _bricks:Vector.<Brick>;
		
		public function BrickRow()
		{
			_bricks = new Vector.<Brick>();
		}
		
		// Get/set methods //
		public function get length():uint
		{
			return _bricks.length;
		}
		
		public function getBrick(index:uint):Brick
		{
			return _bricks[index];
		}
		
		public function push(brick:Brick):void
		{
			brick.addEventListener(Brick.BRICK_DESTROYED, onBrickDestroyedEventHandler);
			
			_bricks.push(brick);
		}
		
		private function onBrickDestroyedEventHandler(event:ActorEvent):void 
		{
			for (var i:int = 0; i < _bricks.length; i++)
			{
				if (_bricks[i].name == event.actor.name)
				{
					_bricks.removeAt(i);
					
					break;
				}
			}
			
			if (_bricks.length == 0)
			{
				dispatchEvent(new Event(ROW_DESTROYED));
			}
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void 
		{
			for (var i:int = 0; i < _bricks.length; i++)
			{
				_bricks[i].dispose();
			}
			
			_bricks = null;
		}
		
	}

}
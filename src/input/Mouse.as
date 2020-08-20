package input 
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Mouse extends EventDispatcher
	{
		public static const MOUSE_STOP:String = "mouseStop";
		
		public var x:Number;
		public var y:Number;
		public var newX:Number;
		public var newY:Number;
		
		public function Mouse(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
			newX = x;
			newY = y;
		}
		
		public function pollEvents():void
		{
			if (x == newX || y == newY)
			{
				dispatchEvent(new MouseEvent(MOUSE_STOP));
			}
			
			x = newX;
			y = newY;
		}
	}

}
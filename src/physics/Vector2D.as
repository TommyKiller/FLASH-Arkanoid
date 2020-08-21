package physics 
{
	/**
	 * ...
	 * @author Tommy
	 */
	public class Vector2D 
	{
		
		public var x:Number;
		public var y:Number;
		
		public function Vector2D(x:Number = 0, y:Number = 0) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function rotate(angle:Number):void
		{
			x = x * Math.cos(angle) - y * Math.sin(angle);
			y = x * Math.sin(angle) + y * Math.cos(angle);
		}
		
		public function unit():void
		{
			var mod:Number = module();
			
			x /= mod;
			y /= mod;
		}
		
		public function module():Number
		{
			return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
		}
		
		public function numMultiply(num:Number):void
		{
			x *= num;
			y *= num;
		}
		
	}

}
package framework.graphics.actors 
{
	import flash.display.DisplayObject;
	import framework.math.Vector2D;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class PawnActor extends StaticActor 
	{
		
		protected var _velocity:Vector2D;
		protected var _speed:Number;
		
		public function PawnActor(model:DisplayObject, speed:Number = 0, name:String=null) 
		{
			super(model, name);
			
			_speed = speed;
			_velocity = new Vector2D();
		}
		
		// Get/set methods //
		public function get speed():Number
		{
			return _speed;
		}
		
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
	}

}
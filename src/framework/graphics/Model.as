package framework.graphics 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Model extends Sprite
	{
		
		private var _position:Point;
		
		public function Model()
		{
			
		}
		
		/* Get/set mtethods */
		public function set position(value:Point):void
		{
			_position = position;
		}
		
		public function get position():Point
		{
			return _position;
		}
		
		/* Class interface */
		public function addToStage(stage:Stage):void
		{
			stage.addChild(this);
		}
		
	}

}
package actors 
{
	import flash.display.Sprite;
	import framework.graphics.actors.StaticActor;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Wall extends StaticActor
	{
		
		public function Wall(width:Number, height:Number, color:uint, x:Number = 0, y:Number = 0, name:String = null) 
		{
			var model:Sprite = new Sprite();
			model.x = x;
			model.y = y;
			model.graphics.beginFill(color);
			model.graphics.drawRect(0, 0, width, height);
			model.graphics.endFill();
			super(model, name);
		}
		
	}

}
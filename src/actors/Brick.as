package actors 
{
	import framework.graphics.actors.StaticActor;
	import framework.graphics.actors.events.ActorEvent;
	import flash.display.Sprite;
	import framework.interfaces.IDestructible;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Brick extends StaticActor implements IDestructible
	{
		
		public static const BRICK_HIT:String = "brickHit";
		public static const BRICK_DESTROYED:String = "brickDestroyed";
		
		private var _health:uint
		private var _colors:Vector.<uint>;
		
		public function Brick(width:Number, height:Number, health:uint, colors:Vector.<uint>, x:Number = 0, y:Number = 0, name:String = null) 
		{
			_health = health;
			_colors = colors;
			var model:Sprite = new Sprite();
			model.x = x;
			model.y = y;
			model.graphics.beginFill(_colors[_health - 1]);
			model.graphics.drawRect(0, 0, width, height);
			model.graphics.endFill();
			super(model, name);
		}
		
		public function hit():void
		{
			health -= 1;
		}
		
		// Get/set methods //
		private function get health():uint
		{
			return _health;
		}
		
		private function set health(value:uint):void
		{
			_health = value;
			
			if (_health <= 0)
			{
				dispatchEvent(new ActorEvent(BRICK_DESTROYED, this));
				
				dispose();
			}
			else
			{
				dispatchEvent(new ActorEvent(BRICK_HIT, this));
				
				render();
			}
		}
		
		private function render():void
		{
			model.graphics.clear();
			model.graphics.beginFill(_colors[_health - 1]);
			model.graphics.drawRect(0, 0, _model.width, _model.height);
			model.graphics.endFill();
		}
		
	}

}
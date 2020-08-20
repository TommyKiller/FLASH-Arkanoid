package actors.models 
{
	import actors.ActorsManager;
	import actors.controllers.BallController;
	import flash.display.Sprite;
	import flash.events.Event;
	import interfaces.IDisposable;
	import interfaces.IRenderable;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Ball extends Sprite implements IDisposable, IRenderable
	{
		
		private var _radius:Number;
		private var _speed:uint;
		private var _color:uint;
		private var _disposed:Boolean;
		
		public function Ball(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null) 
		{
			_radius = radius;
			_speed = speed;
			_color = color;
			this.x = x;
			this.y = y;
			this.name = name ? name : NameUtil.createUniqueName(this);
			_disposed = false;
			
			render();
		}
		
		// Get/set methods //
		public function get speed():Number
		{
			return _speed;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function set radius(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Radius of the ball must be greater than 0.");
			}
			
			_radius = value;
		}
		
		// Event handlers //
		public function onEnterFrameEventHandler(event:Event):void
		{
			BallController.Move(this);
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				ActorsManager.removeObject(this);
				BallController.deactivate(this);
				_disposed = true;
			}
		}
		
		/* INTERFACE interfaces.IRenderable */
		
		public function render():void
		{
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
		
	}

}
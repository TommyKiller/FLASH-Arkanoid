package actors 
{
	import actors.ActorsManager;
	import actors.events.ActorEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import interfaces.IDisposable;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Brick extends Sprite implements IDisposable
	{
		
		public static const BRICK_HIT:String = "brickHit";
		public static const BRICK_DESTROYED:String = "brickDestroyed";
		
		private var _width:Number;
		private var _height:Number;
		private var _disposed:Boolean;
		private var _health:uint
		private var _colors:Vector.<uint>;
		
		public function Brick(width:Number, height:Number, health:uint, colors:Vector.<uint>, x:Number = 0, y:Number = 0, name:String = null) 
		{
			this.width = width;
			this.height = height;
			_health = health;
			_colors = colors;
			this.x = x;
			this.y = y;
			this.name = name ? name : NameUtil.createUniqueName(this);
			_disposed = false;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			render();
		}
		
		public function hit():void
		{
			health -= 1;
		}
		
		// Get/set methods //
		public function get health():uint
		{
			return _health;
		}
		
		public function set health(value:uint):void
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
		
		public function get color():Vector.<uint>
		{
			return _colors;
		}
		
		public override function get width():Number
		{
			return _width;
		}
		
		public override function set width(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Width of the brick must be greater than 0.");
			}
			
			_width = value;
		}
		
		public override function get height():Number
		{
			return _height;
		}
		
		public override function set height(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Height of the brick must be greater than 0.");
			}
			
			_height = value;
		}
		
		private function render():void
		{
			graphics.clear();
			graphics.beginFill(color[_health - 1]);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{				
				ActorsManager.removeObject(this);
				
				_disposed = true;
			}
		}		
		
	}

}
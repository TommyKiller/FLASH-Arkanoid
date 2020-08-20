package actors.models
{
	import actors.ActorsManager;
	import actors.controllers.PlatformController;
	import flash.display.Shape;
	import flash.display.Sprite;
	import input.events.AxisEvent;
	import interfaces.IDisposable;
	import interfaces.IRenderable;
	import mx.utils.NameUtil
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Platform extends Sprite implements IDisposable, IRenderable
	{
		private var _width:Number;
		private var _height:Number;
		private var _speed:uint;
		private var _color:uint;
		private var _disposed:Boolean;
		
		public function Platform(width:Number, height:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null)
		{
			this.width = width;
			this.height = height;
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
		
		public override function get width():Number
		{
			return _width;
		}
		
		public override function set width(value:Number):void
		{
			if (value <= 0)
			{
				throw new Error("Width of the platform must be greater than 0.");
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
				throw new Error("Height of the platform must be greater than 0.");
			}
			
			_height = value;
		}
		
		// Event handlers //
		public function onMoveRightEventHandler(event:AxisEvent):void
		{
			PlatformController.MoveRight(this, event.result.axisValue);
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				ActorsManager.removeObject(this);
				PlatformController.deactivate(this);
				_disposed = true;
			}
		}
		
		/* INTERFACE interfaces.IRenderable */
		
		public function render():void
		{
			graphics.beginFill(color);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	
	}

}
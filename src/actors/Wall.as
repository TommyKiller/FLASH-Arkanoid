package actors 
{
	import flash.display.Shape;
	import flash.events.Event;
	import interfaces.IDisposable;
	import interfaces.IRenderable;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Wall extends Shape implements IDisposable, IRenderable
	{
		
		private var _width:Number;
		private var _height:Number;
		private var _color:uint;
		private var _disposed:Boolean;
		
		public function Wall(width:Number, height:Number, color:uint, x:Number = 0, y:Number = 0, name:String = null) 
		{
			this.width = width;
			this.height = height;
			_color = color;
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
		
		// Get/set methods //		
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
				throw new Error("Width of the wall must be greater than 0.");
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
				throw new Error("Height of the wall must be greater than 0.");
			}
			
			_height = value;
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
		
		/* INTERFACE interfaces.IRenderable */
		
		public function render():void 
		{
			graphics.beginFill(color);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
	}

}
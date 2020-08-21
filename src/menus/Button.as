package menus 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import interfaces.IDisposable;
	import interfaces.IRenderable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Button extends SimpleButton implements IDisposable, IRenderable
	{
		private var _callback:Function;
		private var _buttonSprite:ButtonSprite;
		private var _disposed:Boolean;
		
		public function Button(callback:Function, buttonSprite:ButtonSprite, x:Number = 0, y:Number = 0) 
		{
			super(buttonSprite, buttonSprite, buttonSprite, buttonSprite);
			this.x = x;
			this.y = y;
			_callback = callback;
			_buttonSprite = buttonSprite;
			_disposed = false;
			
			addEventListener(MouseEvent.CLICK, _callback);
			render();
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void 
		{
			if (!_disposed)
			{
				removeEventListener(MouseEvent.CLICK, _callback);
			}
			
			_disposed = true;
		}
		
		/* INTERFACE interfaces.IRenderable */
		
		public function render():void 
		{
			_buttonSprite.render();
		}
		
	}

}
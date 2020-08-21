package menus 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class GameMenu extends Sprite implements IDisposable
	{
		
		private var _disposed:Boolean;
		
		public function GameMenu(name:String) 
		{
			this.name = name;
			_disposed = false;
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void 
		{
			if (!_disposed)
			{
				removeChildren();
			}
		}
		
	}

}
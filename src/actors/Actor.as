package actors 
{
	import flash.display.Sprite;
	import interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Actor extends Sprite implements IDisposable
	{
		
		protected var _disposed:Boolean;
		
		public function Actor() 
		{
			_disposed = false;
		}
		
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void 
		{
			
		}
		
	}

}
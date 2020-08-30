package ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Menu extends Sprite implements IDisposable
	{
		
		protected var _disposed:Boolean;
		
		public function Menu() 
		{			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == Menu)
			{
				throw new Error("Menu is an abstract class and is not meant for instantiation.");
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			_disposed = false;
			visible = false;
		}
		
		public function show():void
		{
			visible = true;
		}
		
		public function close():void
		{
			visible = false;
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				stage.removeChild(this);
				
				_disposed = true;
			}
		}
		
	}

}
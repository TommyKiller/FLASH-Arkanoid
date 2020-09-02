package framework.ui 
{]
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import framework.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class View extends Sprite implements IDisposable
	{
		
		protected var _disposed:Boolean;
		
		public function View() 
		{			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == View)
			{
				throw new Error("Menu is an abstract class and is not meant for instantiation.");
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			_disposed = false;
		}
		
		public function show():void
		{
			visible = true;
		}
		
		public function hide():void
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
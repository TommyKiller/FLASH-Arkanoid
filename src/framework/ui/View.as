package framework.ui 
{
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
		protected var _controller:Controller;
		
		public function View() 
		{
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == View)
			{
				throw new Error("View is an abstract class and is not meant for instantiation.");
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			var viewClassName:String = getQualifiedClassName(this);
			var controllerClassName:String = viewClassName.replace("views", "controllers").replace("View", "Controller");
			controller = new (Class(getDefinitionByName(controllerClassName)))(this);
			
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
		
		// Get/set methods //
		public function get controller():Controller
		{
			return _controller;
		}
		
		public function set controller(value:Controller):void
		{
			_controller = value;
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
package framework.ui
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import framework.interfaces.IDisposable;
	import framework.ui.View;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Controller extends EventDispatcher implements IDisposable
	{
		
		protected var _disposed:Boolean;
		protected var _view:View;
		
		public function Controller(view:View)
		{
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == Controller)
			{
				throw new Error("Controller is an abstract class and is not meant for instantiation.");
			}
			
			_disposed = false;
			_view = view;
		}
		
		// Get/set methods //
		protected function get disposed():Boolean
		{
			return _disposed;
		}
		
		public function get view():View
		{
			return _view;
		}
		
		public function set view(value:View):void
		{
			if (_view)
			{
				_view.dispose();
			}
			
			_view = value;
		}
		
		/* INTERFACE framework.interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				_view.dispose();
			}
			
			_disposed = true;
		}
	
	}

}
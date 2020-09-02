package framework.ui 
{
	import flash.events.EventDispatcher;
	import framework.ui.View;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Controller extends EventDispatcher 
	{
		
		private static var _view:View;
		
		// Get/set methods //
		public static function get view():View
		{
			return _view;
		}
		
		public static function set view(value:View):void
		{
			if (_view)
			{
				_view.dispose();
			}
			
			_view = value;
		}
		
	}

}
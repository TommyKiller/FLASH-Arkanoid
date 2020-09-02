package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import framework.input.InputController;
	import framework.input.InputLayout;
	import views.MainView;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Application extends Sprite 
	{
		private static var _instance:Application;
		
		public function Application() 
		{
			if (_instance)
			{
				throw new Error("You cannot create instance of application class.");
			}
			
			_instance = this;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Components initialization //
			new InputController(stage);
			InputLayout.getInstance().loadLayout();
			
			// Startup //
			stage.addChild(new MainView());
		}
		
		// Get/set methods //
		
		public static function get stage():Stage
		{
			return _instance.stage;
		}
		
	}
	
}
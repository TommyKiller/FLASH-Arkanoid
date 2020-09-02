package controllers
{
	import framework.ui.Controller;
	import views.MainView;
	import views.SelectLevelView;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class SelectLevelController extends Controller
	{
		
		public static function startLevel(level:Class):void
		{
			trace("level selected");
		}
		
		public static function back():void
		{
			view.dispose();
			Application.stage.addChild(new MainView());
		}
	
	}

}
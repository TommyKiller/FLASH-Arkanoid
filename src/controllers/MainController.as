package controllers
{
	import flash.system.fscommand;
	import framework.ui.Controller;
	import views.MainView;
	import views.SelectLevelView;
	import framework.ui.View;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class MainController extends Controller
	{
		
		public static function selectLevel():void
		{
			view.dispose();
			Application.stage.addChild(new SelectLevelView());
		}
		
		public static function exit():void
		{
			fscommand("quit");
		}
	
	}

}
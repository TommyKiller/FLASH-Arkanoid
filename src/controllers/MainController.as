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
		
		public function MainController(view:MainView)
		{
			super(view);
		}
		
		public function selectLevel():void
		{
			Application.stage.addChild(new SelectLevelView());
			
			dispose();
		}
		
		public function exit():void
		{
			fscommand("quit");
		}
	
	}

}
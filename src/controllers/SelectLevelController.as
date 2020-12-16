package controllers
{
	import flash.display.Stage;
	import framework.ui.Controller;
	import models.GameModel;
	import views.GameView;
	import views.MainView;
	import views.SelectLevelView;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class SelectLevelController extends Controller
	{
		
		public function SelectLevelController(view:SelectLevelView)
		{
			super(view);
		}
		
		public function startLevel(level:Class):void
		{
			Application.stage.addChild(new GameView(new GameModel(level)));
			
			dispose();
		}
		
		public function back():void
		{
			Application.stage.addChild(new MainView());
			
			dispose();
		}
	
	}

}
package controllers 
{
	import flash.display.Stage;
	import framework.graphics.Scene;
	import framework.ui.Controller;
	import views.GameView;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class GameController extends Controller 
	{
		
		private var _scene:Scene;
		
		public function GameController(view:GameView) 
		{
			super(view);
			
			_scene = new Scene((view as GameView).sceneStage);
		}
		
	}

}
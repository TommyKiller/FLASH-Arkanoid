package controllers 
{
	import flash.display.Stage;
	import framework.graphics.Scene;
	import framework.ui.Controller;
	import models.GameModel;
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
		}
		
		public function init(model:GameModel):void
		{
			trace("Start game");
		}
		
	}

}
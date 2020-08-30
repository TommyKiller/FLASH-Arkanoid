package 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import ui.GameUI;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Game extends EventDispatcher 
	{
		
		private var _score:uint;
		private var _health:uint;
		private var _bricksDestroyed:uint;
		private var _ui:GameUI;
		
		public function Game() 
		{
			_ui = new GameUI();
			
			init();
		}
		
		private function init():void
		{
			health = 3;
			score = 0;
			bricksDestroyed = 0;
		}
		
		// Get/set methods //
		private function get health():uint
		{
			return _health;
		}
		
		private function set health(value:uint):void
		{
			_health = value;
			_ui.updateLabel(GameUI.LABEL_HEALTH, "Health: " + _health);
		}
		
		private function get score():uint
		{
			return _score;
		}
		
		private function set score(value:uint):void
		{
			_score = value;
			_ui.updateLabel(GameUI.LABEL_SCORE, "Score: " + _score);
		}
		
		private function get bricksDetroyed():uint
		{
			return _bricksDestroyed;
		}
		
		private function set bricksDestroyed(value:uint):void
		{
			_bricksDestroyed = value;
			_ui.updateLabel(GameUI.LABEL_BRICKS_DESTROYED, "Bricks destroyed: " + _bricksDestroyed);
		}
		
	}

}
package
{
	import actors.ActorsManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import input.InputController;
	import input.InputEvent;
	import input.InputLayout;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			// Components initialization //
			removeEventListener(Event.ADDED_TO_STAGE, init);
			InputController.getInstance(stage);
			setUpLayout();
			ActorsManager.initialize(stage);
			
			// Spawnig objects //
			ActorsManager.createPlatform(200, 20, 25, 0xFD06AB, "playerPlatform", stage.stageWidth / 2 - 100, stage.stageHeight - 20);
		}
		
		private function setUpLayout():void
		{
			InputLayout.getInstance().createAxis("MoveRightAxis").bindTo(InputEvent.A_KEY_DOWN, -1).bindTo(InputEvent.D_KEY_DOWN, 1);
		}
		
	}
	
}
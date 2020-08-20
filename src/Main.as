package
{
	import actors.ActorsManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import input.InputController;
	import input.events.InputEvent;
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
			ActorsManager.createPlatform(200, 20, 25, 0xFD06AB, stage.stageWidth / 2 - 100, stage.stageHeight - 20, "playerPlatform");
			ActorsManager.createBall(10, 25, 0xA313D6, stage.stageWidth / 2, stage.stageHeight - 30);
			ActorsManager.createBrick(50, 30, 0x000000, 100, 150);
		}
		
		private function setUpLayout():void
		{
			InputLayout.getInstance().createAxis("MoveRightAxis").bindTo(InputEvent.A_KEY, -1).bindTo(InputEvent.D_KEY, 1);
			//InputLayout.getInstance().getAxis("MoveRightAxis").bindTo(InputEvent.MOUSE_AXIS_X_NEGATIVE, -1).bindTo(InputEvent.MOUSE_AXIS_X_POSITIVE, 1);
		}
		
	}
	
}
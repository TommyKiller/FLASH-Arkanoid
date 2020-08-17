package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import input.AxisBinding;
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
			removeEventListener(Event.ADDED_TO_STAGE, init);
			InputController.getInstance(stage);
			InputLayout.getInstance().createAxis("MoveXAxis").bindTo(InputEvent.A_KEY_DOWN, -1).bindTo(InputEvent.D_KEY_DOWN, 1);
			InputLayout.getInstance().deleteAxis("MoveXAxis");
		}
		
	}
	
}
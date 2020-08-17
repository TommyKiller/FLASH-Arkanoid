package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import menus.MainMenu;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Main extends Sprite 
	{
		
		private var menu:MainMenu;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			menu = new MainMenu(stage);
			stage.addChild(menu);
		}
		
	}
	
}
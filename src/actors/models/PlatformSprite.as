package actors.models 
{
	import actors.controllers.PlatformController;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class PlatformSprite extends Sprite 
	{
		
		public function PlatformSprite(stage:DisplayObjectContainer) 
		{
			super();
			addEventListener(Event.ENTER_FRAME, PlatformController.onEnterFramEventHandler);
			stage.addChild(this);
		}
		
	}

}
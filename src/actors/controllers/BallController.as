package actors.controllers 
{
	import actors.models.Ball;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Tommy
	 */
	public class BallController 
	{
		
		public static function Move(ball:Ball):void
		{
			ball.y -= ball.speed;
		}
		
		public static function activate(ball:Ball):void
		{
			ball.stage.addEventListener(Event.ENTER_FRAME, ball.onEnterFrameEventHandler);
		}
		
		public static function deactivate(ball:Ball):void
		{
			ball.stage.removeEventListener(Event.ENTER_FRAME, ball.onEnterFrameEventHandler);
		}
		
	}

}
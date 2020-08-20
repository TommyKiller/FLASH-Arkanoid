package actors.controllers 
{
	import actors.models.Platform;
	import flash.display.Stage;
	import input.InputLayout;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class PlatformController 
	{
		
		public static function MoveRight(platform:Platform, scale:Number):void
		{
			var resultPosition:Number = platform.x + scale * platform.speed;
			
			if (resultPosition + platform.width <= platform.stage.stageWidth && resultPosition >= 0)
			{
				platform.x = resultPosition;
			}
		}
		
		public static function activate(platform:Platform):void
		{
			InputLayout.getInstance().bindAxis("MoveRightAxis", platform.onMoveRightEventHandler);
		}
		
		public static function deactivate(platform:Platform):void
		{
			InputLayout.getInstance().unbindAxis("MoveRightAxis", platform.onMoveRightEventHandler);
		}
		
	}

}
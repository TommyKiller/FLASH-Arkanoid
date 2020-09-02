package actors
{
	import framework.graphics.actors.events.PawnActorEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import framework.input.InputLayout;
	import framework.input.events.AxisEvent;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Platform extends PawnActor
	{
		
		public static const PLATFORM_MOVED:String = "platformMoved";
		
		public function Platform(width:Number, height:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null)
		{
			var model:Sprite = new Sprite();
			model.x = x;
			model.y = y;
			model.graphics.beginFill(color);
			model.graphics.drawRect(0, 0, width, height);
			model.graphics.endFill();
			super(model, speed, name);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
			InputLayout.getInstance().bindAxis("MoveRightAxis", onMoveRightEventHandler);
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(event:Event):void
		{
			var newX:Number = x + velocity.x * speed;
			
			if (newX >= 0 && newX + width <= stage.stageWidth)
			{
				x = newX;
				
				dispatchEvent(new PawnActorEvent(PLATFORM_MOVED, this));
			}
		}
		
		private function onMoveRightEventHandler(event:AxisEvent):void
		{
			_velocity.x = event.result.axisValue;
		}
		
		public override function dispose():void
		{
			if (!_disposed)
			{
				super().dispose();
				
				// Unsubscribe from events //
				InputLayout.getInstance().unbindAxis("MoveRightAxis", onMoveRightEventHandler);
				removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
			}
		}
	
	}

}
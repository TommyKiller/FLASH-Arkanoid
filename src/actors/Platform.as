package actors
{
	import framework.actors.PawnActor;
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
			var newX:Number = model.x + velocity.x * speed;
			
			if (newX >= 0 && newX + model.width <= model.stage.stageWidth)
			{
				model.x = newX;
				
				dispatchEvent(new PawnActorEvent(PawnActorEvent.ACTOR_MOVED, this));
			}
		}
		
		private function onMoveRightEventHandler(event:AxisEvent):void
		{
			velocity.x = event.result.axisValue;
		}
		
		override public function dispose():void
		{
			if (!disposed)
			{
				super.dispose();
				
				// Unsubscribe from events //
				InputLayout.getInstance().unbindAxis("MoveRightAxis", onMoveRightEventHandler);
				removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
			}
		}
	
	}

}
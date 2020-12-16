package actors
{
	import framework.actors.PawnActor;
	import framework.actors.events.ActorEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import framework.graphics.actors.events.PawnActorEvent;
	import framework.input.InputLayout;
	import framework.input.events.ActionEvent;
	import framework.interfaces.IDisposable;
	import mx.utils.NameUtil;
	import framework.physics.CollisionManager;
	import framework.geom.Vector2D;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Ball extends PawnActor
	{
		
		public static const BALL_DESTROYED:String = "ballDestroyed";
		
		private var _pawnActor:PawnActor;
		
		public function Ball(radius:Number, speed:uint, color:uint, x:Number = 0, y:Number = 0, name:String = null)
		{
			var model:Sprite = new Sprite();
			model.graphics.beginFill(color);
			model.graphics.drawCircle(x, y, radius);
			model.graphics.endFill();
			super(model, speed, name);
			velocity.y = -1;
		}
		
		// Event handlers //
		private function onEnterFrameEventHandler(event:Event):void
		{
			var oldX:Number = model.x;
			var oldY:Number = model.y;
			model.x += _velocity.x * speed;
			model.y += _velocity.y * speed;
			
			//var collisions:Array = CollisionManager.getInstance().checkCollisions(this);
			//
			//if (collisions)
			//{
				//for (var i:int = 0; i < collisions.length; i++)
				//{
					//var brick:Brick = collisions[i].object2 as Brick;
					//if (brick)
					//{
						//brick.hit();
					//}
					//else if (this !== collisions[i].object1)
					//{
						//brick = collisions[i].object1 as Brick;
						//
						//if (brick)
						//{
							//brick.hit();
						//}
					//}
					//
					//var angle:Number = Math.PI - collisions[i].angle;
					//_velocity.rotate(angle);
					//
					///*var platform:Platform = collisions[i].object2 as Platform;
					   //if (platform)
					   //{
					   //_velocity.x += platform.friction * platform.velocity.x;
					   //}
					   //else if (this !== collisions[i].object1)
					   //{
					   //platform = collisions[i].object1 as Platform;
					//
					   //if (platform)
					   //{
					   //_velocity.x += platform.friction * platform.velocity.x;
					   //}
					   //}*/
					//
					//_velocity.unit();
				//}
			//}
			
			model.x = oldX + _velocity.x * speed;
			model.y = oldY + _velocity.y * speed;
			
			if (model.y > model.stage.stageHeight)
			{
				dispatchEvent(new ActorEvent(BALL_DESTROYED, this));
				
				dispose();
			}
		}
		
		private function pawnActorMovedEventHandler(event:PawnActorEvent):void
		{
			model.x += event.actor.speed * event.actor.velocity.x;
		}
		
		private function startBouncing(event:ActionEvent):void
		{
			InputLayout.getInstance().getAction("ThrowBall").removeEventListener(ActionEvent.ACTION_KEY_DOWN, startBouncing);
			_pawnActor.removeEventListener(PawnActorEvent.ACTOR_MOVED, pawnActorMovedEventHandler);
			_pawnActor = null;
			model.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
		}
		
		public function stickTo(actor:PawnActor):void
		{
			actor.addEventListener(PawnActorEvent.ACTOR_MOVED, pawnActorMovedEventHandler);
			_pawnActor = actor;
			model.x = actor.model.x + actor.model.width / 2 - actor.model.width;
			model.y = actor.model.y - actor.model.width;
			
			InputLayout.getInstance().getAction("ThrowBall").addEventListener(ActionEvent.ACTION_KEY_DOWN, startBouncing);
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public override function dispose():void
		{
			if (!disposed)
			{
				super.dispose();
				
				model.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameEventHandler);
				
			}
		}
	
	}

}
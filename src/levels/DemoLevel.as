package levels 
{
	import actors.Ball;
	import actors.Brick;
	import actors.Platform;
	import actors.Wall;
	import framework.graphics.actors.events.ActorEvent;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import framework.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class DemoLevel extends EventDispatcher implements IDisposable
	{
		
		public static const LEVEL_CLEARED:String = "levelCleared";
		
		private var _stage:Stage;
		private var _loaded:Boolean;
		private var _disposed:Boolean;
		private var _walls:Vector.<Wall>;
		private var _ball:Ball;
		private var _platform:Platform;
		private var _brickRows:Vector.<BrickRow>;
		private var _ballSpeed:Number;
		
		public function DemoLevel(stage:Stage)
		{
			_stage = stage;
			_loaded = false;
			_disposed = false;
			_ballSpeed = 10;
			_walls = new Vector.<Wall>();
			_brickRows = new Vector.<BrickRow>();
		}
		//
		//public function start():void
		//{
			//if (_loaded)
			//{
				//spawnBall();
			//}
		//}
		//
		//public function load():void
		//{
			//spawnWalls();
			//spawnBricks();
			//spawnPlatform();
			//_loaded = true;
		//}
		//
		//private function spawnBricks():void
		//{
			//var colors:Vector.<uint> = new <uint>[0xFF0000, 0x00FF00, 0x0000FF];
			//
			//for (var j:int = 0; j < 4; j++)
			//{
				//var row:BrickRow = new BrickRow();
				//row.addEventListener(BrickRow.ROW_DESTROYED, onRowDestroyedEventHandler);
				//
				//for (var i:int = 0; i < 7; i++)
				//{
					//var brick:Brick = ActorsManager.createBrick(50, 30, colors.length, colors, 25 + i * 70, 25 + j * 50);
					//brick.addEventListener(Brick.BRICK_HIT, onBrickHitEventHandler);
					//brick.addEventListener(Brick.BRICK_DESTROYED, onBrickDestroyedEventHandler);
					//row.push(brick);
				//}
				//
				//_brickRows.push(row);
			//}
		//}
		//
		//private function spawnWalls():void
		//{
			//_walls.push(ActorsManager.createWall(20, _stage.stageHeight, 0xFF00FF, -20, 0));
			//_walls.push(ActorsManager.createWall(20, _stage.stageHeight, 0xFF00FF, _stage.stageWidth, 0));
			//_walls.push(ActorsManager.createWall(_stage.stageWidth, 20, 0xFF00FF, 0, -20));
		//}
		//
		//private function spawnPlatform():void
		//{
			//_platform = ActorsManager.createPlatform(200, 20, 25, 0xFD06AB, 0.5, _stage.stageWidth / 2 - 100, _stage.stageHeight - 20, "LongPlatform");
		//}
		//
		//private function spawnBall():void
		//{
			//_ball = ActorsManager.createBall(10, _ballSpeed, 0xA313D6, 0, 0, true, "BigBall");
			//_ball.addEventListener(Ball.BALL_DESTROYED, onBallDestroyedEventHandler);
			//_ball.stickToPlatform(_platform);
		//}
		//
		//private function shiftBricks():void
		//{
			//for (var i:int = 0; i < _brickRows.length; i++)
			//{
				//var brick:Brick;
				//
				//for (var j:int = 0; j < _brickRows[i].length; j++)
				//{
					//brick = _brickRows[i].getBrick(j);
					//
					//brick.y += 50;
				//}
			//}
		//}
		//
		//// Event handlers //
		//private function onBrickHitEventHandler(event:ActorEvent):void
		//{
			//Application.score += 1;
		//}
		//
		//private function onBrickDestroyedEventHandler(event:ActorEvent):void
		//{
			//Application.score += 5;
			//
			//Application.bricksDestroyed += 1;
		//}
		//
		//private function onRowDestroyedEventHandler(event:Event):void
		//{
			//Application.score += 10;
			//
			//for (var i:int = 0; i < _brickRows.length; i++)
			//{
				//if (_brickRows[i].length == 0)
				//{
					//_brickRows.removeAt(i);
					//
					//break;
				//}
			//}
				//
			//if (_brickRows.length == 0)
			//{
				//dispatchEvent(new Event(LEVEL_CLEARED));
			//}
			//
			//shiftBricks();
			//
			//(ActorsManager.getActor("BigBall") as Ball).speed += 3;
			//_ballSpeed += 3;
		//}
		//
		//private function onBallDestroyedEventHandler(event:ActorEvent):void
		//{
			//Application.health -= 1;
			//
			//if (!_disposed)
			//{
				//_ball = null;
				//spawnBall();
			//}
		//}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void 
		{
			if (!_disposed)
			{
				for (var i:int = 0; i < _walls.length; i++)
				{
					_walls[i].dispose();
				}
				_walls = null;
			
				for (i = 0; i < _brickRows.length; i++)
				{
					_brickRows[i].dispose();
				}
				_brickRows = null;
				
				_platform.dispose();
				
				if (_ball)
				{
					_ball.dispose();
				}
				_ball = null;
				
				_disposed = true;
			}
		}
		
	}

}
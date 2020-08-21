package
{
	import actors.ActorsManager;
	import actors.Ball;
	import actors.Brick;
	import actors.events.ActorEvent;
	import flash.system.fscommand;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import input.InputController;
	import input.events.InputEvent;
	import input.InputLayout;
	import menus.Button;
	import menus.ButtonSprite;
	import menus.ButtonSpriteText;
	import menus.MenuManager;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Game extends Sprite 
	{
		private static var _stage:Stage;
		private static var _bricksCount:uint;
		private static var _ballsCount:uint;
		
		public function Game() 
		{
			if (_stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Setup game settings //
			Game._stage = this.stage;
			_bricksCount = 0;
			_ballsCount = 0;
			
			// Components initialization //
			InputController.getInstance(stage);
			ActorsManager.initialize(stage);
			ActorsManager.addEventListener(ActorEvent.ACTOR_SPAWNED,  onActorSpawnedEventHandler);
			ActorsManager.addEventListener(ActorEvent.ACTOR_DISPOSED, onActorDisposedEventHandler);
			MenuManager.initialize(stage);
			
			MenuManager.createMenu("Main Menu",
				MenuManager.createButton(StartDemoLevel, "DEMO LEVEL", stage.stageWidth / 2 - 70, 200, 26, "Times New Roman", 0x0077FF),
				MenuManager.createButton(Exit, "EXIT", stage.stageWidth / 2 - 20, 280, 26, "Times New Roman", 0x0077FF));
		}
		
		// Get/set methods //
		private static function get bricksCount():uint
		{
			return _bricksCount;
		}
		
		private static function set bricksCount(value:uint):void
		{
			_bricksCount = value;
			
			if (_bricksCount == 0)
			{
				Victory();
			}
		}
		
		private static function get ballsCount():uint
		{
			return _ballsCount;
		}
		
		private static function set ballsCount(value:uint):void
		{
			_ballsCount = value;
			
			if (_ballsCount == 0)
			{
				GameOver();
			}
		}
		
		// Behaviour //
		
		public static function StartDemoLevel(event:MouseEvent = null):void
		{
			MenuManager.removeMenu("Main Menu");
			InputLayout.getInstance().loadLayout();
			
			ActorsManager.createWall(20, _stage.stageHeight, 0xFF00FF, -20, 0);
			ActorsManager.createWall(20, _stage.stageHeight, 0xFF00FF, _stage.stageWidth, 0);
			ActorsManager.createWall(_stage.stageWidth, 20, 0xFF00FF, 0, -20);
			ActorsManager.createPlatform(200, 20, 25, 0xFD06AB, 0.5, _stage.stageWidth / 2 - 100, _stage.stageHeight - 20, "playerPlatform");
			ActorsManager.createBall(10, 15, 0xA313D6, _stage.stageWidth / 2, _stage.stageHeight - 29);
			for (var i:int = 0; i < 18; i++)
			{
				for (var j:int = 0; j < 10; j++)
				{
					ActorsManager.createBrick(50, 30, 0x000000, 25 + i * 70, 25 + j * 50);
				}
			}
		}
		
		private static function Victory():void
		{
			InputLayout.getInstance().deleteAxis("MoveRightAxis");
			
			var format:TextFormat = new flash.text.TextFormat();
			format.size = 30;
			format.font = "Times New Roman";
			format.color = 0x00FF00;
			format.bold = true;
			format.align = TextFormatAlign.CENTER
			var text:TextField = new TextField();
			text.text = "YOU WIN!";
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			text.x = _stage.stageWidth / 2 - text.width / 2;
			text.y = _stage.stageHeight / 2 - text.height / 2;
			_stage.addChild(text);
		}
		
		private static function GameOver():void
		{
			InputLayout.getInstance().deleteAxis("MoveRightAxis");
			
			var format:TextFormat = new flash.text.TextFormat();
			format.size = 30;
			format.font = "Times New Roman";
			format.color = 0xFF0000;
			format.bold = true;
			format.align = TextFormatAlign.CENTER
			var text:TextField = new TextField();
			text.text = "GAME OVER MAN!";
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			text.x = _stage.stageWidth / 2 - text.width / 2;
			text.y = _stage.stageHeight / 2 - text.height / 2;
			_stage.addChild(text);
		}
		
		private static function Exit(event:MouseEvent = null):void
		{
			fscommand("quit");
		}
		
		// Event handlers //
		
		private static function onActorSpawnedEventHandler(event:ActorEvent):void
		{
			if (event.actor is Brick)
			{
				bricksCount++;
			}
			else if (event.actor is Ball)
			{
				ballsCount++;
			}
		}
		
		private static function onActorDisposedEventHandler(event:ActorEvent):void
		{
			if (event.actor is Brick)
			{
				bricksCount--;
			}
			else if (event.actor is Ball)
			{
				ballsCount--;
			}
		}
		
	}
	
}
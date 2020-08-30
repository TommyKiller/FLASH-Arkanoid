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
	import input.events.ActionEvent;
	import input.events.InputEvent;
	import input.InputLayout;
	import levels.DemoLevel;
	import ui.MainMenu;
	import ui.Menu;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Application extends Sprite 
	{
		private static var _stage:Stage;
		private static var _level:DemoLevel;
		private static var _healthBar:TextField;
		private static var _scoreBar:TextField;
		private static var _bricksDestroyedBar:TextField;
		private static var _endGameLabel:TextField;
		private static var _active:Boolean;
		
		public function Application() 
		{
			if (_stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Setup game settings //
			Application._stage = this.stage;
			_active = false;
			
			// Components initialization //
			InputController.getInstance(stage);
			ActorsManager.initialize(stage);
			MenuManager.initialize(stage);
			InputLayout.getInstance().loadLayout();
			
			var test:MainMenu = new MainMenu();
			//loadMenu();
		}
		
		// Get/set methods //
		public static function get bricksDestroyed():uint
		{
			return _bricksDestroyed;
		}
		
		public static function set bricksDestroyed(value:uint):void
		{
			_bricksDestroyed = value;
			_bricksDestroyedBar.text = "Bricks destroyed: " + _bricksDestroyed.toString();
		}
		
		public static function get score():uint
		{
			return _score;
		}
		
		public static function set score(value:uint):void
		{
			_score = value;
			_scoreBar.text = "Score: " + _score.toString();
		}
		
		public static function get health():uint
		{
			return _health;
		}
		
		public static function set health(value:uint):void
		{
			_health = value;
			_healthBar.text = "Health: " + _health.toString();
			
			if (_health == 0 && _active)
			{
				defeat();
			}
		}
		
		// Event handlers //		
		private static function startDemoLevel(event:MouseEvent = null):void
		{
			MenuManager.removeMenu("Main Menu");
			
			_active = true;
			_level = new DemoLevel(_stage);
			_level.addEventListener(DemoLevel.LEVEL_CLEARED, victory);
			_level.load();
			var format:TextFormat = formatText(15, "Times New Roman", 0xFF55DD);
			_healthBar = spawnTextField(_health.toString(), TextFieldAutoSize.LEFT, format, 0, 0, false, "healthBar");
			_scoreBar = spawnTextField(_score.toString(), TextFieldAutoSize.LEFT, format, 70, 0, false, "scoreBar");
			_bricksDestroyedBar = spawnTextField(_score.toString(), TextFieldAutoSize.LEFT, format, 150, 0, false, "bricksDestroyedBar");
			health = 3;
			score = 0;
			bricksDestroyed = 0;
			_level.start();
		}
		
		private static function backToMenu(event:ActionEvent = null):void
		{
			removeTextFields();
			_level.dispose();
			InputLayout.getInstance().unbindAction("BackToMenu", ActionEvent.ACTION_KEY_DOWN, backToMenu);
			loadMenu();
		}
		
		private static function exit(event:MouseEvent = null):void
		{
			fscommand("quit");
		}
		
		private static function victory(event:Event = null):void
		{
			_active = false;
			_level.dispose();
			var format:TextFormat = formatText(30, "Times New Roman", 0x00FF00);
			_endGameLabel = spawnTextField("YOU WIN!\nPRESS ESC TO EXIT TO MENU", TextFieldAutoSize.LEFT, format, _stage.stageWidth / 2 - 200, _stage.stageHeight / 2 - 50, true, "EndGameLabel");
			
			InputLayout.getInstance().bindAction("BackToMenu", ActionEvent.ACTION_KEY_DOWN, backToMenu);
		}
		
		private static function defeat(event:Event = null):void
		{
			_active = false;
			_level.dispose();
			var format:TextFormat = formatText(30, "Times New Roman", 0xFF0000);
			_endGameLabel = spawnTextField("GAME OVER MAN!\nPRESS ESC TO EXIT TO MENU", TextFieldAutoSize.LEFT, format, _stage.stageWidth / 2 - 200, _stage.stageHeight / 2 - 50, true, "EndGameLabel");
			
			InputLayout.getInstance().bindAction("BackToMenu", ActionEvent.ACTION_KEY_DOWN, backToMenu);
		}
		
		// Utils //
		private static function loadMenu():void
		{
			MenuManager.createMenu("Main Menu",
				MenuManager.createButton(startDemoLevel, "DEMO LEVEL", _stage.stageWidth / 2 - 70, 200, 26, "Times New Roman", 0x0077FF),
				MenuManager.createButton(exit, "EXIT", _stage.stageWidth / 2 - 20, 280, 26, "Times New Roman", 0x0077FF));
		}
		
		private static function removeTextFields():void
		{
			_stage.removeChild(_endGameLabel);
			_stage.removeChild(_healthBar);
			_stage.removeChild(_scoreBar);
			_stage.removeChild(_bricksDestroyedBar);
		}
		
		private static function spawnTextField(text:String, autoSize:String, format:TextFormat, x:Number, y:Number, multiline:Boolean = false, name:String = null):TextField
		{
			var textField:TextField = new TextField();
			textField.text = text;
			textField.multiline = multiline;
			textField.autoSize = autoSize;
			textField.setTextFormat(format);
			textField.x = x;
			textField.y = y;
			textField.name = name ? name : NameUtil.createUniqueName(textField);
			_stage.addChild(textField);
			
			return textField;
		}
		
		private static function formatText(size:Number, font:String, color:uint, align:String = TextFormatAlign.CENTER, bold:Boolean = true):TextFormat
		{
			var format:TextFormat = new TextFormat();
			format.size = size;
			format.font = font;
			format.color = color;
			format.bold = bold;
			format.align = align;
			
			return format;
		}
		
	}
	
}
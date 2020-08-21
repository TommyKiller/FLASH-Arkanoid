package menus 
{
	import flash.display.Stage;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Tommy
	 */
	public class MenuManager 
	{
		private static var _stage:Stage;
		
		public static function initialize(stage:Stage):void
		{
			_stage = stage;
		}
		
		public static function createButton(callback:Function, text:String, x:Number = 0, y:Number = 0, size:uint = 12, font:String = "Arial", textColor:Object = null, align:String = TextFormatAlign.CENTER, italic:Boolean = false, bold:Boolean = false, underline:Boolean = false, backgroundColor:Object = null):Button
		{
			var buttonSpriteText:ButtonSpriteText = new ButtonSpriteText(text, size, font, textColor, align, italic, bold, underline);
			var buttonSprite:ButtonSprite = new ButtonSprite(buttonSpriteText, backgroundColor);
			return new Button(callback, buttonSprite, x, y);
		}
		
		public static function createMenu(name:String, ... buttons):GameMenu
		{
			var menu:GameMenu = new GameMenu(name);
			_stage.addChild(menu);
			
			for (var i:int = 0; i < buttons.length; i++)
			{
				menu.addChild(buttons[i]);
			}
			
			return menu;
		}
		
		public static function removeMenu(name:String):void
		{
			_stage.removeChild(_stage.getChildByName(name));
		}
		
	}

}
package ui 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import ui.Menu;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class MainMenu extends Menu 
	{
		
		public function MainMenu() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			var textFormat:TextFormat;
			var buttonText:TextField;
			var button:SimpleButton;
			
			/* btnDemoLevel */
			// text format //
			textFormat = new TextFormat();
			textFormat.font = "Times New Roman";
			textFormat.size = 24;
			textFormat.color = 0x775599;
			textFormat.bold = true;
			textFormat.align = TextFormatAlign.CENTER;
			// text //
			buttonText = new TextField();
			buttonText.text = "DEMO LEVEL";
			buttonText.setTextFormat(textFormat);
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnDemoLevel";
			button.x = stage.stageWidth / 2 - button.width / 2;
			button.y = stage.stageHeight / 2 - button.height;
			button.addEventListener(MouseEvent.CLICK, btnDemoLevelClickEventHandler);
			addChild(button);
			
			/* btnExit */
			// text format //
			textFormat = new TextFormat();
			textFormat.font = "Times New Roman";
			textFormat.size = 24;
			textFormat.color = 0x775599;
			textFormat.bold = true;
			textFormat.align = TextFormatAlign.CENTER;
			// text //
			buttonText = new TextField();
			buttonText.text = "EXIT";
			buttonText.setTextFormat(textFormat);
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnExit";
			button.x = stage.stageWidth / 2 - button.width / 2;
			button.y = stage.stageHeight / 2 - button.height;
			button.addEventListener(MouseEvent.CLICK, btnExitClickEventHandler);
			addChild(button);
		}
		
		private function btnDemoLevelClickEventHandler(event:MouseEvent)
		{
			
		}
		
		private function btnExitClickEventHandler(event:MouseEvent)
		{
			fscommand("quit");
		}
		
	}

}
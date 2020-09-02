package views 
{
	import controllers.MainController;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import framework.ui.View;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class MainView extends View 
	{
		
		public function MainView() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			// Components initialization //
			var textFormat:TextFormat;
			var buttonText:TextField;
			var button:SimpleButton;
			
			/* btnSelectLevel */
			// text format //
			textFormat = new TextFormat();
			textFormat.font = "Times New Roman";
			textFormat.size = 24;
			textFormat.color = 0x775599;
			textFormat.bold = true;
			textFormat.align = TextFormatAlign.CENTER;
			// text //
			buttonText = new TextField();
			buttonText.text = "SELECT LEVEL";
			buttonText.setTextFormat(textFormat);
			buttonText.width = 200;
			buttonText.height = 25;
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnSelectLevel";
			button.x = stage.stageWidth / 2 - button.width / 2;
			button.y = stage.stageHeight / 2 - button.height;
			button.addEventListener(MouseEvent.CLICK, btnSelectLevelClickEventHandler);
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
			buttonText.width = 65;
			buttonText.height = 25;
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnExit";
			button.x = stage.stageWidth / 2 - button.width / 2;
			button.y = stage.stageHeight / 2 + button.height;
			button.addEventListener(MouseEvent.CLICK, btnExitClickEventHandler);
			addChild(button);
		}
		
		private function btnSelectLevelClickEventHandler(event:MouseEvent):void
		{
			(controller as MainController).selectLevel();
		}
		
		private function btnExitClickEventHandler(event:MouseEvent):void
		{
			(controller as MainController).exit();
		}
		
	}

}
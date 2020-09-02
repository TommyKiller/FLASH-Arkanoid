package views 
{
	import controllers.SelectLevelController;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import framework.ui.View;
	import levels.DemoLevel;
	/**
	 * ...
	 * @author Tommy
	 */
	public class SelectLevelView extends View 
	{
		
		public function SelectLevelView() 
		{
			super(SelectLevelController);
			
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
			buttonText.text = "DEMO";
			buttonText.setTextFormat(textFormat);
			buttonText.width = 80;
			buttonText.height = 25;
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnSelectLevel";
			button.x = stage.stageWidth / 2 - button.width / 2 * 5;
			button.y = stage.stageHeight / 2 - button.height * 8;
			button.addEventListener(MouseEvent.CLICK, btnDemoLevelClickEventHandler);
			addChild(button);
			
			/* btnBack */
			// text format //
			textFormat = new TextFormat();
			textFormat.font = "Times New Roman";
			textFormat.size = 24;
			textFormat.color = 0x775599;
			textFormat.bold = true;
			textFormat.align = TextFormatAlign.CENTER;
			// text //
			buttonText = new TextField();
			buttonText.text = "BACK";
			buttonText.setTextFormat(textFormat);
			buttonText.width = 72;
			buttonText.height = 25;
			// button //
			button = new SimpleButton(buttonText, buttonText, buttonText, buttonText);
			button.name = "btnBack";
			button.x = stage.stageWidth / 2 - button.width / 2;
			button.y = stage.stageHeight / 2 + button.height * 2;
			button.addEventListener(MouseEvent.CLICK, btnBackClickEventHandler);
			addChild(button);
		}
		
		private function btnDemoLevelClickEventHandler(event:MouseEvent):void
		{
			SelectLevelController.startLevel(DemoLevel);
		}
		
		private function btnBackClickEventHandler(event:MouseEvent):void
		{
			SelectLevelController.back();
		}
		
	}

}
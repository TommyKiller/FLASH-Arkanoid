package views 
{
	import controllers.GameController;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import framework.ui.View;
	import mx.utils.StringUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class GameView extends View 
	{
		
		public static const LABEL_HEALTH:String = "lblHealth";
		public static const LABEL_SCORE:String = "lblScore";
		public static const LABEL_BRICKS_DESTROYED:String = "lblBricksDestroyed";
		public static const SCENE:String = "scene";
		
		public function GameView() 
		{
			super(GameController);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			var format:TextFormat;
			var text:TextField;
			var group:Sprite;
			var scene:Stage;
			
			/* grpUpperLayout */
			group = new Sprite();
			group.name = "grpUpperLayout";
			group.height = stage.stageHeight * 0.05;
			group.width = stage.stageWidth;
			addChild(group);
			
			/* sceneGame */
			scene = new Stage();
			scene.name = SCENE;
			scene.y = group.height;
			addChild(scene);
			
			/* lblHealth */
			format = new TextFormat();
			format.font = "Times New Roman";
			format.size = 24;
			format.color = 0xFF0000;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			text = new TextField();
			text.name = LABEL_HEALTH;
			text.setTextFormat(format);
			group.addChild(text);
			
			/* lblScore */
			format = new TextFormat();
			format.font = "Times New Roman";
			format.size = 24;
			format.color = 0xFF0000;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			text = new TextField();
			text.name = LABEL_SCORE;
			text.setTextFormat(format);
			text.x = parent.width / 2 - text.width / 2;
			group.addChild(text);
			
			/* lblBricksDestroyed */
			format = new TextFormat();
			format.font = "Times New Roman";
			format.size = 24;
			format.color = 0xFF0000;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			text = new TextField();
			text.name = LABEL_BRICKS_DESTROYED;
			text.setTextFormat(format);
			text.x = parent.width - text.width;
			group.addChild(text);
		}
		
		public function updateLbl(name:String, text:String):void
		{
			var lbl:TextField = (getChildByName(name) as TextField);
			if (lbl)
			{
				lbl.text = text;
			}
		}
		
		public function get scene():Stage
		{
			return getChildByName(SCENE);
		}
		
	}

}
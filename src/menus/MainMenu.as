package menus 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class MainMenu extends Sprite 
	{
		
		private var button:SimpleButton;
		private var buttonsprite:Sprite;
		
		public function MainMenu(stage:DisplayObjectContainer) 
		{
			super();
			
			buttonsprite = new Sprite();
			buttonsprite.graphics.beginFill(0x12FF9D);
			buttonsprite.graphics.drawCircle(50, 50, 20);
			stage.addChild(buttonsprite);
			button = new SimpleButton(buttonsprite, buttonsprite, buttonsprite, buttonsprite);
			stage.addChild(button);
		}
		
	}

}
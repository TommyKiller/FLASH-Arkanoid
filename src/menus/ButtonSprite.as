package menus 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import interfaces.IRenderable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ButtonSprite extends Sprite implements IRenderable
	{
		
		private var _color:Object;
		
		public function ButtonSprite(text:ButtonSpriteText, color:Object = null) 
		{
			_color = color;
			addChild(text);
		}
		
		public function render():void
		{
			if (_color)
			{
				graphics.beginFill(_color as Number);
			}
			
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
	}

}
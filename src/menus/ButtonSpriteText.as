package menus 
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class ButtonSpriteText extends TextField 
	{
		
		public function ButtonSpriteText(text:String, size:uint = 12, font:String = "Arial", color:Object = null, align:String = TextFormatAlign.CENTER, italic:Boolean = false, bold:Boolean = false, underline:Boolean = false) 
		{
			this.text = text;
			autoSize = TextFieldAutoSize.LEFT;
			var format:TextFormat = new TextFormat();
			format.size = size;
			format.font = font
			format.color = color;
			format.align = align;
			format.italic = italic;
			format.bold = bold;
			format.underline = underline;
			setTextFormat(format);
		}
		
	}

}
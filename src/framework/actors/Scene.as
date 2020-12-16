package framework.actors 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Tommy
	 */
	public class Scene extends ActorContainer 
	{
		
		private var _stage:DisplayObjectContainer;
		
		public function Scene(stage:DisplayObjectContainer) 
		{
			super();
			
			setScene(this);
			_stage = stage;
		}
		
		/* Get/set methods */
		
		public function get stage():DisplayObjectContainer
		{
			return _stage;
		}
		
		override protected function setScene(value:Scene):void
		{
			if (equals(value)) super.setScene(this);
			else throw new ArgumentError("Scene property can not be set for the scene object - it always stays itself.");
		}
		
		override protected function setParent(value:ActorContainer):void
		{
			throw new Error("Scene object can not be child of actor container.");
		}
		
	}

}
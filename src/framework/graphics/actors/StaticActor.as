package framework.graphics.actors 
{
	import flash.display.Sprite;
	import framework.graphics.actors.events.ActorEvent;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Tommy
	 */
	public class StaticActor extends Actor 
	{
		
		protected var _model:Sprite;
		
		public function StaticActor(model:Sprite, name:String = null) 
		{
			super(name);
			_model = model;
			
			if (scene) init();
			else addEventListener(ActorEvent.ADDED_TO_SCENE, init);
		}
		
		private function init(event:ActorEvent = null):void
		{
			removeEventListener(ActorEvent.ADDED_TO_SCENE, init);
			
			scene.stage.addChild(model);
		}
		
		// Get/set methods //
		public function get model():Sprite
		{
			return _model;
		}
		
		public function set model(value:Sprite):void
		{
			_model = value;
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		override public function dispose():void 
		{
			if (!disposed)
			{
				super.dispose();
				
				scene.stage.removeChild(_model);
			}
		}
		
	}

}
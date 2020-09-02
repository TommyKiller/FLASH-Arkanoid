package framework.graphics.actors 
{
	import framework.graphics.actors.events.ActorEvent;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Tommy
	 */
	public class StaticActor extends Actor 
	{
		
		protected var _model:DisplayObject;
		
		public function StaticActor(model:DisplayObject, name:String = null) 
		{
			super(name);
			_model = model;
			
			if (scene) init();
			else addEventListener(ActorEvent.ADDED_TO_SCENE, init);
		}
		
		private function init(event:ActorEvent):void
		{
			removeEventListener(ActorEvent.ADDED_TO_SCENE, init);
			
			scene.stage.addChild(_model);
		}
		
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
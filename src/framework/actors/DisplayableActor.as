package framework.actors
{
	import flash.geom.Point;
	import framework.actors.events.ActorEvent;
	import framework.actors.events.DisplayableActorEvent;
	import framework.graphics.Model;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class DisplayableActor extends ActorContainer
	{
		
		private var _model:Model;
		private var _attached:Boolean;
		
		public function DisplayableActor(model:Model, id:uint)
		{
			super(id);
			
			_model = model;
			_attached = false;
		}
		
		/* Get/set methods */
		override protected function setScene(value:Scene):void
		{
			super.setScene(value);
			
			if (_model.stage) _model.stage.removeChild(_model);
			if (scene) scene.stage.addChild(_model);
		}
		
		protected function get model():Model
		{
			return _model;
		}
		
		public function get position():Point
		{
			return _model.position;
		}
		
		public function set position(value:Point):void
		{
			_model.position = value;
			
			dispatchEvent(new DisplayableActorEvent(DisplayableActorEvent.ACTOR_PLACED, this));
		}
		
		public function get attached():Boolean
		{
			return _attached;
		}
		
		// Event handlers //
		private function onParentPlacedEventHandler(event:DisplayableActorEvent):void
		{
			position = event.actor.position;
		}
		
		/* INTERFACE framework.interfaces.IDisposable */
		
		override public function dispose():void
		{
			if (!disposed)
			{
				if (attached) detach();
				
				super.dispose();
			}
		}
		
		/* Class interface */
		public function attachTo(actor:DisplayableActor):void
		{
			actor.addChild(this);
			
			actor.addEventListener(DisplayableActorEvent.ACTOR_PLACED, onParentPlacedEventHandler);
		}
		
		public function detach():void
		{
			parent.removeEventListener(DisplayableActorEvent.ACTOR_PLACED, onParentPlacedEventHandler);
			parent.removeChild(this);
			_attached = false;
		}
	}

}
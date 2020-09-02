package framework.graphics 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Scene extends EventDispatcher 
	{
		
		private var _actors:Vector.<Actor>;
		private var _stage:Stage;
		
		public function Scene(stage:Stage) 
		{
			_actors = new Vector.<Actor>();
			_stage = stage;
		}
		
		// Get/set methods //
		public function get stage():Stage
		{
			return _stage;
		}
		//
		
		public function addActor(actor:Actor):void
		{
			_actors.push(actor);
			actor.scene = this;
		}
		
		public function removeActor(actor:Actor):void
		{
			for (var i:int = 0; i < _actors.length; i++)
			{
				if (_actors[i] == actor)
				{
					_actors.removeAt(i);
					
					break;
				}
			}
		}
		
	}

}
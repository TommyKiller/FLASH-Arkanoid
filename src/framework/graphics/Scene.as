package framework.graphics
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import framework.graphics.actors.Actor;
	import framework.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Scene extends EventDispatcher implements IDisposable
	{
		
		private var _disposed:Boolean;
		private var _actors:Vector.<Actor>;
		private var _stage:Stage;
		
		public function Scene(stage:Stage)
		{
			_disposed = false;
			_actors = new Vector.<Actor>();
			_stage = stage;
		}
		
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
		
		// Get/set methods //
		public function get stage():Stage
		{
			return _stage;
		}
		
		/* INTERFACE framework.interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				for (var i:int = 0; i < _actors.length;)
				{
					_actors[i].dispose();
				}
				_actors = null;
			}
			
			_disposed = true;
		}
	
	}

}
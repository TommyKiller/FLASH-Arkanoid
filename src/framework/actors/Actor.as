package framework.actors
{
	import flash.events.EventDispatcher;
	import framework.actors.events.ActorEvent;
	import framework.interfaces.IDisposable;
	import framework.interfaces.IEquatable;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Actor extends EventDispatcher implements IDisposable, IEquatable
	{
		
		private var _disposed:Boolean;
		private var _parent:ActorContainer;
		private var _scene:Scene;
		private var _id:uint;
		
		public function Actor(id)
		{
			_id = id;
		}
		
		/* Get/set methods */
		
		public function get disposed():void
		{
			return _disposed;
		}
		
		public function get id():uint
		{
			return _id;
		}
		
		public function get parent():ActorContainer
		{
			return _parent;
		}
		
		protected function setParent(value:ActorContainer):void
		{
			if (!value)
			{
				if (_parent)
				{
					dispatchEvent(new ActorEvent(ActorEvent.REMOVED, this));
					_parent = null;
					scene = null;
				}
			}
			else
			{
				if (!_parent)
				{
					_parent = value;
					dispatchEvent(new ActorEvent(ActorEvent.ADDED, this));
					scene = _parent.scene;
				}
				else if (!_parent.equals(value))
				{
					dispatchEvent(new ActorEvent(ActorEvent.REMOVED, this));
					_parent = value;
					dispatchEvent(new ActorEvent(ActorEvent.ADDED, this));
					scene = _parent.scene;
				}
			}
		}
		
		public function get scene():Scene
		{
			return _scene;
		}
		
		protected function setScene(value:Scene):void
		{
			if (!value)
			{
				if (_scene)
				{
					dispatchEvent(new ActorEvent(ActorEvent.REMOVED_FROM_SCENE, this));
					_scene = null;
				}
			}
			else
			{
				if (!_scene)
				{
					_scene = value;
					dispatchEvent(new ActorEvent(ActorEvent.ADDED_TO_SCENE, this));
				}
				else if (!_scene.equals(value))
				{
					dispatchEvent(new ActorEvent(ActorEvent.REMOVED_FROM_SCENE, this));
					_scene = value;
					dispatchEvent(new ActorEvent(ActorEvent.ADDED_TO_SCENE, this));
				}
			}
		}
		
		/* INTERFACE framework.interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				dispatchEvent(new ActorEvent(ActorEvent.DISPOSED, this));
				
				if (parent) parent.removeChild(this);
				
				_disposed = true;
			}
		}
		
		/* INTERFACE framework.interfaces.IEquatable */
		
		public function getHashCode():uint
		{
			return _id;
		}
		
		public function equals(object:Object):Boolean
		{
			if (!object && !(object is Actor)) return false;
			
			return getHashCode() === object.getHashCode();
		}
	
	}

}
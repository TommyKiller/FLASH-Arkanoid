package framework.graphics.actors
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import framework.graphics.actors.events.ActorEvent;
	import flash.events.EventDispatcher;
	import framework.graphics.Scene;
	import framework.interfaces.IDisposable;
	import mx.utils.NameUtil;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class Actor extends EventDispatcher implements IDisposable
	{
		
		private var _disposed:Boolean;
		protected var _scene:Scene;
		protected var _name:String;
		
		public function Actor(name:String = null)
		{
			var derivedClass:Class = Class(getDefinitionByName(getQualifiedClassName(this)));
			if (!(derivedClass as StaticActor) || !(derivedClass as PawnActor))
			{
				throw new Error("You can not inherit from actor class. Use static or pawn actor classes instead.");
			}
			
			_disposed = false;
			_name = name ? name : NameUtil.createUniqueName(this);
		}
		
		// Get/set methods //
		protected function get disposed():Boolean
		{
			return _disposed;
		}
		
		public function get scene():Scene
		{
			return _scene;
		}
		
		public function set scene(value:Scene):void
		{
			_scene = value;
			
			dispatchEvent(new ActorEvent(ActorEvent.ADDED_TO_SCENE, this));
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		/* INTERFACE interfaces.IDisposable */
		
		public function dispose():void
		{
			if (!_disposed)
			{
				scene.removeActor(this);
				
				dispatchEvent(new ActorEvent(ActorEvent.ACTOR_DISPOSED, this));
			}
			
			_disposed = true;
		}
	
	}

}
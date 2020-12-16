package framework.actors 
{
	/**
	 * ...
	 * @author Tommy
	 */
	public class Trigger extends Actor 
	{
		
		private var _active:Boolean;
		
		public function Trigger(id:uint) 
		{
			super(id);
		}
		
		/* Get/set methods */
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
	}

}
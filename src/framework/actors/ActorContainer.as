package framework.actors 
{
	/**
	 * ...
	 * @author Tommy
	 */
	public class ActorContainer extends Actor 
	{
		
		private var _children:Vector.<Actor>;
		
		public function ActorContainer(id:uint) 
		{
			super(id);
			
			_children = new Vector.<Actor>();
		}
		
		/* Get/set methods */
		
		public function get childrenNum():int
		{
			return _children.length;
		}
		
		override protected function setScene(value:Scene):void
		{
			super.setScene(value);
			
			for (var i:uint = 0; i < _children.length; i++)
			{
				_children[i].setScene(scene);
			}
		}
		
		/* Class interface */
		
		public function addChild(child:Actor):void
		{
			if (!child) throw new TypeError("Parameter child must be not-null.");
			if (child.equals(this)) throw new ArgumentError("An object cannot be added as a child of itself.");
			
			_children.push(child);
			child.setParent(this);
		}
		
		public function removeChild(child:Actor):void
		{
			if (!child) throw new TypeError("Parameter child must be not-null.");
			
			for (var i:uint = 0; i < _children.length; i++)
			{
				if (_children[i].equals(child))
				{
					_children[i].setParent(null);
					_children.removeAt(i);
					break;
				}
			}
		}
		
		/* INTERFACE framework.interfaces.IDisposable */
		
		override public function dispose():void
		{
			if (!disposed)
			{
				super.dispose();
				
				while (_children.length > 0)
				{
					_children[0].dispose();
				}
		}
		
	}

}
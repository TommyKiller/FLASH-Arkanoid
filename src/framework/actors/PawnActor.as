package framework.actors
{
	import framework.geom.Vector2D;
	import framework.graphics.Model;
	
	/**
	 * ...
	 * @author Tommy
	 */
	public class PawnActor extends DisplayableActor
	{
		
		private var _velocity:Vector2D;
		
		public function PawnActor(model:Model, id:uint)
		{
			super(model, id);
		
		}
		
		/* Class interface */
		
		public function move():void
		{
			
		}
		
		public function attachTo(actor:PawnActor):void
		{
			super.attachTo(actor);
		
		}
	
	}

}
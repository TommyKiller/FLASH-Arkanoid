package framework.interfaces 
{
	
	/**
	 * ...
	 * @author Tommy
	 */
	public interface IEquatable 
	{
		function getHashCode():uint;
		
		function equals(object:Object):Boolean;
	}
	
}
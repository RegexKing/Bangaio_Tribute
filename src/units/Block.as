package units 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Block extends Target
	{
		
		public function Block() 
		{
			super();
			
			makeGraphic(50, 50);	
			
			immovable = true;
		}
		
	}

}
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
		
		public function Block(_textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			health = 10;
			points = 100;
			
			makeGraphic(32, 32);
			
			immovable = true;
		}
		
	}

}
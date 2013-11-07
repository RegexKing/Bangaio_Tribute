package units 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Target
	{
		
		public function BrownBlock(_textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			health = 10;
			points = 100;
			
			makeGraphic(32, 32);
		}
		
		override public function update():void
		{
			super.update();
			
			acceleration.y = 400;
			velocity.x = 0;
		}
		
	}

}
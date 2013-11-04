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
			
			maxVelocity.y = 200;
		}
		
		override public function update():void
		{
			super.update();
			
			acceleration.y = 100;
			
		}
		
	}

}
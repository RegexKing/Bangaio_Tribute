package units 
{
	import hud.CountdownTimer;
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class YellowRobot extends BlueRobot
	{
		public function YellowRobot() 
		{
				super();
				
				jumpSpeed = 20000;
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 80;
			points = 500;
		}
	}

}
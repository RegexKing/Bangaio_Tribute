package units 
{
	import maps.LevelMap;
	import org.flixel.*;
	import util.BulletTrailsContainer;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Sentry extends Enemy
	{
		
		public function Sentry(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _bulletType:String = "normal") 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _bulletType);
			
			health = 100;
			
			makeGraphic(32, 32);
			
			this.immovable = true;
			
			gun.setBulletSpeed(250);
			gun.setFireRate(1000);
		}
		
		override public function update():void
		{
			super.update();
			
			if (inSight && onScreen())
			{
				gun.fireFromAngle(aim);
			}
		}
	}

}
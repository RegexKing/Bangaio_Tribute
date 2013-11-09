package units 
{
	import maps.LevelMap;
	import org.flixel.*;
	import util.BulletTrailsContainer;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Turret extends Shooter
	{
		
		public function Turret(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal") 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _textGroup, _bulletType);
			
			health = 40;
			points = 100;
			
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
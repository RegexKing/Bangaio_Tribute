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
		
		public function Turret(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal", _orientation:uint = FLOOR) 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _textGroup, _bulletType);
			this.immovable = true;
			
			health = 40;
			points = 100;
			
			makeGraphic(32, 32);
			
			gun.setBulletSpeed(250);
			gun.setFireRate(1000);
			
			if (_orientation == FLOOR)
			{
				angle = 0;
			}
			else if (_orientation == CEILING)
			{
				angle = 180;
			}
			
			else if (_orientation == LEFT)
			{
				angle = -90;
			}
			
			else if (_orientation == RIGHT)
			{
				angle = 90;
			}
			
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
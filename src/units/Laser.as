package units 
{
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import util.BulletTrailsContainer;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Laser extends Shooter
	{
		
		private var apples:FlxGroup;
		
		public function Laser(_enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _apples:FlxGroup, _orientation:uint = FLOOR) 
		{
			super(_enemyBullets, _player,  _blueExplosions, _map, _bulletTrails, _textGroup, "laser");
			apples = _apples;
			
			this.immovable = true;
			
			health = 10;
			points = 100;
			
			makeGraphic(16, 16);
			
			gun.setBulletSpeed(200);
			gun.setFireRate(500);
			
			if (_orientation == FLOOR)
			{
				angle = 0;
				aim = 0;
			}
			else if (_orientation == CEILING)
			{
				angle = 180;
				aim = 180;
			}
			
			else if (_orientation == LEFT)
			{
				angle = -90;
				aim = -90;
			}
			
			else if (_orientation == RIGHT)
			{
				angle = 90;
				aim = 90;
			}
			
			else if (_orientation == FLOOR_LEFT)
			{
				angle = -45;
				aim = -45;
			}
			
			else if (_orientation == FLOOR_RIGHT)
			{
				angle = 45;
				aim = 45;
			}
			
			else if (_orientation == CEIL_LEFT)
			{
				angle = -135;
				aim = -135;
			}
			
			else if (_orientation == CEIL_RIGHT)
			{
				angle = 135;
				aim = 135;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			gun.fireFromAngle(aim);
		}
		
		override public function kill():void
		{
			(apples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "apple");
			
			super.kill();
		}
		
	}

}
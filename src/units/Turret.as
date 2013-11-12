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
	public class Turret extends Shooter
	{
		
		private var apples:FlxGroup;
		
		public function Turret(_enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _apples:FlxGroup, _bulletType:String = "normal", _orientation:uint = FLOOR) 
		{
			super(_enemyBullets, _player,  _blueExplosions, _map, _bulletTrails, _textGroup, _bulletType);
			
			apples = _apples;
			
			this.immovable = true;
			
			health = 40;
			points = 100;
			
			loadGraphic(AssetsRegistry.turretPNG);
			
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
		
		override public function kill():void
		{
			(apples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "apple");
			
			super.kill();
		}
	}

}
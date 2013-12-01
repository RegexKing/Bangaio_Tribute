package units 
{
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Turret extends Shooter
	{
		
		private var apples:FlxGroup;
		
		public function Turret() 
		{
			super(null, null, null, null, null, null, null);
			
			
			this.immovable = true;
			
			health = 40;
			points = 100;
			
			loadGraphic(AssetsRegistry.turretPNG);
			
		}
		
		public function setPos(X:int, Y:int, _enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _apples:FlxGroup, _enemies:FlxGroup, _targets:Array, _bulletType:String = "normal", _orientation:uint = FLOOR):void
		{
			revive();
			
			this.x = X;
			this.y = Y;
			
			if (!textGroup)
			{
				player = _player;
				blueExplosions = _blueExplosions;
				map = _map;
				textGroup = _textGroup;
				apples = _apples;
				
				_enemies.add(this);
				_targets.push(this);
				
				setupGun(_enemyBullets, _bulletTrails, _bulletType);
				gun.setBulletSpeed(250);
				gun.setFireRate(1000);
			}
			
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
		
		override public function revive():void
		{
			super.revive();
			
			health = 40;
			points = 100;
		}
		
		override public function update():void
		{
			super.update();
			
			inSight = map.ray(this.getMidpoint(), player.getMidpoint(), null, 1);
			
			if (inSight)
			{
				alert = true;
				
				// find the angle between enemy and player
				directionAngle = FlxVelocity.angleBetween(this, player, true);

				// find where the enemy should aim
				aim = GameUtil.findDirection(directionAngle);
			}
			
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
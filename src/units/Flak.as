package units 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import hud.CountdownTimer;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import items.Fruit
	import weapons.*; 
	 
	public class Flak extends Shooter
	{
		private var timer:Number = 0;
		
		private var pineapples:FlxGroup;
		
		//timer vars
		private var spawnRate:Number = 3000;
		private var nextSpawn:Number = 0;
		
		public function Flak(_enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String, _pineapples:FlxGroup) 
		{
			super(_enemyBullets, _player, _blueExplosions, _map, _bulletTrails, _textGroup, _bulletType);
			
			pineapples = _pineapples;
			
			this.immovable = true;
			
			health = 160;
			points = 500;
			
			loadGraphic(AssetsRegistry.flakPNG);
			
			setupGun(_enemyBullets, _bulletTrails, "normal");
			gun.setBulletSpeed(250);
			gun.setFireRate(0);
			gun.setBulletOffset(0, 0);
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
			
			if (this.onScreen() && inSight && (CountdownTimer.getTimer() > nextSpawn))
			{
				nextSpawn = CountdownTimer.getTimer() + spawnRate;
				
				gun.missleOverdrive(20);
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 160;
			points = 500;
			
			nextSpawn = 0;
		}
		
		override public function kill():void
		{
			(pineapples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "pineapple");

			super.kill();
			
			timer = 0;
		}
		
	}

}
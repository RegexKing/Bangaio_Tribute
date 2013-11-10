package units 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*; 
	 
	public class Flak extends Shooter
	{
		private var timer:Number = 0;
		
		public function Flak(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal") 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _textGroup, _bulletType);
			
			this.immovable = true;
			
			health = 160;
			points = 500;
			
			makeGraphic(32, 32, 0xffFF00B6);
			
			gun.setBulletSpeed(250);
			gun.setFireRate(0);
			gun.setBulletOffset(0, 0);
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FlxG.elapsed;
			if (timer >= 3)
			{
				if (inSight && onScreen())
				{
					gun.missleOverdrive(20);
					timer = 0;
				}
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			timer = 0;
		}
		
	}

}
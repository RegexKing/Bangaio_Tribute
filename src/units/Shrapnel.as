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
	 
	public class Shrapnel extends Enemy
	{
		private var timer:Number = 0;
		
		public function Shrapnel(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal") 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _textGroup, _bulletType);
			
			health = 160;
			points = 500;
			
			makeGraphic(32, 32);
			
			this.immovable = true;
			
			gun.setBulletSpeed(250);
			gun.setFireRate(0);
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FlxG.elapsed;
			if (timer >= 3)
			{
				if (inSight && onScreen())
				{
					gun.missleOverdrive(40);
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
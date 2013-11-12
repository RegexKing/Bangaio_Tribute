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
	import items.Fruit
	import weapons.*; 
	 
	public class Flak extends Shooter
	{
		private var timer:Number = 0;
		
		private var pineapples:FlxGroup;
		
		public function Flak(_enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String, _pineapples:FlxGroup) 
		{
			super(_enemyBullets, _player, _blueExplosions, _map, _bulletTrails, _textGroup, _bulletType);
			
			pineapples = _pineapples;
			
			this.immovable = true;
			
			health = 160;
			points = 500;
			
			loadGraphic(AssetsRegistry.flakPNG);
			
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
			(pineapples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "pineapple");

			super.kill();
			
			timer = 0;
		}
		
	}

}
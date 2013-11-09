package units 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*; 
	 
	public class Shooter extends Destructible
	{
		
		public var aim:int = 0;
		protected var speed:int = 0;
		
		protected var player:Player;
		protected var map:LevelMap;
		
		protected var directionAngle:Number = 0;
		protected var inSight:Boolean = false;
		
		protected var gun:FlxWeaponExt;
		
		public function Shooter(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal") 
		{
			super(_textGroup);
			
			player = _player;
			map = _map;
			
			
			// Guns
			if (_bulletType == "normal") gun = new FlxWeaponExt(E_NormalBullet, "gun", _bulletTrails, this, player);
			else if (_bulletType == "homing") gun = new FlxWeaponExt(E_HomingBullet, "gun", _bulletTrails, this, player);
			else throw new Error("invalid bullet type");
			
			gun.setBulletBounds(FlxG.worldBounds);
			
			_enemyBullets.add(gun.group);
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("F")) this.active = !this.active;
			
			trace(this.active);
			
			// find the angle between enemy and player
			directionAngle = FlxVelocity.angleBetween(this, player, true);
			// find which way enemy should face
			this.facing = GameUtil.findFacing(directionAngle);
			// find where the enemy should aim
			aim = GameUtil.findDirection(directionAngle);
			
			inSight = map.ray(this.getMidpoint(), player.getMidpoint(), null, 1);
		}
		
		override public function destroy():void
		{
			gun = null;
			
			super.destroy();
		
		}
		
	}

}
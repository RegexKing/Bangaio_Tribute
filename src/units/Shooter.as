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
	 
	public class Shooter extends Targetable
	{
		
		public var aim:int = 0;
		protected var speed:int = 0;
		
		protected var map:LevelMap;
		
		protected var directionAngle:Number = 0;
		protected var inSight:Boolean = false;
		protected var alert:Boolean = false;
		
		protected var gun:FlxWeaponExt;
		
		public function Shooter(_enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String = "normal") 
		{
			super(_player, _textGroup, _blueExplosions);
			flashAble = true;
			
			map = _map;
			
			
			// Guns
			if (_bulletType == "normal") gun = new FlxWeaponExt(E_NormalBullet, "gun", _bulletTrails, this, player);
			else if (_bulletType == "homing") gun = new FlxWeaponExt(E_HomingBullet, "gun", _bulletTrails, this, player);
			else if (_bulletType == "laser") gun = new FlxWeaponExt(E_Laser, "gun", _bulletTrails, this, player);
			else throw new Error("invalid bullet type");
			
			gun.setBulletBounds(FlxG.worldBounds);
			
			_enemyBullets.add(gun.group);
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
		override public function hurt(_damageNumber:Number):void
		{
			super.hurt(_damageNumber);
			
			FlxG.play(AssetsRegistry.objectHurt_MP3);
		}
		
		override public function kill():void
		{
			super.kill();
			gun.group.kill();
		}
		
		override public function revive():void
		{
			super.revive();
			gun.group.revive();
			alert = false;
		}
		
		override public function destroy():void
		{
			gun = null;
			
			super.destroy();
		
		}
		
	}

}
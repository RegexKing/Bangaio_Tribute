package weapons 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import units.Player;
	import util.BulletTrailsContainer;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class HomingBullet extends BulletExt implements PlayerBullet
	{
		
		private var target:FlxSprite;

		public const SPEED:uint = 9000;
		public const TURN_SPEED:Number = 0.1;
		
		public function HomingBullet()
		{
			super();

			// Makes rendering rotations perform better, 200 rotations for 200 directions
			loadRotatedGraphic(AssetsRegistry.misslePNG, 100);
			
			offset.x = 11;
			width = 16;
			offset.y = 11;
			height = 16;
		}
		
		override public function getBullet(_weapon:FlxWeaponExt, _aimAngle:int, _bulletTrails:BulletTrailsContainer, _player:Player = null):BulletExt
		{
			target = _player.findClosestTarget();
			
			return super.getBullet(_weapon, _aimAngle, _bulletTrails, _player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching)
			{
				kill();
			}
			
			if (target != null && target.exists)
			{

				angle = GameUtil.easeTowardsTarget(this, target, SPEED, TURN_SPEED);
			}
			
			else
			{
				target = player.findClosestTarget();
			}
		}
		
		override public function dealDamage():Number
		{
			return 12.5;
		}
	}

}
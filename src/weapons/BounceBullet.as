package weapons 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import units.Player;
	import util.BulletTrailsContainer;
	
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BounceBullet extends BulletExt implements PlayerBullet
	{
		private var isOverDrive:Boolean = false;
		private var target:FlxSprite;
		
		public function BounceBullet()
		{
			super();
			
			width = 10;
			height = 10;
			
			visible = false;
			
			trailColor = 0xff66FFCC;
			
		}
		
		override public function getBullet(_weapon:FlxWeaponExt, _aimAngle:int, _bulletTrails:BulletTrailsContainer, _player:Player = null):BulletExt
		{
			if (FlxG.keys.justReleased("SPACE"))
			{
				isOverDrive = true;
				target = _player.findClosestTarget();
			}
			
			return super.getBullet(_weapon, _aimAngle, _bulletTrails, _player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (justTouched(ANY))
			{
				if (isOverDrive)
				{
				   if (target != null && target.exists)
				   {
						var angleBetween:Number = FlxVelocity.angleBetween(this, target, true);
						this.velocity = FlxVelocity.velocityFromAngle(angleBetween, 500);
				   }
							
				   else
				   {
						target = player.findClosestTarget();
				   }
				}
			}
			
			
		}
		
		override public function kill():void
		{
			super.kill();
			
			target = null;
			isOverDrive = false;
		}
		
	}

}
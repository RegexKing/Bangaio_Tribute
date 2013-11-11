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
	public class BounceBullet extends BulletExt
	{
		private var target:FlxSprite;
		
		// helper variable for slope collisions
		public var parity:int = -1;
		
		public function BounceBullet()
		{
			super();

			// Makes rendering rotations perform better, 200 rotations for 200 directions
			loadRotatedGraphic(AssetsRegistry.bouncePNG, 1);
			
			offset.x =11;
			width = 10;
			offset.y = 10;
			height = 11;
			
			visible = false;
			
			trailColor = 0xff66FFCC;
			
		}
		
		override public function getBullet(_weapon:FlxWeaponExt, _aimAngle:int, _bulletTrails:BulletTrailsContainer, _player:Player = null):BulletExt
		{
			target = _player.findClosestTarget();
			
			return super.getBullet(_weapon, _aimAngle, _bulletTrails, _player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (justTouched(ANY))
			{
				if (target != null && target.exists && player.bulletLOS(this, target))
				{
					var angleBetween:Number = FlxVelocity.angleBetween(this, target, true);
					this.velocity = FlxVelocity.velocityFromAngle(angleBetween, 500);
				}
			
				else
				{
					target = player.findClosestTarget();
				}
				
				
				this.angle = GameUtil.findAngleByVelocity(this.velocity.x, this.velocity.y);
				
				if (parity != -1)
				{
					if (parity == 1) parity = 0;
					else parity = 1;
				}
			}
			
			
		}
		
		override public function kill():void
		{
			super.kill();
			
			parity = -1;
		}
		
	}

}
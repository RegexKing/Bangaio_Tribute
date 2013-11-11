package weapons 
{
	import hud.CountdownTimer;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.*;
	import flash.utils.getTimer;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import units.Player;
	import util.BulletTrailsContainer;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class FlxWeaponExt extends FlxWeapon
	{
		private var bulletClass:Class;
		private var bulletTrails:BulletTrailsContainer;
		private var player:Player;
		
		/**
		 * Creates the FlxWeapon class which will fire your bullets.<br>
		 * You should call one of the makeBullet functions to visually create the bullets.<br>
		 * Then either use setDirection with fire() or one of the fireAt functions to launch them.
		 * 
		 * @param	name		The name of your weapon (i.e. "lazer" or "shotgun"). For your internal reference really, but could be displayed in-game.
		 * @param	parentRef	If this weapon belongs to a parent sprite, specify it here (bullets will fire from the sprites x/y vars as defined below).
		 * @param	xVariable	The x axis variable of the parent to use when firing. Typically "x", but could be "screenX" or any public getter that exposes the x coordinate.
		 * @param	yVariable	The y axis variable of the parent to use when firing. Typically "y", but could be "screenY" or any public getter that exposes the y coordinate.
		 */
		public function FlxWeaponExt(_bulletClass:Class, name:String, _bulletTrails:BulletTrailsContainer, parentRef:* = null, _player:Player = null,  xVariable:String = "x", yVariable:String = "y", aimVariable:String = "aim") 
		{
			super(name, parentRef, xVariable, yVariable, aimVariable);
			
			bulletClass = _bulletClass;
			bulletTrails = _bulletTrails;
			player = _player;
			
			group = new FlxGroup();
		}
		
		/**
		 * Internal function that handles the actual firing of the bullets
		 * 
		 * @param	method
		 * @param	x
		 * @param	y
		 * @param	target
		 * @return	true if a bullet was fired or false if one wasn't available. The bullet last fired is stored in FlxWeapon.prevBullet
		 */
		override protected function runFire(method:uint, x:int = 0, y:int = 0, target:FlxSprite = null, angle:int = 0,smissleOverdrive:Boolean = true, bulletShells:FlxEmitter = null):Boolean
		{
			if (fireRate > 0 && (CountdownTimer.getTimer() < nextFire))
			{
				return false;
			}
			
			//recycles bullet
			currentBullet = (group.recycle(bulletClass) as BulletExt).getBullet(this, parent[parentAimVariable], bulletTrails, player);

			if (onPreFireCallback is Function)
			{
				onPreFireCallback.apply();
			}
			
			if (onPreFireSound)
			{
				FlxG.play(onPreFireSound);
			}
			
			//	Clear any velocity that may have been previously set from the pool
			currentBullet.velocity.x = 0;
			currentBullet.velocity.y = 0;
			currentBullet.acceleration.x = 0;
			currentBullet.acceleration.y = 0;
			
			lastFired = CountdownTimer.getTimer();
			nextFire = CountdownTimer.getTimer() + fireRate;
			
			var launchX:int = positionOffset.x;
			var launchY:int = positionOffset.y;
			
			if (fireFromParent)
			{
				launchX += parent[parentXVariable];
				launchY += parent[parentYVariable];
			}
			else if (fireFromPosition)
			{
				launchX += fireX;
				launchY += fireY;
			}
			
			if (directionFromParent)
			{
				velocity = FlxVelocity.velocityFromFacing(parent, bulletSpeed);
			}
			
			//	Faster (less CPU) to use this small if-else ladder than a switch statement
			if (method == FIRE)
			{
				currentBullet.fire(launchX, launchY, velocity.x, velocity.y);
			}
			else if (method == FIRE_AT_MOUSE)
			{
				currentBullet.fireAtMouse(launchX, launchY, bulletSpeed, 0);
			}
			else if (method == FIRE_AT_POSITION)
			{
				currentBullet.fireAtPosition(launchX, launchY, x, y, bulletSpeed);
			}
			else if (method == FIRE_AT_TARGET)
			{
				currentBullet.fireAtTarget(launchX, launchY, target, bulletSpeed, 0);
			}
			else if (method == FIRE_FROM_ANGLE)
			{
				currentBullet.fireFromAngle(launchX, launchY, angle, bulletSpeed);
				
				if (bulletShells != null)
				{
					bulletShells.emitParticle();
				}
			}
			else if (method == FIRE_FROM_PARENT_ANGLE)
			{
				currentBullet.fireFromAngle(launchX, launchY, parent.angle, bulletSpeed);
			}
			
			if (onPostFireCallback is Function)
			{
				onPostFireCallback.apply();
			}
			
			if (onPostFireSound && smissleOverdrive)
			{
				FlxG.play(onPostFireSound);
			}
			
			bulletsFired++;
			
			return true;
		}
		
		public function missleOverdrive(bulletSize:int, numDirections:uint = 4):void
		{
			
			for (var i:int = 0; i < numDirections; i++)
			{
				if (bulletSize <= 0) return
				
				var aim:int = (360 / Math.floor(numDirections)) * (i + 1);
				if (aim > 180) aim = -(aim % 180);
				
				this.fireFromAngle(aim, false);
			}
			
			missleOverdrive(bulletSize - numDirections, numDirections * 2);
			
		}
		
	}

}
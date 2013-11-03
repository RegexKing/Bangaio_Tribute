package weapons 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet; 
	import org.flixel.plugin.photonstorm.FlxMath;
	import flash.utils.getTimer;
	import units.Player;
	import util.BulletTrailsContainer;
	import util.FlxTrail;
	import util.Line;
	import util.Queue;
	 
	 
	public class BulletExt extends Bullet
	{
		
		protected var trailColor:uint = 0xffFFFFFF;
		
		private static var idCounter:int = 0;
		private var bulletTrails:BulletTrailsContainer;
		protected var player:Player;
		
		private var tempX:int = 0;
		private var tempY:int = 0;
		private var lines:Queue;
		
		
		public function BulletExt()
		{
			super(null, idCounter);
			
			idCounter++;
		}
		
		override public function dealDamage():Number
		{
			return 10;
		}
		
		public function getBullet(_weapon:FlxWeaponExt, _aimAngle:int, _bulletTrails:BulletTrailsContainer, _player:Player = null):BulletExt
		{
			
			//if bullet hasn't been instantiated yet, pass weapon and trail reference
			if (!weapon)
			{
				weapon = _weapon;
				bulletTrails = _bulletTrails;
				player = _player;
			}
			
			//recycle lines
			lines = bulletTrails.getLines();
			
			angle = _aimAngle;
			
			return this;
		}
		
		
		
		
		override public function preUpdate():void
		{
			super.preUpdate();
			
			tempX = this.getMidpoint().x;
			tempY = this.getMidpoint().y;
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			
			var line:Line = bulletTrails.drawLine(tempX, tempY, this.getMidpoint().x, this.getMidpoint().y, trailColor);
			lines.write(line);
			
		}
		
		override public function destroy():void
		{
			idCounter = 0;
			
			super.destroy();
			
			lines = null;
		}
		
	}

}
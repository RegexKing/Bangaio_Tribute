package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import flash.utils.ByteArray;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	 
	public class GameUtil 
	{
		
		public static const AIM_UP:int = -90;
		public static const AIM_DOWN:int = 90;
		public static const AIM_RIGHT:int = 0;
		public static const AIM_LEFT:int = 180;
		public static const AIM_RIGHT_UP:int = -45;
		public static const AIM_RIGHT_DOWN:int = 45;
		public static const AIM_LEFT_UP:int = -135;
		public static const AIM_LEFT_DOWN:int = 135;
		
		public static function findDirection(directionAngle:Number):int
		{
			//up-right
					if (directionAngle <= -22.5 && directionAngle > -67.5)
					{
						return AIM_RIGHT_UP;
						
					}
					//up-left
					else if (directionAngle <= -112.5 && directionAngle > -157.5)
					{
						return AIM_LEFT_UP;
						
					}
					//left-down
					else if (directionAngle <= 157.5 && directionAngle > 112.5)
					{
						return AIM_LEFT_DOWN;
						
					}
					//right-down
					else if (directionAngle <= 67.5 && directionAngle > 22.5)
					{
						return AIM_RIGHT_DOWN;
						
					}
					//down
					else if (directionAngle <= 112.5 && directionAngle > 67.5)
					{
						return AIM_DOWN;
					}
					//up
					else if (directionAngle <= -67.5 && directionAngle > -112.5)
					{
						return AIM_UP;
			
					}
					//right
					else if (directionAngle <= 22.5 && directionAngle > -22.5)
					{
						return AIM_RIGHT;
					}
					//left
					else
					{
						return AIM_LEFT;
					}
		}
		
		public static function findFacing(directionAngle:Number):uint
		{
			if ((directionAngle > -90 && directionAngle <= 0) || (directionAngle > 0 && directionAngle <= 90))
				return FlxObject.RIGHT;

			else
				return FlxObject.LEFT;
		}
		
		public static function cloneArray(source:Array):Array
		{ 
			var newArray:Array = new Array();
			
			for (var i:int = 0; i < source.length; i++)
			{
				newArray.push(source[i]);
			}
			
			return newArray;
		}
		
		public static function findDistance(Object1:FlxSprite, Object2:FlxSprite):Number
		{
			var dist:Number;
			var dx:Number;
			var dy:Number;

			dx = Object2.getMidpoint().x - Object1.getMidpoint().x;
			dy = Object2.getMidpoint().y - Object1.getMidpoint().y;
			dist = Math.sqrt(dx*dx + dy*dy);

			return dist;
		}
		
		static public function findAngleByVelocity(vX:Number, vY:Number):Number
		{
			return FlxMath.atan2(vY, vX) * 180 / Math.PI;
		}
		
		static public function shakeCam():void
		{
			
			FlxG.camera.shake(Math.random() / 500, .2);
		}
		
		
		public static const TIME_DELTA:Number = 0.05;
		public static const RAD:Number = 57.2957795;
		
		static public function easeTowardsTarget(object:FlxSprite, target:FlxSprite, speed:int, turnSpeed:Number = 0.1):Number
		{
			var a:Number = _turnToFace(object.getMidpoint(), target.getMidpoint(), object.angle * Math.PI / 180, turnSpeed);

			var dirX:Number = Math.cos(a);
			var dirY:Number = Math.sin(a);

			object.velocity.x = (dirX) * speed * TIME_DELTA;
			object.velocity.y = (dirY) * speed * TIME_DELTA;
			
			return a * RAD;
		}
		
		private static function _turnToFace(p:FlxPoint, f:FlxPoint, ca:Number, turnSpeed:Number):Number
		{           
			var xp:Number = f.x - p.x;
			var yp:Number = f.y - p.y;

			var desiredAngle:Number = Math.atan2(yp, xp);
			var difference:Number = _wrapAngle(desiredAngle - ca);

			difference = Math.max(-turnSpeed, Math.min(turnSpeed, difference));

			return _wrapAngle(ca + difference); 
		}
		
		private static function _wrapAngle(radians:Number):Number
		{
			var pi2:Number = Math.PI * 2;

			while(radians < -Math.PI) radians += pi2;
			while(radians > Math.PI) radians -= pi2;

			return radians;
		}
		
	}

}
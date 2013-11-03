package units 
{
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Blue extends Target
	{
		public var aim:int = 0;
		protected var speed:int = 0;
		
		private var player:Player;
		private var map:LevelMap;
		
		private var directionAngle:Number = 0;
		private var inSight:Boolean = false;
		private var aware:Boolean = false;
		private var myPath:FlxPath;
		
		private var gun:FlxWeaponExt;
		
		public function Blue(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer) 
		{
			super();
			
			player = _player;
			map = _map;
			
			health = 100;
			speed = 150;
			
			loadGraphic(AssetsRegistry.bluePNG, true, true, 35, 50);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
			this.offset.x = 10;
			width = 15;
			
			
			// Guns
			gun = new FlxWeaponExt(E_HomingBullet, "gun", _bulletTrails, this, player);
			gun.setBulletBounds(FlxG.worldBounds);
			gun.setBulletSpeed(250);
			gun.setFireRate(1000);
			//gun.setBulletLifeSpan(2800);
			//gun.setPostFireCallback(null, AssetsRegistry.BOUNCEGUN_MP3);
			
			_enemyBullets.add(gun.group);
		}
		
		override public function update():void
		{
			
			if (inSight) gun.fireFromAngle(aim);
			
			move();
			
			// find the angle between enemy and player
			directionAngle = FlxVelocity.angleBetween(this, player, true);
			// find which way enemy should face
			this.facing = GameUtil.findFacing(directionAngle);
			// find where the enemy should aim
			aim = GameUtil.findDirection(directionAngle);
			
			// plays the animation for where the enemy is aiming
			// up-right, up-left
			if (aim == GameUtil.AIM_RIGHT_UP || aim == GameUtil.AIM_LEFT_UP)
				play("upward");
			// down-left, down-right
			else if ( aim == GameUtil.AIM_LEFT_DOWN || aim == GameUtil.AIM_RIGHT_DOWN)
				play ("downward");
			// down
			else if (aim == GameUtil.AIM_DOWN)
				play ("down");
			// up
			else if (aim == GameUtil.AIM_UP)
				play ("up");
			else
				play("straight");
				
		}
		
		protected function move():void
		{	
			inSight = map.ray(this.getMidpoint(), player.getMidpoint(), null, 1);
			
			if (aware)
			{
				if ((FlxVelocity.distanceBetween(this, player) <= FlxG.height) && inSight)
				{
					stopPathfinding();
				}
				
				else if ((myPath == null || this.pathSpeed == 0) && player.alive) 
				{
					stopPathfinding();
					
					myPath = calculatePath(this.getMidpoint(),  player.getMidpoint());
					this.followPath(myPath, speed);
				}
				
				else
				{
					if (this.path != null)
					{
						this.path.destroy();
					}
					
					this.path = map.findPath(this.getMidpoint(),  player.getMidpoint());
				}
			}
			
			else if (!aware && inSight && this.onScreen())
			{
				aware = true;
			}
		}
		
		protected function calculatePath(start:FlxPoint, end:FlxPoint):FlxPath
		{
			return map.findPath(start, end)
		}
		
		protected function stopPathfinding():void
		{
			this.stopFollowingPath(true);
            this.velocity.x = this.velocity.y = 0;
		}
		
		override public function kill():void
		{
			super.kill();
			
			stopPathfinding();
		}
		
		override public function destroy():void
		{
			if (this.path != null)
			{
				this.path.destroy();
			}
			
			super.destroy();
			gun = null;
		}
		
	}

}
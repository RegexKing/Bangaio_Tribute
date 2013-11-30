package units 
{
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BlackRobot extends Shooter implements Sentient
	{
		private var moving:Boolean = false;
		private var shotDelay:FlxDelay;
		private var aware:Boolean = false;
		
		private var bananas:FlxGroup;
		
		
		public function BlackRobot() 
		{
			super(null, null, null, null, null, null, null);
			
			health = 60;
			points = 400;
			speed = 150;
			
			loadGraphic(AssetsRegistry.bluePNG, true, true, 35, 50);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
			shotDelay = new FlxDelay(2000);
			shotDelay.callback = move;
			shotDelay.start();
			
		}
		
		public function setPos(X:int, Y:int, _enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bananas:FlxGroup, _enemies:FlxGroup, _targets:Array, _bulletType:String = "normal"):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (!textGroup)
			{
				setupGun(_enemyBullets, _bulletTrails, _bulletType);
				gun.setBulletSpeed(250);
				gun.setFireRate(1000);
				
				player = _player;
				blueExplosions = _blueExplosions;
				map = _map;
				textGroup = _textGroup;
				bananas = _bananas;
				
				_enemies.add(this);
				_targets.push(this);
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 60;
			points = 400;
			
			aware = false;
			moving = false;
			
			shotDelay.start();
		}
		
		override public function update():void
		{
			
			super.update();
			
			inSight = map.ray(this.getMidpoint(), player.getMidpoint(), null, 1);
			
			if (inSight)
			{
				alert = true;
				
				// find the angle between enemy and player
				directionAngle = FlxVelocity.angleBetween(this, player, true);

				// find where the enemy should aim
				aim = GameUtil.findDirection(directionAngle);
			}
			
			if (alert)
			{
				// find which way enemy should face
				this.facing = GameUtil.findFacing(directionAngle);
			}
			
			if (inSight && onScreen()) gun.fireFromAngle(aim);
			
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
				
			if (moving && this.pathSpeed == 0)
			{
				stopPathfinding();
					
				moving = false;
			}	
			
			if (isTouching(FLOOR)) velocity.y = 0;
		}
		
		protected function move():void
		{	
			if (aware)
			{
				followPlayer();
			}
			
			else if (!aware && onScreen() && inSight)
			{
				aware = true;
				followPlayer();
			}
			
			shotDelay.start();
		}
		
		protected function followPlayer():void
		{
			
			if (this.path != null)
			{
				this.path.destroy();
			}
					
			this.path = map.findPath(this.getMidpoint(),  player.getMidpoint());
			this.followPath(this.path, speed);
				
			moving = true;
		}
		
		protected function stopPathfinding():void
		{
			this.stopFollowingPath(true);
            this.velocity.x = this.velocity.y = 0;
		}
		
		override public function kill():void
		{
			(bananas.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "banana");
			
			super.kill();
			
			stopPathfinding();
			shotDelay.abort();
			
			aware = false;
		}
		
		override public function destroy():void
		{
			if (this.path != null)
			{
				this.path.destroy();
			}
			
			super.destroy();
			
			if (shotDelay)
			{
				shotDelay.abort();
				shotDelay = null;
			}
		}
		
	}

}
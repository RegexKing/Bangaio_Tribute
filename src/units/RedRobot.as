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
	public class RedRobot extends Shooter
	{
		private var moving:Boolean = false;
		private var shotDelay:FlxDelay;
		private var aware:Boolean = false;
		
		private var apples:FlxGroup;
		
		
		public function RedRobot(_enemyBullets:FlxGroup, _player:Player, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _apples:FlxGroup, _bulletType:String = "normal") 
		{
			super(_enemyBullets, _player, _map, _bulletTrails, _textGroup, _bulletType);
			
			apples = _apples;
			
			health = 40;
			points = 200;
			speed = 150;
			
			loadGraphic(AssetsRegistry.bluePNG, true, true, 35, 50);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
			gun.setBulletSpeed(250);
			gun.setFireRate(1000);
			
			shotDelay = new FlxDelay(3000);
			shotDelay.callback = move;
			shotDelay.start();
			
		}
		
		override public function update():void
		{
			
			super.update();
			
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
			(apples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), textGroup, "apple");
			
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
			
			if (shotDelay != null)
			{
				shotDelay.abort();
				shotDelay = null;
			}
		}
		
	}

}
package units 
{
	import hud.CountdownTimer;
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class RedRobot extends Shooter implements Sentient
	{
		private var aware:Boolean = false;
		private var destination:FlxPoint;
		private var apples:FlxGroup;
		
		public function RedRobot() 
		{
			super(null, null, null, null, null, null, null);
			
			destination = new FlxPoint(0, 0);
			
			health = 40;
			points = 200;
			speed = 150;
			
			loadGraphic(AssetsRegistry.bluePNG, true, true, 35, 50);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
		}
		
		public function setPos(X:int, Y:int, _enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _apples:FlxGroup, _enemies:FlxGroup, _targets:Array, _bulletType:String = "normal"):void
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
				apples = _apples;
				
				_enemies.add(this);
				_targets.push(this);
			}
			
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 40;
			points = 200;
			
			aware = false;
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
				
				gun.fireFromAngle(aim);
			}
			
			if (alert)
			{
				// find which way enemy should face
				this.facing = GameUtil.findFacing(directionAngle);
				
				if (velocity.x == 0 && velocity.y == 0)
				{
					move();
				}
			}
			
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
			
			
			if (isTouching(FLOOR)) velocity.y = 0;
		}
		
		private function move():void
		{
			
			//var randAngle:Number = FlxMath.asRadians(Math.random() * 360);
			//destination.x = player.x + Math.cos(randAngle) * 100;
			//destination.y = player.y + Math.sin(randAngle) * 100;
			destination.x = player.getMidpoint().x;
			destination.y = player.getMidpoint().y;
			
			FlxVelocity.accelerateTowardsPoint(this, destination, 800, 200, 200);
		}
		
		public function knockBack(source:FlxObject):void
		{
			if (this.getMidpoint().x < source.getMidpoint().x)
				{
					this.velocity.x = -(GameData.g_const)/2;
				}
				
				else
				{
					this.velocity.x = GameData.g_const/2;
				}
				
				if (this.getMidpoint().y < source.getMidpoint().y)
				{
					this.velocity.y = -(GameData.g_const)/2;
				}
				
				else
				{
					this.velocity.y = GameData.g_const/2;
				}
		}
		
		override public function kill():void
		{	
			super.kill();
			
			(apples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "apple");
		}
		
	}

}
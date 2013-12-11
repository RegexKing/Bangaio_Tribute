package units
{
	import effects.BulletShell;
	import hud.*;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import util.BulletTrailsContainer;
	import util.FlxTilemapExt;
	import util.ZoomCamera;
	import weapons.*;
	
	/**
	 * 
	 * ...
	 * @author Frank Fazio
	 */
	public class Player extends FlxSprite implements Sentient
	{	
		
		private const BOUNCE:uint = 0;
		private const HOMING:uint = 1;
		private var weaponType:Boolean = Boolean(HOMING);
		
		// If changing this, change number of baked rotations for bullets
		private const OVERDRIVE_BONUS_MAX:int = 200;
		
		// Range for bonus to count
		public const OVERDRIVE_RANGE:int = LevelMap.TILE_SIZE * 8;
		
		public var map:FlxTilemapExt;
		private var zoomCamera:Function;
		private var enemyBullets:FlxGroup;
		private var textGroup:FlxGroup;
		
		
		private var closestTargets:Array;
		private var targets:Array;
		
		private var gibs:FlxEmitter;
		private var bulletShells:FlxEmitter;
		
		// hud objects
		public var lifeBar:FlxBar;
		public var score:Score;
		public var overDriveHud:Overdrive;
		
		//thruster sound Object
		private var thrusterSound:FlxSound;
		private var chargeSound:FlxSound;
		
		//charges availible for missle overdrive. cant use if not at least 100
		public var overdriveCharges:uint = Overdrive.MAX_VAL*2;
		private var fruitMultiplier:uint = 1;
		
		public var aim:int = 0;
		private var directionAngle:Number;
		private var directionFacing:uint;
		private var overdriveTimer:Number = 0.2;
		private var overdriveCounter:ScrollingText;
		
		//Gun Vars
		protected var bounceGun:FlxWeaponExt;
		protected var homingGun:FlxWeaponExt;
		
		public function Player(_map:FlxTilemapExt, _zoomCamera:Function, _playerBullets:FlxGroup, _enemyBullets:FlxGroup, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _particleEmitters:FlxGroup, _xPos:int=0, _yPos:int=0) 
		{	
			super(_xPos, _yPos);
			
			map = _map;
			zoomCamera = _zoomCamera;
			
			enemyBullets = _enemyBullets;
			textGroup = _textGroup;
			closestTargets = new Array();
			
			health = 100;
			
			loadGraphic(AssetsRegistry.playerPNG, true, true, 38, 54);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
			offset.x = 4;
			offset.y = 4;
			width = 30;
			height = 45;
			
			thrusterSound = new FlxSound();
			thrusterSound.loadEmbedded(AssetsRegistry.thruster_MP3, true);
			thrusterSound.survive = false;
			
			chargeSound = new FlxSound();
			chargeSound.loadEmbedded(AssetsRegistry.overdriveCharge_MP3);
			chargeSound.survive = false;
			
			gibs = new FlxEmitter(0, 0, 30);
			gibs.makeParticles(AssetsRegistry.playerGibsPNG, 30, 64, true, 0);
			gibs.setXSpeed( -200, 200);
			gibs.setYSpeed( -200, 200);
			gibs.particleDrag = new FlxPoint(4, 4);
			_particleEmitters.add(gibs);
			
			bulletShells = new FlxEmitter(0, 0, 36);
			bulletShells.gravity = 400;
			bulletShells.setXSpeed( -30, 30);
			bulletShells.setYSpeed( -150, -200);
			
			for (var i:int = 0; i < bulletShells.maxSize; i++)
			{
				bulletShells.add(new BulletShell);
			}
			
			_particleEmitters.add(bulletShells);
			
			if (FlxG.getPlugin(FlxControl) == null) FlxG.addPlugin(new FlxControl);
			
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, false);
			FlxControl.player1.setWASDControl();
			FlxControl.player1.setStandardSpeed(200);
			FlxControl.player1.setMovementSpeed(800, 800, 200, 200);
			FlxControl.player1.setGravity(0, GameData.g_const);
			
			
			
			lifeBar = new FlxBar(10, 10, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, this, "health", 0, 100);
			lifeBar.createGradientBar([0x0], [0xffFF0000, 0xffFF9900, 0xffFFFF00, 0xffBDFF00,  0xff7EFF00, 0xff3FFF00, 0xff00FF00], 1, 0, true, 0xff000000);
			lifeBar.setCallbacks(null, null);
			lifeBar.scrollFactor.x = lifeBar.scrollFactor.y = 0;
			lifeBar.y += lifeBar.height;
			
			score = new Score();
			overDriveHud = new Overdrive(this);
			
			// Guns
			bounceGun = new FlxWeaponExt(BounceBullet, "bounce", _bulletTrails, this, this);
			bounceGun.setBulletBounds(FlxG.worldBounds);
			bounceGun.setBulletSpeed(500);
			bounceGun.setFireRate(100);
			bounceGun.setBulletElasticity(1);
			bounceGun.setBulletLifeSpan(2800);
			bounceGun.setPostFireCallback(null, AssetsRegistry.BOUNCEGUN_MP3);
			
			homingGun = new FlxWeaponExt(HomingBullet, "homing", _bulletTrails, this, this);
			homingGun.setBulletBounds(FlxG.worldBounds);
			homingGun.setBulletSpeed(500);
			homingGun.setFireRate(100);
			homingGun.setBulletLifeSpan(2800);
			homingGun.setPostFireCallback(null, AssetsRegistry.BOUNCEGUN_MP3);
			
			_playerBullets.add(homingGun.group);
			_playerBullets.add(bounceGun.group);
			
		}
		
		public function activateInvince():void
		{
			//TODO: do invincible stuffs
		}
		
		public function incHealth():void
		{
			if (health < 100) health += 10;
		}
		
		public function fillHealth():void
		{
			health = 100;
		}
		
		public function multiplyFruit(_scoreAmt:uint):uint
		{
			var newScoreAmt:uint = _scoreAmt * fruitMultiplier;
			if (newScoreAmt > 1000) newScoreAmt = 1000;
			
			fruitMultiplier++;
			
			return newScoreAmt;
		}
		
		public function setCharge(_chargeAmt:uint):void
		{
			overdriveCharges += _chargeAmt;
			
			if (overdriveCharges > Overdrive.MAX_VAL*5)
			{
				overdriveCharges = Overdrive.MAX_VAL*5;
			}
		}
		
		public function set targetsArray(_targets:Array):void
		{
			targets = _targets;
		}
		
		public function get bounceBulletGroup():FlxGroup
		{
			return bounceGun.group;
		}
		
		public function get homingBulletGroup():FlxGroup
		{
			return homingGun.group;
		}
		
		override public function update():void
		{	
			super.update();
				
			// toggle weapon type
			if (FlxG.keys.justPressed("Q"))
			{
				weaponType = !weaponType;
				
				FlxG.play(AssetsRegistry.SWITCHWEAPON_MP3);
			}
			
			
			//boost controls
			if (FlxG.keys.justPressed("SHIFT"))
			{
				FlxControl.player1.setMovementSpeed(1000, 1000, 280, 280);
				thrusterSound.play();
			}
			
			else if (FlxG.keys.pressed("SHIFT"))
			{
				// TODO: play jet animation
			}
			
			else if (FlxG.keys.justReleased("SHIFT"))
			{
				FlxControl.player1.setMovementSpeed(800, 800, 200, 200);
				thrusterSound.pause();
			}
			
			//Attack controls
			if (FlxG.keys.justPressed("SPACE") && overdriveCharges >= Overdrive.MAX_VAL)
			{
				FlxControl.player1.enabled = false;
				velocity.x = velocity.y = 0;
				acceleration.x = acceleration.y = 0;
				
				overdriveCounter = (textGroup.recycle(ScrollingText) as ScrollingText).setText(16, 0xffFFFFFF);
				overdriveCounter.x = this.getMidpoint().x - (overdriveCounter.width/2);
				overdriveCounter.y = this.y - overdriveCounter.height;
				
				chargeSound.play();
				thrusterSound.pause();
			}
			
			else if (FlxG.keys.pressed("SPACE") && overdriveCharges >= Overdrive.MAX_VAL)
			{		
				overdriveTimer += FlxG.elapsed;
					
				if (overdriveTimer >= 1.0) overdriveTimer = 1.0;
				
				overdriveCounter.text = String(Math.round(overdriveTimer / 0.01));
				overdriveCounter.x = this.getMidpoint().x - (overdriveCounter.width/2);
				overdriveCounter.y = this.y - overdriveCounter.height;
					
				//Play charging animations
					
			}
				
			else if (FlxG.keys.justReleased("SPACE") && overdriveCharges >= Overdrive.MAX_VAL)
			{
				overdriveCharges -= Overdrive.MAX_VAL;
				
				var bonusOverdrive:int = 0;
				
				for each (var bulletsGroup:FlxGroup in enemyBullets.members)
				{
					 bonusOverdrive += bulletsGroup.countOnScreen(this) * 2;
				}
				
				FlxG.log(bonusOverdrive);
				
				if (bonusOverdrive > OVERDRIVE_BONUS_MAX) bonusOverdrive = OVERDRIVE_BONUS_MAX;
				
				var overDriveAmt:int = (overdriveTimer / 0.01) + bonusOverdrive;
					
				if (uint(weaponType) == HOMING)
				{
					homingGun.setBulletOffset(0, 0);
					homingGun.setFireRate(0);
					homingGun.missleOverdrive(overDriveAmt);
					homingGun.setFireRate(100);
				}
					
				else
				{
					bounceGun.setBulletOffset(0, 0);
					bounceGun.setFireRate(0);
					bounceGun.missleOverdrive(overDriveAmt);
					bounceGun.setFireRate(100);
				}
					
				overdriveTimer = 0.2;
				
				if (bonusOverdrive > 0) overdriveCounter.text += "+" + bonusOverdrive;
				
				overdriveCounter.size += Math.ceil(overDriveAmt / 14);
				overdriveCounter.start();
				
				overDriveHud.updateOverdriveHud();
					
				FlxControl.player1.enabled = true;
				
				zoomCamera();
				
				//play overdrive sound
				FlxG.play(AssetsRegistry.MISSLEOVERDRIVE_MP3);
				thrusterSound.resume();
			}
				
			else if (FlxG.keys.justPressed("SPACE"))
			{
				//play not enough overdrive ammo
				FlxG.play(AssetsRegistry.NOAMMO_MP3);
			}
				
			// switch statement to fire correct weapon
			else if (FlxG.mouse.pressed())
			{	
				if (uint(weaponType) == HOMING)
				{
					fireGun(homingGun);
				}
				else
				{
					fireGun(bounceGun);
				}
			}
			
			// find the angle between player and mouse
			directionAngle = FlxVelocity.angleBetweenMouse(this, true);
			// find which way player should face
			this.facing = GameUtil.findFacing(directionAngle);
			// find where the player should aim
			aim = GameUtil.findDirection(directionAngle);
			
			// plays the animation for where the player is aiming
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
			
			//ground controls
			if (!FlxG.keys.pressed("SHIFT"))
			{
				if (justTouched(FLOOR))
				{
					acceleration.x = 0;
				}
				
				if (isTouching(FLOOR) || isTouching(CEILING))
				{
					velocity.y = 0;
					
					
					if (FlxG.keys.A)
					{
						velocity.x = -150;
					}
					
					else if (FlxG.keys.D)
					{
						velocity.x = 150;
					}
					
					else
					{
						velocity.x = 0;
					}
					
					if (isTouching(FLOOR))
					{
						if (FlxG.keys.justPressed("W"))
						{
							FlxG.play(AssetsRegistry.jump_MP3);
						}
						
						//TODO: add ground animations
					}
				}	
			}
		}
		
		private function fireGun(gun:FlxWeaponExt):void
		{
			
					//up-right
					if (aim == GameUtil.AIM_RIGHT_UP)
					{
						gun.setBulletOffset(20, 0);
					}
					//up-left
					else if (aim == GameUtil.AIM_LEFT_UP)
					{
						gun.setBulletOffset(0, 0);
					}
					//left-down
					else if (aim == GameUtil.AIM_LEFT_DOWN)
					{
						
						gun.setBulletOffset(0, 30);
					}
					//right-down
					else if (aim == GameUtil.AIM_RIGHT_DOWN)
					{
						
						gun.setBulletOffset(20, 30);
					}
					//down
					else if (aim == GameUtil.AIM_DOWN)
					{
						
						gun.setBulletOffset(10, 50);
					}
					//up
					else if (aim == GameUtil.AIM_UP)
					{
						
						gun.setBulletOffset(10, 0);
					}
					//right
					else if (aim == GameUtil.AIM_RIGHT)
					{
						
						gun.setBulletOffset(20, 10);
					}
					//left
					else
					{
						gun.setBulletOffset(0, 20);
					}
					
					// postion bullet shell
					bulletShells.at(this);
					
					gun.fireFromAngle(aim, true, bulletShells);
		}
		
		public function knockBack(source:FlxObject):void
		{
			
			if (!FlxG.keys.pressed("SHIFT") && !FlxG.keys.pressed("SPACE"))
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
		}
		
		override public function hurt(_damageNumber:Number):void
		{
			super.hurt(_damageNumber);
			fruitMultiplier = 1;
			
			this.flicker(0.7);
			FlxG.camera.shake(0.005, 0.35);
			
			//sound effect
		}
		
		override public function kill():void
		{
			if (overdriveCounter) overdriveCounter.kill();
			
			super.kill();
			
			thrusterSound.stop();
			chargeSound.stop();
			
			FlxG.camera.shake(0.01,0.35);
			FlxG.camera.flash(0xffFF0000, 0.35);
			
			if(gibs != null)
			{
				gibs.at(this);
				gibs.start(true, 2.5);
			}
			
			//sound effect
		}
		
		// finds close targets for homing missle to track
		public function findClosestTarget():FlxSprite
		{
			// clear the array first
			closestTargets.length = 0;
			
			for each (var target:FlxSprite in targets)
			{
				if (target != null && target.active && target.onScreen() && map.ray(this.getMidpoint(), target.getMidpoint()))
				{
					closestTargets.push(target);
					
					// TODO: play animation for selected target?
				}
				
				else
				{
					//TODO: kill animation for selected target
				}
			}
			
			// get a random target close to player
			return closestTargets[Math.floor(Math.random() * closestTargets.length)];
		}
		
		override public function destroy():void
		{
			FlxControl.clear();
			
			bounceGun = null;
			homingGun = null;
			closestTargets = null;
			
			zoomCamera = null;
			
			if (thrusterSound) thrusterSound.destroy();
			if (chargeSound) chargeSound.destroy();
			
			super.destroy();
			
		}	
		
	}

}
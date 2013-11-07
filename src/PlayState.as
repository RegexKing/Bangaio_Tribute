package  
{	
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import units.Player;
	import util.BulletTrailsContainer;
	import util.ZoomCamera;
	import weapons.BounceBullet;
	 
	public class PlayState extends FlxState
	{
		private var mapCollideable:FlxGroup;
		private var explosionVictims:FlxGroup;
		private var playerBullets:FlxGroup;
		private var obstacles:FlxGroup;
		private var targets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var items:FlxGroup;
		private var hud:FlxGroup;
		private var textGroup:FlxGroup;
		private var particleEmitters:FlxGroup;
		private var explosions:FlxGroup;
		private var explosionAreas:FlxGroup;
		
		private var zoomCam:ZoomCamera;
		private var map:LevelMap;
		private var bulletTrails:BulletTrailsContainer;
		private var player:Player;
		
		private var starField:StarfieldFX;
		private var bg:FlxSprite;
		
		public function PlayState() 
		{ 
		}
		
		override public function create():void
		{	
			FlxG.bgColor = 0xff000000;
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
            {
                FlxG.addPlugin(new FlxSpecialFX);
            }
			
			mapCollideable = new FlxGroup(6);
			explosionVictims = new FlxGroup(2);
			playerBullets = new FlxGroup(2);
			hud = new FlxGroup();
			obstacles = new FlxGroup();
			targets = new FlxGroup();
			enemyBullets = new FlxGroup();
			items = new FlxGroup();
			particleEmitters = new FlxGroup();
			textGroup = new FlxGroup();
			explosions = new FlxGroup();
			explosionAreas = new FlxGroup();
			
			
			// TODO: LevelMap takes an int argument to decide which level data to load
			map = new LevelMap();
			
			FlxG.worldBounds = map.getBounds();
			
			createBackgroundObjects();
			
			player = new Player(map, zoomCamera, playerBullets, enemyBullets, bulletTrails, targets, textGroup, particleEmitters);
			
			map.InitializeLevel(player, obstacles, targets, enemyBullets, bulletTrails, textGroup, items, explosions, explosionAreas);
			
			zoomCam = new ZoomCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(zoomCam);
			zoomCam.setBounds(0, 0, map.width, map.height);
			zoomCam.follow(player);
			zoomCam.targetZoom = 1;
			zoomCam.zSpeed = 15;
			
			hud.add(textGroup);
			hud.add(player.lifeBar);
			
			obstacles.add(targets);
			
			//add to state
			add(bulletTrails);
			add(bg);
			add(map);
			add(explosions);
			add(items);
			add(player);
			add(particleEmitters);
			add(obstacles);
			add(explosionAreas);
			add(enemyBullets);
			add(playerBullets);
			add(hud);
			
			//aggregate map collideables
			mapCollideable.add(particleEmitters);
			mapCollideable.add(player);
			mapCollideable.add(targets);
			mapCollideable.add(map.indestructibleBlocks);
			mapCollideable.add(playerBullets);
			mapCollideable.add(enemyBullets);
			
			explosionVictims.add(player);
			explosionVictims.add(obstacles);
			
			//FlxG.playMusic(AssetsRegistry.BGM1_MP3);
		}
		
		override public function update():void
		{
			super.update();
			
			//debug
			if (FlxG.keys.justPressed("R")) FlxG.switchState(new PlayState);
			
			FlxG.overlap(obstacles, playerBullets, damageObject);
			FlxG.overlap(player, enemyBullets, damageObject);
			FlxG.overlap(enemyBullets, playerBullets, damageObject);
			//FlxG.overlap(explosionVictims, explosionAreas, );
			FlxG.overlap(player, items, pickupItem);
			
			FlxG.collide(explosionVictims, explosionVictims);
			FlxG.collide(mapCollideable, map);
			//FlxG.collide(playerBullets, obstacles, check green_blue_Box);
		}
		
		public function damageObject(unit:FlxObject, bullet:FlxObject):void
		{
			
			unit.hurt((bullet as Bullet).dealDamage());
			bullet.kill();
		}
		
		public function pickupItem(unit:FlxObject, item:FlxObject):void
		{
			//(item as Item).pickup(unit as Player); TODO: Item pickup function
			item.kill();
		}
		
		 override public function destroy():void
         {
            // Important! Clear out the plugin, otherwise resources will get messed right up after a while
            FlxSpecialFX.clear();
			
            mapCollideable.destroy();
			explosionVictims.destroy();
			starField.destroy();
			
            super.destroy();
			if (zoomCam != null) zoomCam = null;
         }
		 
		 public function zoomCamera():void
		{
			zoomCam.zoom = 4;
		}

		private function createBackgroundObjects():void
		{
			starField = FlxSpecialFX.starfield();
			
			bg = starField.create(0, 0, FlxG.width, FlxG.height, 250);
			bg.scrollFactor.x = bg.scrollFactor.y = 0;
			starField.setBackgroundColor(0x00);
			starField.setStarDepthColors(5, 0xffFF7F7F, 0xff7F7FFF);
			starField.setStarSpeed( -0.1, 0);
			
			// screen for bulletTrails
			bulletTrails = new BulletTrailsContainer(map);
		}
	}

}
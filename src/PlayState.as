package  
{	
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import units.Player;
	import units.Target;
	import util.BulletTrailsContainer;
	import util.ZoomCamera;
	import weapons.BounceBullet;
	 
	public class PlayState extends FlxState
	{
		private var mapCollideable:FlxGroup;
		private var playerBullets:FlxGroup;
		private var targets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var items:FlxGroup;
		private var hud:FlxGroup;
		private var particleEmitters:FlxGroup;
		private var explosions:FlxGroup;
		private var textGroup:FlxGroup;
		
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
			
			mapCollideable = new FlxGroup(5);
			hud = new FlxGroup();
			playerBullets = new FlxGroup(2);
			targets = new FlxGroup();
			enemyBullets = new FlxGroup();
			items = new FlxGroup();
			particleEmitters = new FlxGroup();
			explosions = new FlxGroup();
			textGroup = new FlxGroup();
			
			// TODO: LevelMap takes an int argument to decide which level data to load
			map = new LevelMap();
			
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = FlxG.width + (FlxG.width / 2);
			FlxG.worldBounds.height = FlxG.height + (FlxG.height / 2);
			
			createBackgroundObjects();
			
			player = new Player(map, zoomCamera, playerBullets, enemyBullets, bulletTrails, targets, textGroup, particleEmitters);
			map.InitializeLevel(player, targets, enemyBullets, bulletTrails, items);
			
			zoomCam = new ZoomCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(zoomCam);
			zoomCam.setBounds(0, 0, map.width, map.height);
			zoomCam.follow(player);
			zoomCam.targetZoom = 1;
			zoomCam.zSpeed = 15;
			
			add(bulletTrails);
			add(bg);
			add(map);
			add(explosions);
			add(items);
			add(player);
			add(particleEmitters);
			add(targets);
			add(enemyBullets);
			add(playerBullets);
			add(hud);
			
			mapCollideable.add(particleEmitters);
			mapCollideable.add(player);
			mapCollideable.add(targets);
			mapCollideable.add(playerBullets);
			mapCollideable.add(enemyBullets);
			
			hud.add(textGroup);
			hud.add(player.lifeBar);
			
			FlxG.playMusic(AssetsRegistry.BGM1_MP3);
		}
		
		override public function update():void
		{
			super.update();
			
			//debug
			if (FlxG.keys.justPressed("R")) FlxG.switchState(new PlayState);
			
			updateWorldBounds();
			
			FlxG.collide(player, targets);
			FlxG.collide(mapCollideable, map);
			
			FlxG.overlap(targets, playerBullets, damageObject);
			FlxG.overlap(player, enemyBullets, damageObject);
			FlxG.overlap(enemyBullets, playerBullets, damageObject);
			FlxG.overlap(player, items, pickupItem);
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
			starField.destroy();
			
            super.destroy();
			if (zoomCam != null) zoomCam = null;
         }
		 
		 public function zoomCamera():void
		 {
			 zoomCam.zoom = 4;
		 }
		 
		 private function updateWorldBounds():void
		 {
			FlxDisplay.screenCenterFlxRect(FlxG.worldBounds);
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
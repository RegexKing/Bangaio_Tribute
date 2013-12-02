package  
{	
	import effects.BulletShell;
	import effects.RedExplosion;
	import hud.CountdownTimer;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import units.BlueDiamond;
	import units.Building;
	import units.Inertia;
	import units.Player;
	import units.Sentient;
	import util.BulletTrailsContainer;
	import items.Item;
	import util.ZoomCamera;
	import weapons.BounceBullet;
	import weapons.E_Laser;
	import weapons.HomingBullet;
	 
	public class PlayState extends FlxState
	{
		private var mapCollideable:FlxGroup;
		private var explosionAreas:FlxGroup;
		private var bulletDamageableObstacles:FlxGroup;
		private var explosionVictims:FlxGroup;
		private var enemyObjects:FlxGroup;
		private var immovableObstaclesB:FlxGroup;
		
		private var collideableUnits:FlxGroup;
		private var immovableObstacles:FlxGroup;
		private var bullets:FlxGroup;
		
		private var enemies:FlxGroup;
		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var items:FlxGroup;
		private var hudGroup:FlxGroup;
		private var textGroup:FlxGroup;
		private var particleEmitters:FlxGroup;
		private var explosions:FlxGroup;
		private var smallRedExplosions:FlxGroup;
		
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
			
			mapCollideable = new FlxGroup(3);
			
			explosionAreas = new FlxGroup(3);
			bulletDamageableObstacles = new FlxGroup();
			explosionVictims = new FlxGroup(2);
			enemyObjects = new FlxGroup(2);
			immovableObstaclesB = new FlxGroup();
			
			collideableUnits = new FlxGroup();
			immovableObstacles = new FlxGroup();
			bullets = new FlxGroup(2);
			
			enemies = new FlxGroup();
			playerBullets = new FlxGroup(2);
			hudGroup = new FlxGroup(8);
			enemyBullets = new FlxGroup();
			items = new FlxGroup();
			particleEmitters = new FlxGroup(3);
			textGroup = new FlxGroup();
			explosions = new FlxGroup(6);
			smallRedExplosions = new FlxGroup();
			
			map = new LevelMap(GameData.level);
			
			FlxG.worldBounds = map.getBounds();
			
			createBackgroundObjects();
			
			player = new Player(map, zoomCamera, playerBullets, enemyBullets, bulletTrails, textGroup, particleEmitters);
			
			// setup map
			map.InitializeLevel(bulletTrails, textGroup, player, enemies, enemyBullets, items, explosions, explosionAreas, 
				collideableUnits, immovableObstacles, immovableObstaclesB,  bulletDamageableObstacles);
			
			zoomCam = new ZoomCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(zoomCam);
			zoomCam.setBounds(0, 0, map.width, map.height);
			zoomCam.follow(player);
			zoomCam.targetZoom = 1;
			zoomCam.zSpeed = 15;
			
			//aggregate flxgroups
			bullets.add(playerBullets);
			bullets.add(enemyBullets);
			
			mapCollideable.add(particleEmitters);
			mapCollideable.add(collideableUnits);
			mapCollideable.add(bullets);
			
			bulletDamageableObstacles.add(immovableObstaclesB);
			
			explosionVictims.add(immovableObstacles);
			explosionVictims.add(collideableUnits);
			
			enemyObjects.add(enemies);
			enemyObjects.add(enemyBullets);
			
			collideableUnits.add(player);
			collideableUnits.add(enemies);
			
			//decorate purely visual flxgroups
			hudGroup.add(textGroup);
			hudGroup.add(player.lifeBar);
			hudGroup.add(new CountdownTimer());
			hudGroup.add(player.score);
			hudGroup.add(player.overDriveHud);
			
			explosions.add(explosionAreas);
			explosions.add(smallRedExplosions);
			
			//add to state
			add(bulletTrails);
			add(bg);
			add(map);
			add(collideableUnits);
			add(map.doors);
			add(bullets);
			add(immovableObstacles);
			
			add(items);
			add(particleEmitters);
			add(explosions);
			add(hudGroup);
			
			FlxG.playMusic(AssetsRegistry.BGM1_MP3);
			
		}
		
		override public function update():void
		{
			super.update();
			
			//debug
			if (FlxG.keys.justPressed("R")) FlxG.switchState(new PlayState);
			
			FlxG.collide(playerBullets, map.playerBulletImpassable);
			FlxG.collide(playerBullets.members[1] as FlxGroup, map.blueBoxes); // bounce bullet bounce off
			FlxG.collide(collideableUnits, collideableUnits);
			FlxG.collide(immovableObstacles, collideableUnits);
			FlxG.collide(map, mapCollideable);
			
			FlxG.overlap(player, items, pickupItem);
			FlxG.overlap(enemyObjects, playerBullets, damageObject);
			FlxG.overlap(player, enemyBullets, damageObject);
			FlxG.overlap(explosionVictims, explosionAreas, explodeObject);
			FlxG.overlap(bulletDamageableObstacles, bullets, damageImmoveableObject);
			
		}
		
		public function damageObject(unit:FlxObject, bullet:FlxObject):void
		{		
			if ((bullet as FlxSprite).onScreen()) unit.hurt((bullet as Bullet).dealDamage());
				
			(smallRedExplosions.recycle(RedExplosion) as RedExplosion).startAt(bullet.getMidpoint(), "small");
			
			if (unit is Bullet)
			{
				(smallRedExplosions.recycle(RedExplosion) as RedExplosion).startAt(unit.getMidpoint(), "small");
			}
				
			bullet.kill();
			
			if (unit is Sentient) (unit as Sentient).knockBack(bullet);
				
			if (bullet is BounceBullet || bullet is HomingBullet)
			{
				GameUtil.shakeCam();
			}
		}
		
		public function damageImmoveableObject(unit:FlxObject, bullet:FlxObject):void
		{
			if ((bullet as FlxSprite).onScreen()) unit.hurt((bullet as Bullet).dealDamage());
				
			if (!(unit is BlueDiamond)) 
			{
				bullet.kill();
				(smallRedExplosions.recycle(RedExplosion) as RedExplosion).startAt(bullet.getMidpoint(), "small");
			}
				
			if (bullet is BounceBullet || bullet is HomingBullet)
			{
				GameUtil.shakeCam();
			}
		}
		
		public function explodeObject(unit:FlxObject, explosion:FlxObject):void
		{
			unit.explosionHurt(1);
			
			if (unit is Sentient) (unit as Sentient).knockBack(explosion);
		}
		
		public function pickupItem(unit:FlxObject, item:FlxObject):void
		{
			(item as Item).pickUp(unit as Player);
		}
		
		 override public function destroy():void
         {
            // Important! Clear out the plugin, otherwise resources will get messed right up after a while
            FlxSpecialFX.clear();
			
            mapCollideable.destroy();
			explosionAreas.destroy();
			bulletDamageableObstacles.destroy();
			explosionVictims.destroy();
			enemyObjects.destroy();
			immovableObstaclesB.destroy();
			
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
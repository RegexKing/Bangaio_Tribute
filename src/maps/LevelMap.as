package maps 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import org.flixel.*;
	import units.*;
	import util.BulletTrailsContainer;
	import util.FlxTilemapExt;
	 
	public class LevelMap extends FlxTilemapExt
	{
		public static const TILE_SIZE:int = 16;
		
		public var blueBoxes:FlxGroup;
		public var greenBoxes:FlxGroup;
		
		private var enemyBullets:FlxGroup;
		private var bulletTrails:BulletTrailsContainer;
		private var items:FlxGroup;
		private var player:Player;
		private var textGroup:FlxGroup;
		
		private var enemies:FlxGroup;
		private var collideableUnits:FlxGroup;
		private var immovableObstacles:FlxGroup;
		private var immovableObstaclesB:FlxGroup;
		private var bulletDamageableObstacles:FlxGroup;
		
		//recycleable flxgroups
		private var oranges:FlxGroup;
		private var apples:FlxGroup;
		private var bananas:FlxGroup;
		private var pineapples:FlxGroup;
		private var watermelons:FlxGroup;
		private var redExplosions:FlxGroup;
		private var blueExplosions:FlxGroup;
		private var smallExplosionAreas:FlxGroup;
		private var largeExplosionAreas:FlxGroup;
		
		private var spriteMap:String = "";
		private var gateChains:Array;
		private var targets:Array;
		
		public function LevelMap(_level:uint = 1) 
		{
			if (_level == 1)  
			{
				this.loadMap(new AssetsRegistry.testCSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				
				//TODO: load csv map of sprite positions
				//spriteMap = //sprite csv data
			}
		}
		
		public function InitializeLevel(_bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _player:Player, _enemies:FlxGroup, 
			_enemyBullets:FlxGroup, _items:FlxGroup, _explosions:FlxGroup, _explsionAreas:FlxGroup, _collideableUnits:FlxGroup, 
			_immovableObstacles:FlxGroup, _immovableObstaclesB:FlxGroup,  _bulletDamageableObstacles:FlxGroup):void
		{
			bulletTrails = _bulletTrails;
			player = _player;
			enemyBullets = _enemyBullets;
			textGroup = _textGroup;
			items = _items;
			enemies = _enemies;
			collideableUnits = _collideableUnits;
			immovableObstacles = _immovableObstacles;
			immovableObstaclesB = _immovableObstaclesB;
			bulletDamageableObstacles = _bulletDamageableObstacles;
			
			targets = new Array();
			gateChains = new Array();
			blueBoxes = new FlxGroup();
			greenBoxes = new FlxGroup();
			
			//recycleable groups//=====
			//items
			oranges = new FlxGroup();
			apples = new FlxGroup();
			bananas = new FlxGroup();
			pineapples = new FlxGroup();
			watermelons = new FlxGroup();
			//explosion animations
			redExplosions = new FlxGroup();
			blueExplosions = new FlxGroup();
			//explosion areas
			smallExplosionAreas = new FlxGroup();
			largeExplosionAreas = new FlxGroup();
			//==========================
			
			//aggregate flxgroups
			items.add(oranges);
			items.add(apples);
			items.add(bananas);
			items.add(pineapples);
			items.add(watermelons);
			
			_explosions.add(blueExplosions);
			_explosions.add(redExplosions);
			_explosions.add(smallExplosionAreas);
			_explosions.add(largeExplosionAreas);
			
			_explsionAreas.add(smallExplosionAreas);
			_explsionAreas.add(largeExplosionAreas);
			
			// parseSpriteMap();
			// ^^ this function will parse the spritemapdata, will create/position game objects
			
			player.x = 1 * TILE_SIZE;
			player.y = 6 * TILE_SIZE;
			
			//for (var i:int = 0; i < 50; i++)
			//{
				var enemy2:Blue = new Blue(enemyBullets, player, this, bulletTrails, textGroup, "homing");
				enemy2.x = 800;
				enemy2.y = 200;
				enemies.add(enemy2);
				targets.push(enemy2);
				
				
			//}
			
			var enemy3:Shrapnel = new Shrapnel(enemyBullets, player, this, bulletTrails, textGroup, "normal");
			enemy3.x = 900;
			enemy3.y = 300;
			enemies.add(enemy3);
			targets.push(enemy3);
			
			player.targetsArray = targets;
			
		}
		
		
		private function parseSpriteMap():void
		{
			
		}
		
		override public function destroy():void
		{	
			super.destroy();
			
			if (gateChains) gateChains = null;
		}
		
	}

}
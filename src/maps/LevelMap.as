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
		
		private var obstacles:FlxGroup;
		private var targets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var bulletTrails:BulletTrailsContainer;
		private var items:FlxGroup;
		private var player:Player;
		private var textGroup:FlxGroup;
		
		//recycleable flxgroups
		private var singleLives:FlxGroup;
		private var oranges:FlxGroup;
		private var apples:FlxGroup;
		private var bananas:FlxGroup;
		private var pineapples:FlxGroup;
		private var watermelons:FlxGroup;
		private var brownBlocks:FlxGroup;
		private var redRobots:FlxGroup;
		private var redExplosions:FlxGroup;
		private var blueExplosions:FlxGroup;
		private var smallExplosionAreas:FlxGroup;
		private var largeExplosionAreas:FlxGroup;
		
		private var spriteMap:String = "";
		private var gateChains:Array;
		
		public function LevelMap(_level:uint = 1) 
		{
			if (_level == 1)  
			{
				this.loadMap(new AssetsRegistry.testCSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				
				//TODO: load csv map of sprite positions
				//spriteMap = //sprite csv data
			}
		}
		
		public function InitializeLevel(_player:Player, _obstacles:FlxGroup, _targets:FlxGroup, _enemyBullets:FlxGroup, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _items:FlxGroup, _explosions:FlxGroup, _explosionAreas:FlxGroup):void
		{
			bulletTrails = _bulletTrails;
			player = _player;
			obstacles = _obstacles;
			targets = _targets;
			enemyBullets = _enemyBullets;
			textGroup = _textGroup;
			items = _items;
			
			//recycleable groups//=====
			//items
			singleLives = new FlxGroup();
			oranges = new FlxGroup();
			apples = new FlxGroup();
			bananas = new FlxGroup();
			pineapples = new FlxGroup();
			watermelons = new FlxGroup();
			//generators
			brownBlocks = new FlxGroup();
			redRobots = new FlxGroup();
			//explosion animations
			redExplosions = new FlxGroup();
			blueExplosions = new FlxGroup();
			//explosion areas
			smallExplosionAreas = new FlxGroup();
			largeExplosionAreas = new FlxGroup();
			//==========================
			
			//aggregate flxgroups
			
			items.add(singleLives);
			items.add(oranges);
			items.add(apples);
			items.add(bananas);
			items.add(pineapples);
			items.add(watermelons);
			
			_explosions.add(blueExplosions);
			_explosions.add(redExplosions);
			
			_explosionAreas.add(smallExplosionAreas);
			_explosionAreas.add(largeExplosionAreas);
			
			// parseSpriteMap();
			// ^^ this function will parse the spritemapdata, will create/position game objects
			
			player.x = 1 * TILE_SIZE;
			player.y = 6 * TILE_SIZE;
			
			//for (var i:int = 0; i < 50; i++)
			//{
				var enemy2:Blue = new Blue(enemyBullets, player, this, bulletTrails, textGroup, "homing");
				enemy2.x = 800;
				enemy2.y = 200;
				targets.add(enemy2);
			//}
			
			var enemy3:Shrapnel = new Shrapnel(enemyBullets, player, this, bulletTrails, textGroup, "normal");
			enemy3.x = 900;
			enemy3.y = 300;
			targets.add(enemy3);
			
		}
		
		
		private function parseSpriteMap():void
		{
			gateChains = new Array();
			
		}
		
		override public function destroy():void
		{
			redRobots.destroy();
			
			super.destroy();
			
			if (gateChains) gateChains = null;
		}
		
	}

}
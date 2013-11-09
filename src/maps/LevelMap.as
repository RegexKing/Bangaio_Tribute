package maps 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import org.flixel.*;
	import units.*;
	import util.*;
	 
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
		
		private var spriteMap:String;
		private var gateChains:Array;
		private var targets:Array;
		
		public function LevelMap(_level:uint = 1) 
		{
			if (_level == 1)  
			{
				this.loadMap(new AssetsRegistry.level_1CSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				spriteMap = new AssetsRegistry.level_1_SpritesCSV;
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
			
			parseSpriteMap();
			
			// To remove later -----
			player.x = 1 * TILE_SIZE;
			player.y = 6 * TILE_SIZE;
			//----------------------
			
			player.targetsArray = targets;
		}
		
		
		private function parseSpriteMap():void
		{	
			var spriteIds:Array = CSVParser.parse(spriteMap);
			
			for (var i:int = 0; i < this.heightInTiles; i++)
			{
				for (var j:int = 0; j < this.widthInTiles; j++)
				{
					var id:int = int(spriteIds[i][j]);
					
					var xPos:int = j;
					var yPos:int = i;
					xPos *= TILE_SIZE;
					yPos *= TILE_SIZE;
					
					if (id == 1)
					{
						player.x = xPos;
						player.y = yPos;
					}
					
					else if (id == 63)
					{
						var redRobot:RedRobot = new RedRobot(enemyBullets, player, this, bulletTrails, textGroup);
						redRobot.x = xPos;
						redRobot.y = yPos;
						
						enemies.add(redRobot);
						targets.push(redRobot);
					}
				}
			}
			
			spriteIds = null;
		}
		
		override public function destroy():void
		{	
			super.destroy();
			
			if (gateChains) gateChains = null;
		}
		
	}

}
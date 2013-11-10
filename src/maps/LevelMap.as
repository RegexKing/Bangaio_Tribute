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
		
		//Green boxes and small solid blocks
		public var playerBulletImpassable:FlxGroup;
		
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
		
		override public function destroy():void
		{	
			super.destroy();
			
			if (gateChains) gateChains = null;
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
			playerBulletImpassable = new FlxGroup();
			
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
					
					createSprite(id, xPos, yPos);
				}
			}
			
			spriteIds = null;
		}
		
		private function createSprite(id:int, X:int, Y:int):void
		{
			if (id == 0) return;
			
			else if (id == 1)
			{
				player.x = X;
				player.y = Y;
			}
			
			else if (id == 2)
			{
				
			}
			
			else if (id == 3)
			{
				
			}
			
			else if (id == 4)
			{
				
			}
			
			else if (id == 5)
			{
				
			}
			
			else if (id == 6)
			{
				
			}
			
			else if (id == 7)
			{
				
			}
			
			else if (id == 8)
			{
				
			}
			
			else if (id == 9)
			{
				
			}
			
			else if (id == 10)
			{
				
			}
			
			else if (id == 11)
			{
				
			}
			
			else if (id == 12)
			{
				
			}
			
			else if (id == 13)
			{
				var smallBomb:SmallBomb = new SmallBomb(textGroup);
				smallBomb.x = X;
				smallBomb.y = Y;
				
				immovableObstacles.add(smallBomb);
				immovableObstaclesB.add(smallBomb);
				gateChains.push(smallBomb);
			}
			
			else if (id == 14)
			{
				
			}
			
			else if (id == 15)
			{
				
			}
			
			else if (id == 16)
			{
				
			}
			
			else if (id == 17)
			{
				
			}
			
			else if (id == 18)
			{
				var brownBlock:BrownBlock = new BrownBlock(X, Y, textGroup);
				collideableUnits.add(brownBlock);
				bulletDamageableObstacles.add(brownBlock);
				targets.push(brownBlock);
			}
			
			else if (id == 19)
			{
				var buildingh:Building = new Building("house", textGroup);
				buildingh.x = X;
				buildingh.y = Y;
				
				immovableObstacles.add(buildingh);
				immovableObstaclesB.add(buildingh);
				targets.push(buildingh);
			}
			
			else if (id == 20)
			{
				var buildingw:Building = new Building("wideBuilding", textGroup);
				buildingw.x = X;
				buildingw.y = Y;
				
				immovableObstacles.add(buildingw);
				immovableObstaclesB.add(buildingw);
				targets.push(buildingw);
			}
			
			else if (id == 21)
			{
				var buildingt:Building = new Building("tallBuilding", textGroup);
				buildingt.x = X;
				buildingt.y = Y;
				
				immovableObstacles.add(buildingt);
				immovableObstaclesB.add(buildingt);
				targets.push(buildingt);
			}
			
			else if (id == 22)
			{
				var buildingc:Building = new Building("car", textGroup);
				buildingc.x = X;
				buildingc.y = Y;
				
				immovableObstacles.add(buildingc);
				immovableObstaclesB.add(buildingc);
				targets.push(buildingc);
			}
			
			else if (id == 23)
			{
				var buildinghd:Building = new Building("house", textGroup, DOWN);
				buildinghd.x = X;
				buildinghd.y = Y;
				
				immovableObstacles.add(buildinghd);
				immovableObstaclesB.add(buildinghd);
				targets.push(buildinghd);
			}
			
			else if (id == 24)
			{
				var buildingwd:Building = new Building("wideBuilding", textGroup, DOWN);
				buildingwd.x = X;
				buildingwd.y = Y;
				
				immovableObstacles.add(buildingwd);
				immovableObstaclesB.add(buildingwd);
				targets.push(buildingwd);
			}
			
			else if (id == 25)
			{
				var buildingtd:Building = new Building("tallBuilding", textGroup, DOWN);
				buildingtd.x = X;
				buildingtd.y = Y;
				
				immovableObstacles.add(buildingtd);
				immovableObstaclesB.add(buildingtd);
				targets.push(buildingtd);
			}
			
			else if (id == 26)
			{
				var buildingcd:Building = new Building("car", textGroup, DOWN);
				buildingcd.x = X;
				buildingcd.y = Y;
				
				immovableObstacles.add(buildingcd);
				immovableObstaclesB.add(buildingcd);
				targets.push(buildingcd);
			}
			
			else if (id == 27)
			{
				var indestructibleBlock:IndestructibleBlock = new IndestructibleBlock(X, Y);
				
				collideableUnits.add(indestructibleBlock);
				playerBulletImpassable.add(indestructibleBlock);
			}
			
			else if (id == 28)
			{
				
			}
			
			else if (id == 29)
			{
				
			}
			
			else if (id == 30)
			{
				var solidBlock:SolidBlock = new SolidBlock(this, textGroup, X / TILE_SIZE, Y / TILE_SIZE);
				solidBlock.x = X;
				solidBlock.y = Y;
				
				immovableObstacles.add(solidBlock);
				gateChains.push(solidBlock);
			}
			
			else if (id == 31)
			{
				
			}
			
			else if (id == 32)
			{
				
			}
			
			else if (id == 33)
			{
				
			}
			
			else if (id == 34)
			{
				
			}
			
			else if (id == 35)
			{
				
			}
			
			else if (id == 36)
			{
				
			}
			
			else if (id == 37)
			{
				var turretnl:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "normal", LEFT);
				turretnl.x = X;
				turretnl.y = Y;
				
				enemies.add(turretnl);
				targets.push(turretnl);
			}
			
			else if (id == 38)
			{
				var turretnr:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "normal", RIGHT);
				turretnr.x = X;
				turretnr.y = Y;
				
				enemies.add(turretnr);
				targets.push(turretnr);
			}
			
			else if (id == 39)
			{
				var turretnc:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "normal", CEILING);
				turretnc.x = X;
				turretnc.y = Y;
				
				enemies.add(turretnc);
				targets.push(turretnc);
			}
			
			else if (id == 40)
			{
				var turretnf:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "normal", FLOOR);
				turretnf.x = X;
				turretnf.y = Y;
				
				enemies.add(turretnf);
				targets.push(turretnf);
			}
			
			else if (id == 41)
			{
				var turrethl:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "homing", LEFT);
				turrethl.x = X;
				turrethl.y = Y;
				
				enemies.add(turrethl);
				targets.push(turrethl);
			}
			
			else if (id == 42)
			{
				var turrethr:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "homing", RIGHT);
				turrethr.x = X;
				turrethr.y = Y;
				
				enemies.add(turrethr);
				targets.push(turrethr);
			}
			
			else if (id == 43)
			{
				var turrethc:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "homing", CEILING);
				turrethc.x = X;
				turrethc.y = Y;
				
				enemies.add(turrethc);
				targets.push(turrethc);
			}
			
			else if (id == 44)
			{
				var turrethf:Turret = new Turret(enemyBullets, player, this, bulletTrails, textGroup, "homing", FLOOR);
				turrethf.x = X;
				turrethf.y = Y;
				
				enemies.add(turrethf);
				targets.push(turrethf);
			}
			
			else if (id == 45)
			{
				var flak:Flak = new Flak(enemyBullets, player, this, bulletTrails, textGroup);
				flak.x = X;
				flak.y = Y;
				
				enemies.add(flak);
				targets.push(flak);
			}
			
			else if (id == 46)
			{
				var flakh:Flak = new Flak(enemyBullets, player, this, bulletTrails, textGroup, "homing");
				flakh.x = X;
				flakh.y = Y;
				
				enemies.add(flakh);
				targets.push(flakh);
			}
			
			else if (id == 47)
			{
				
			}
			
			else if (id == 48)
			{
				
			}
			
			else if (id == 49)
			{
				
			}
			
			else if (id == 50)
			{
				
			}
			
			else if (id == 51)
			{
				
			}
			
			else if (id == 52)
			{
				
			}
			
			else if (id == 53)
			{
				
			}
			
			else if (id == 54)
			{
				
			}
			
			else if (id == 55)
			{
				
			}
			
			else if (id == 56)
			{
				
			}
			
			else if (id == 57)
			{
				
			}
			
			else if (id == 58)
			{
				
			}
			
			else if (id == 59)
			{
				
			}
			
			else if (id == 60)
			{
				
			}
			
			else if (id == 61)
			{
				
			}
			
			else if (id == 62)
			{
				
			}
					
			else if (id == 63)
			{
				var redRobot:RedRobot = new RedRobot(enemyBullets, player, this, bulletTrails, textGroup);
				redRobot.x = X;
				redRobot.y = Y;
						
				enemies.add(redRobot);
				targets.push(redRobot);
			}
			
			else if (id == 63)
			{
				
			}
			
			else if (id == 64)
			{
				
			}
			
			else if (id == 65)
			{
				
			}
			
			else if (id == 66)
			{
				
			}
			
			else if (id == 67)
			{
				
			}
			
			else if (id == 68)
			{
				
			}
			
			else if (id == 69)
			{
				
			}
			
			else if (id == 70)
			{
				
			}
			
			else if (id == 71)
			{
				
			}
			
			else if (id == 72)
			{
				
			}
			
			else if (id == 73)
			{
				
			}
			
			else if (id == 74)
			{
				
			}
			
			else if (id == 75)
			{
				
			}
			
			else if (id == 76)
			{
				
			}
			
			else if (id == 77)
			{
				
			}
			
			else if (id == 78)
			{
				
			}
			
			else if (id == 79)
			{
				
			}
		}
		
	}

}
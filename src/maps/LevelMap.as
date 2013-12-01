package maps 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import items.Fruit;
	import org.flixel.*;
	import units.*;
	import util.*;
	 
	public class LevelMap extends FlxTilemapExt
	{
		public static const TILE_SIZE:int = 16;
		
		public var doors:FlxGroup;
		
		public var blueBoxes:FlxGroup;
		
		//Green boxes and small solid blocks
		public var playerBulletImpassable:FlxGroup;
		
		public var enemyBullets:FlxGroup;
		public var bulletTrails:BulletTrailsContainer;
		private var itemsGroup:FlxGroup
		public var player:Player;
		public var textGroup:FlxGroup;
		
		public var enemies:FlxGroup;
		public var collideableUnits:FlxGroup;
		private var immovableObstacles:FlxGroup;
		private var immovableObstaclesB:FlxGroup;
		public var bulletDamageableObstacles:FlxGroup;
		
		//recycleable flxgroups
		public var oranges:FlxGroup;
		public var apples:FlxGroup;
		public var bananas:FlxGroup;
		public var pineapples:FlxGroup;
		public var watermelons:FlxGroup;
		public var lifeUps:FlxGroup;
		public var blueExplosions:FlxGroup;
		public var smallExplosionAreas:FlxGroup;
		public var mediumExplosionAreas:FlxGroup;
		public var largeExplosionAreas:FlxGroup;
		private var redRobots:FlxGroup;
		private var blueRobots:FlxGroup;
		private var blackRobots:FlxGroup;
		private var yellowRobots:FlxGroup;
		private var nTurrets:FlxGroup;
		private var hTurrets:FlxGroup;
		private var nFlaks:FlxGroup;
		private var hFlaks:FlxGroup;
		private var brownBlocks:FlxGroup;
		private var lifeUpCrates:FlxGroup;
		private var bigBombs:FlxGroup;
		
		private var spriteMap:String;
		
		public var targets:Array;
		
		public function LevelMap(_level:uint = 1) 
		{
			if (_level == 1)  
			{
				this.loadMap(new AssetsRegistry.level_1CSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				spriteMap = new AssetsRegistry.level_1_SpritesCSV;
			}
			
			else if (_level == 2)  
			{
				this.loadMap(new AssetsRegistry.level_2CSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				spriteMap = new AssetsRegistry.level_2_SpritesCSV;
			}
		}
		
		override public function destroy():void
		{	
			redRobots.destroy();
			blueRobots.destroy();
			blackRobots.destroy();
			yellowRobots.destroy();
			nTurrets.destroy();
			hTurrets.destroy();
			nFlaks.destroy();
			hFlaks.destroy();
			brownBlocks.destroy();
			lifeUpCrates.destroy();
			bigBombs.destroy();
			
			super.destroy();
		}
		
		public function InitializeLevel(_bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _player:Player, _enemies:FlxGroup, 
			_enemyBullets:FlxGroup, _items:FlxGroup, _explosions:FlxGroup, _explsionAreas:FlxGroup, _collideableUnits:FlxGroup, 
			_immovableObstacles:FlxGroup, _immovableObstaclesB:FlxGroup,  _bulletDamageableObstacles:FlxGroup):void
		{
			bulletTrails = _bulletTrails;
			player = _player;
			enemyBullets = _enemyBullets;
			textGroup = _textGroup;
			itemsGroup = _items;
			enemies = _enemies;
			collideableUnits = _collideableUnits;
			immovableObstacles = _immovableObstacles;
			immovableObstaclesB = _immovableObstaclesB;
			bulletDamageableObstacles = _bulletDamageableObstacles;
			
			targets = new Array();
			blueBoxes = new FlxGroup();
			playerBulletImpassable = new FlxGroup();
			doors = new FlxGroup();
			
			//recycleable groups//=====
			//items
			oranges = new FlxGroup();
			apples = new FlxGroup();
			bananas = new FlxGroup();
			pineapples = new FlxGroup();
			watermelons = new FlxGroup();
			lifeUps = new FlxGroup();
			redRobots = new FlxGroup();
			blueRobots = new FlxGroup();
			blackRobots = new FlxGroup();
			yellowRobots = new FlxGroup();
			nTurrets = new FlxGroup();
			hTurrets = new FlxGroup();
			nFlaks = new FlxGroup();
			hFlaks = new FlxGroup();
			brownBlocks = new FlxGroup();
			lifeUpCrates = new FlxGroup();
			bigBombs = new FlxGroup();
			
			//explosion animations
			blueExplosions = new FlxGroup();
			//explosion areas
			smallExplosionAreas = new FlxGroup();
			mediumExplosionAreas = new FlxGroup();
			largeExplosionAreas = new FlxGroup();
			//==========================
			
			//aggregate flxgroups
			itemsGroup.add(oranges);
			itemsGroup.add(apples);
			itemsGroup.add(bananas);
			itemsGroup.add(pineapples);
			itemsGroup.add(watermelons);
			itemsGroup.add(lifeUps);
			
			_explosions.add(blueExplosions);
			_explosions.add(smallExplosionAreas);
			_explosions.add(mediumExplosionAreas);
			_explosions.add(largeExplosionAreas);
			
			_explsionAreas.add(smallExplosionAreas);
			_explsionAreas.add(mediumExplosionAreas);
			_explsionAreas.add(largeExplosionAreas);
			
			parseSpriteMap();
			
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
				(lifeUpCrates.recycle(LifeUpCrate) as LifeUpCrate).setPos(X, Y, player, blueExplosions, textGroup, bulletDamageableObstacles, collideableUnits, targets, lifeUps);
			}
			
			else if (id == 3)
			{
				
				var fullLifeCrate:SpecialCrate = new SpecialCrate(player, blueExplosions, textGroup, itemsGroup, "fullLife");
				fullLifeCrate.x = X;
				fullLifeCrate.y = Y;
				
				bulletDamageableObstacles.add(fullLifeCrate);
				collideableUnits.add(fullLifeCrate);
				targets.push(fullLifeCrate);
				
			}
			
			else if (id == 4)
			{
				
				var invinceableCrate:SpecialCrate = new SpecialCrate(player, blueExplosions, textGroup, itemsGroup, "invinceable");
				invinceableCrate.x = X;
				invinceableCrate.y = Y;
				
				bulletDamageableObstacles.add(invinceableCrate);
				collideableUnits.add(invinceableCrate);
				targets.push(invinceableCrate);
				
			}
			
			else if (id == 5)
			{
				(oranges.recycle(Fruit) as Fruit).setPos(X, Y, player, textGroup, "orange");
			}
			
			else if (id == 6)
			{
				(apples.recycle(Fruit) as Fruit).setPos(X, Y, player, textGroup, "apple");
			}
			
			else if (id == 7)
			{
				(bananas.recycle(Fruit) as Fruit).setPos(X, Y, player, textGroup, "banana");
			}
			
			else if (id == 8)
			{
				(pineapples.recycle(Fruit) as Fruit).setPos(X, Y, player, textGroup, "pineapple");
			}
			
			else if (id == 9)
			{
				(watermelons.recycle(Fruit) as Fruit).setPos(X, Y, player, textGroup, "watermelon");
			}
			
			else if (id == 10)
			{
				var blueDiamond:BlueDiamond = new BlueDiamond(player, textGroup);
				blueDiamond.x = X;
				blueDiamond.y = Y;
				
				immovableObstacles.add(blueDiamond);
				immovableObstaclesB.add(blueDiamond);
			}
			
			else if (id == 11)
			{
				var greenBall:Ball = new Ball(player, blueExplosions, textGroup, "green");
				greenBall.x = X;
				greenBall.y = Y;
				
				immovableObstacles.add(greenBall);
				immovableObstaclesB.add(greenBall);
			}
			
			else if (id == 12)
			{
				var purpleBall:Ball = new Ball(player,  blueExplosions, textGroup, "purple");
				purpleBall.x = X;
				purpleBall.y = Y;
				
				immovableObstacles.add(purpleBall);
				immovableObstaclesB.add(purpleBall);
			}
			
			else if (id == 13)
			{
				var smallBomb:SmallBomb = new SmallBomb(player, smallExplosionAreas, textGroup);
				smallBomb.x = X;
				smallBomb.y = Y;
				
				immovableObstacles.add(smallBomb);
				immovableObstaclesB.add(smallBomb);
			}
			
			else if (id == 14)
			{
				var smallPowerBomb:SmallPowerBomb = new SmallPowerBomb(player, largeExplosionAreas, textGroup);
				smallPowerBomb.x = X;
				smallPowerBomb.y = Y;
				
				immovableObstacles.add(smallPowerBomb);
				immovableObstaclesB.add(smallPowerBomb);
			}
			
			else if (id == 15)
			{
				(bigBombs.recycle(BigBomb) as BigBomb).setPos(X, Y, player, mediumExplosionAreas, textGroup, oranges, collideableUnits, bulletDamageableObstacles, targets);
			}
			
			else if (id == 16)
			{
				
			}
			
			else if (id == 17)
			{
				
			}
			
			else if (id == 18)
			{
				(brownBlocks.recycle(BrownBlock) as BrownBlock).setPos(X, Y, player, blueExplosions, textGroup, oranges, collideableUnits, bulletDamageableObstacles, targets);
			}
			
			else if (id == 19)
			{
				var buildingh:Building = new Building(player, blueExplosions, "house", textGroup, oranges, bananas, pineapples, watermelons);
				buildingh.x = X;
				buildingh.y = Y;
				
				immovableObstacles.add(buildingh);
				immovableObstaclesB.add(buildingh);
				targets.push(buildingh);
			}
			
			else if (id == 20)
			{
				var buildingw:Building = new Building(player,  blueExplosions, "wideBuilding", textGroup, oranges, bananas, pineapples, watermelons);
				buildingw.x = X;
				buildingw.y = Y;
				
				immovableObstacles.add(buildingw);
				immovableObstaclesB.add(buildingw);
				targets.push(buildingw);
			}
			
			else if (id == 21)
			{
				var buildingt:Building = new Building(player, blueExplosions, "tallBuilding", textGroup, oranges, bananas, pineapples, watermelons);
				buildingt.x = X;
				buildingt.y = Y;
				
				immovableObstacles.add(buildingt);
				immovableObstaclesB.add(buildingt);
				targets.push(buildingt);
			}
			
			else if (id == 22)
			{
				var buildingc:Building = new Building(player, blueExplosions, "car", textGroup, oranges, bananas, pineapples, watermelons);
				buildingc.x = X;
				buildingc.y = Y;
				
				immovableObstacles.add(buildingc);
				immovableObstaclesB.add(buildingc);
				targets.push(buildingc);
			}
			
			else if (id == 23)
			{
				var buildinghd:Building = new Building(player, blueExplosions, "house", textGroup, oranges, bananas, pineapples, watermelons, DOWN);
				buildinghd.x = X;
				buildinghd.y = Y;
				
				immovableObstacles.add(buildinghd);
				immovableObstaclesB.add(buildinghd);
				targets.push(buildinghd);
			}
			
			else if (id == 24)
			{
				var buildingwd:Building = new Building(player, blueExplosions, "wideBuilding", textGroup, oranges, bananas, pineapples, watermelons, DOWN);
				buildingwd.x = X;
				buildingwd.y = Y;
				
				immovableObstacles.add(buildingwd);
				immovableObstaclesB.add(buildingwd);
				targets.push(buildingwd);
			}
			
			else if (id == 25)
			{
				var buildingtd:Building = new Building(player, blueExplosions, "tallBuilding", textGroup, oranges, bananas, pineapples, watermelons, DOWN);
				buildingtd.x = X;
				buildingtd.y = Y;
				
				immovableObstacles.add(buildingtd);
				immovableObstaclesB.add(buildingtd);
				targets.push(buildingtd);
			}
			
			else if (id == 26)
			{
				var buildingcd:Building = new Building(player, blueExplosions, "car", textGroup, oranges, bananas, pineapples, watermelons, DOWN);
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
				bulletDamageableObstacles.add(indestructibleBlock);
			}
			
			else if (id == 28)
			{
				var blueBox:Box = new Box(player, textGroup, "blue");
				blueBox.x = X;
				blueBox.y = Y;
				
				immovableObstacles.add(blueBox);
				blueBoxes.add(blueBox);
			}
			
			else if (id == 29)
			{
				var greenBox:Box = new Box(player, textGroup, "green");
				greenBox.x = X;
				greenBox.y = Y;
				
				immovableObstacles.add(greenBox);
				playerBulletImpassable.add(greenBox);
			}
			
			else if (id == 30)
			{
				var solidBlock:SolidBlock = new SolidBlock(this, player, blueExplosions, textGroup, X / TILE_SIZE, Y / TILE_SIZE);
				solidBlock.x = X;
				solidBlock.y = Y;
				
				immovableObstacles.add(solidBlock);
			}
			
			else if (id == 31)
			{
				var doorRl:RedDoor = new RedDoor(X, Y, this, player, LEFT);
				doors.add(doorRl);
			}
			
			else if (id == 32)
			{
				var doorRr:RedDoor = new RedDoor(X, Y, this, player, RIGHT);
				doors.add(doorRr);
			}
			
			else if (id == 33)
			{
				var doorRc:RedDoor = new RedDoor(X, Y, this, player, CEILING);
				doors.add(doorRc);
			}
			
			else if (id == 34)
			{
				var doorRf:RedDoor = new RedDoor(X, Y, this, player, FLOOR);
				doors.add(doorRf);
			}
			
			
			else if (id == 35)
			{
				var doorBv:BlueDoor = new BlueDoor(X, Y, this, "vert");
				doors.add(doorBv);
			}
			
			else if (id == 36)
			{	
				var doorBh:BlueDoor = new BlueDoor(X, Y, this, "hori");
				doors.add(doorBh);
			}
			
			else if (id == 37)
			{
				var turretnl:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "normal", LEFT);
				turretnl.x = X;
				turretnl.y = Y;
				
				enemies.add(turretnl);
				targets.push(turretnl);
			}
			
			else if (id == 38)
			{
				var turretnr:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "normal", RIGHT);
				turretnr.x = X;
				turretnr.y = Y;
				
				enemies.add(turretnr);
				targets.push(turretnr);
			}
			
			else if (id == 39)
			{
				var turretnc:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "normal", CEILING);
				turretnc.x = X;
				turretnc.y = Y;
				
				enemies.add(turretnc);
				targets.push(turretnc);
			}
			
			else if (id == 40)
			{
				var turretnf:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "normal", FLOOR);
				turretnf.x = X;
				turretnf.y = Y;
				
				enemies.add(turretnf);
				targets.push(turretnf);
			}
			
			else if (id == 41)
			{
				var turrethl:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "homing", LEFT);
				turrethl.x = X;
				turrethl.y = Y;
				
				enemies.add(turrethl);
				targets.push(turrethl);
			}
			
			else if (id == 42)
			{
				var turrethr:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "homing", RIGHT);
				turrethr.x = X;
				turrethr.y = Y;
				
				enemies.add(turrethr);
				targets.push(turrethr);
			}
			
			else if (id == 43)
			{
				var turrethc:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "homing", CEILING);
				turrethc.x = X;
				turrethc.y = Y;
				
				enemies.add(turrethc);
				targets.push(turrethc);
			}
			
			else if (id == 44)
			{
				var turrethf:Turret = new Turret(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, "homing", FLOOR);
				turrethf.x = X;
				turrethf.y = Y;
				
				enemies.add(turrethf);
				targets.push(turrethf);
			}
			
			else if (id == 45)
			{
				var flak:Flak = new Flak(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, "normal", pineapples);
				flak.x = X;
				flak.y = Y;
				
				enemies.add(flak);
				targets.push(flak);
			}
			
			else if (id == 46)
			{
				var flakh:Flak = new Flak(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, "homing", pineapples);
				flakh.x = X;
				flakh.y = Y;
				
				enemies.add(flakh);
				targets.push(flakh);
			}
			
			else if (id == 47)
			{
				var lasercl:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, CEIL_LEFT);
				lasercl.x = X;
				lasercl.y = Y;
				
				enemies.add(lasercl);
			}
			
			else if (id == 48)
			{
				var lasercr:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, CEIL_RIGHT);
				lasercr.x = X;
				lasercr.y = Y;
				
				enemies.add(lasercr);
			}
			
			else if (id == 49)
			{
				var laserfl:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, FLOOR_LEFT);
				laserfl.x = X;
				laserfl.y = Y;
				
				enemies.add(laserfl);
			}
			
			else if (id == 50)
			{
				var laserfr:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples,  FLOOR_RIGHT);
				laserfr.x = X;
				laserfr.y = Y;
				
				enemies.add(laserfr);
			}
			
			else if (id == 51)
			{
				var laserl:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, LEFT);
				laserl.x = X;
				laserl.y = Y;
				
				enemies.add(laserl);
			}
			
			else if (id == 52)
			{
				var laserr:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, RIGHT);
				laserr.x = X;
				laserr.y = Y;
				
				enemies.add(laserr);
			}
			
			else if (id == 53)
			{
				var laserc:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, CEILING);
				laserc.x = X;
				laserc.y = Y;
				
				enemies.add(laserc);
			}
			
			else if (id == 54)
			{
				var laserf:Laser = new Laser(enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, FLOOR);
				laserf.x = X;
				laserf.y = Y;
				
				enemies.add(laserl);
			}
			
			else if (id == 55)
			{
				var gen:Generator = new Generator(X, Y, this, CEILING, "RedRobot", redRobots, "normal");
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
			
			else if (id == 80)
			{
				
			}
			
			else if (id == 81)
			{
				
			}
			
			else if (id == 82)
			{
				
			}
			
			else if (id == 83)
			{
				
			}
			
			else if (id == 84)
			{
				
			}
			
			else if (id == 85)
			{
				
			}
			
			else if (id == 86)
			{
				
			}
			
			else if (id == 87)
			{
				
			}
			
			else if (id == 88)
			{
				
			}
			
			else if (id == 89)
			{
				
			}
			
			else if (id == 90)
			{
				
			}
			
			else if (id == 91)
			{
			
			}
			
			else if (id == 92)
			{
				
			}
			
			else if (id == 93)
			{
				
			}
			
			else if (id == 94)
			{
				
			}
			
			else if (id == 95)
			{
				
			}
			
			else if (id == 96)
			{
				
			}
			
			else if (id == 97)
			{
				
			}
			
			else if (id == 98)
			{
				
			}
			
			else if (id == 99)
			{
				
			}
			
			else if (id == 100)
			{
				
			}
			
			else if (id == 101)
			{
				
			}
			
			else if (id == 102)
			{
				
			}
			
			else if (id == 103)
			{
				(redRobots.recycle(RedRobot) as RedRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal");
			}
			
			else if (id == 104)
			{
				(blueRobots.recycle(BlueRobot) as BlueRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 105)
			{
				(blackRobots.recycle(BlackRobot) as BlackRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 106)
			{
				(blueRobots.recycle(YellowRobot) as YellowRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 107)
			{
				
			}
			
			else if (id == 108)
			{
				
			}
			
			else if (id == 109)
			{
				
			}
			
			else if (id == 110)
			{
				
			}
			
			else if (id == 111)
			{
				
			}
			
			else if (id == 112)
			{
				
			}
			
			else if (id == 113)
			{
				
			}
			
			else if (id == 114)
			{
				
			}
			
			else if (id == 115)
			{
				
			}
			
			else if (id == 116)
			{
				
			}
			
			else if (id == 117)
			{
				
			}
			
			else if (id == 118)
			{
				
			}
			
			else if (id == 119)
			{
				
			}
			
			else
			{
				throw new Error("unit ID is out of range");
			}
		}
		
	}

}
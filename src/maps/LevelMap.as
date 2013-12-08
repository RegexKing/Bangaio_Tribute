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
		public static const TILE_SIZE:int = 15;
		
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
		public var indestructibleBlocks:FlxGroup;
		
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
				this.loadMap(new AssetsRegistry.level_1CSV, AssetsRegistry.tilesPNG, 15, 15, OFF, 0, 1, 2);
				spriteMap = new AssetsRegistry.level_1_SpritesCSV;
			}
			
			else if (_level == 2)  
			{
				this.loadMap(new AssetsRegistry.level_2CSV, AssetsRegistry.tilesPNG, 15, 15, OFF, 0, 1, 2);
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
			indestructibleBlocks.destroy();
			
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
			indestructibleBlocks = new FlxGroup();
			
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
				indestructibleBlocks.add(indestructibleBlock);
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
				(nTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal", LEFT);
			}
			
			else if (id == 38)
			{
				(nTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal", RIGHT);
			}
			
			else if (id == 39)
			{
				(nTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal", CEILING);
			}
			
			else if (id == 40)
			{
				(nTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal", FLOOR);
			}
			
			else if (id == 41)
			{
				(hTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "homing", LEFT);
			}
			
			else if (id == 42)
			{
				(hTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "homing", RIGHT);
			}
			
			else if (id == 43)
			{
				(hTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "homing", CEILING);
			}
			
			else if (id == 44)
			{
				(hTurrets.recycle(Turret) as Turret).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "homing", FLOOR);
			}
			
			else if (id == 45)
			{
				(nFlaks.recycle(Flak) as Flak).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, "normal", pineapples, enemies, targets);
			}
			
			else if (id == 46)
			{
				(hFlaks.recycle(Flak) as Flak).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, "homing", pineapples, enemies, targets);
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
				var gen_redRobot_L:Generator = new Generator(X, Y, this, LEFT, "RedRobot", redRobots, "normal");
			}
			
			else if (id == 56)
			{
				var gen_redRobot_R:Generator = new Generator(X, Y, this, RIGHT, "RedRobot", redRobots, "normal");
			}
			
			else if (id == 57)
			{
				var gen_redRobot_C:Generator = new Generator(X, Y, this, CEILING, "RedRobot", redRobots, "normal");
			}
			
			else if (id == 58)
			{
				var gen_redRobot_F:Generator = new Generator(X, Y, this, FLOOR, "RedRobot", redRobots, "normal");
			}
			
			else if (id == 59)
			{
				var gen_blueRobot_L:Generator = new Generator(X, Y, this, LEFT, "BlueRobot", blueRobots, "normal");
			}
			
			else if (id == 60)
			{
				var gen_blueRobot_R:Generator = new Generator(X, Y, this, RIGHT, "BlueRobot", blueRobots, "normal");
			}
			
			else if (id == 61)
			{
				var gen_blueRobot_C:Generator = new Generator(X, Y, this, CEILING, "BlueRobot", blueRobots, "normal");
			}
			
			else if (id == 62)
			{
				var gen_blueRobot_F:Generator = new Generator(X, Y, this, FLOOR, "BlueRobot", blueRobots, "normal");
			}
					
			else if (id == 63)
			{
				var gen_blackRobot_L:Generator = new Generator(X, Y, this, LEFT, "BlackRobot", blackRobots, "normal");
			}
			
			else if (id == 64)
			{
				var gen_blackRobot_R:Generator = new Generator(X, Y, this, RIGHT, "BlackRobot", blackRobots, "normal");
			}
			
			else if (id == 65)
			{
				var gen_blackRobot_C:Generator = new Generator(X, Y, this, CEILING, "BlackRobot", blackRobots, "normal");
			}
			
			else if (id == 66)
			{
				var gen_blackRobot_F:Generator = new Generator(X, Y, this, FLOOR, "BlackRobot", blackRobots, "normal");
			}
			
			else if (id == 67)
			{
				var gen_yellowRobot_L:Generator = new Generator(X, Y, this, LEFT, "YellowRobot", yellowRobots, "normal");
			}
			
			else if (id == 68)
			{
				var gen_yellowRobot_R:Generator = new Generator(X, Y, this, RIGHT, "YellowRobot", yellowRobots, "normal");
			}
			
			else if (id == 69)
			{
				var gen_yellowRobot_C:Generator = new Generator(X, Y, this, CEILING, "YellowRobot", yellowRobots, "normal");
			}
			
			else if (id == 70)
			{
				var gen_yellowRobot_F:Generator = new Generator(X, Y, this, FLOOR, "YellowRobot", yellowRobots, "normal");
			}
			
			else if (id == 71)
			{
				var gen_brownBlock_L:Generator = new Generator(X, Y, this, LEFT, "BrownBlock", brownBlocks);
			}
			
			else if (id == 72)
			{
				var gen_brownBlock_R:Generator = new Generator(X, Y, this, RIGHT, "BrownBlock", brownBlocks);
			}
			
			else if (id == 73)
			{
				var gen_brownBlock_C:Generator = new Generator(X, Y, this, CEILING, "BrownBlock", brownBlocks);
			}
			
			else if (id == 74)
			{
				var gen_brownBlock_F:Generator = new Generator(X, Y, this, FLOOR, "BrownBlock", brownBlocks);
			}
			
			else if (id == 75)
			{
				var gen_bomb_L:Generator = new Generator(X, Y, this, LEFT, "BigBomb", bigBombs);
			}
			
			else if (id == 76)
			{
				var gen_bomb_R:Generator = new Generator(X, Y, this, RIGHT, "BigBomb", bigBombs);
			}
			
			else if (id == 77)
			{
				var gen_bomb_C:Generator = new Generator(X, Y, this, CEILING, "BigBomb", bigBombs);
			}
			
			else if (id == 78)
			{
				var gen_bomb_F:Generator = new Generator(X, Y, this, FLOOR, "BigBomb", bigBombs);
			}
			
			else if (id == 79)
			{
				var gen_crate_L:Generator = new Generator(X, Y, this, LEFT, "LifeUpCrate", lifeUpCrates);
			}
			
			else if (id == 80)
			{
				var gen_crate_R:Generator = new Generator(X, Y, this, RIGHT, "LifeUpCrate", lifeUpCrates);
			}
			
			else if (id == 81)
			{
				var gen_crate_C:Generator = new Generator(X, Y, this, CEILING, "LifeUpCrate", lifeUpCrates);
			}
			
			else if (id == 82)
			{
				var gen_crate_F:Generator = new Generator(X, Y, this, FLOOR, "LifeUpCrate", lifeUpCrates);
			}
			
			else if (id == 83)
			{
				var gen_nTurret_L:Generator = new Generator(X, Y, this, LEFT, "N_Turret", nTurrets, "normal");
			}
			
			else if (id == 84)
			{
				var gen_nTurret_R:Generator = new Generator(X, Y, this, RIGHT, "N_Turret", nTurrets, "normal");
			}
			
			else if (id == 85)
			{
				var gen_nTurret_C:Generator = new Generator(X, Y, this, CEILING, "N_Turret", nTurrets, "normal");
			}
			
			else if (id == 86)
			{
				var gen_nTurret_F:Generator = new Generator(X, Y, this, FLOOR, "N_Turret", nTurrets, "normal");
			}
			
			else if (id == 87)
			{
				var gen_hTurret_L:Generator = new Generator(X, Y, this, LEFT, "H_Turret", hTurrets, "homing");
			}
			
			else if (id == 88)
			{
				var gen_hTurret_R:Generator = new Generator(X, Y, this, RIGHT, "H_Turret", hTurrets, "homing");
			}
			
			else if (id == 89)
			{
				var gen_hTurret_C:Generator = new Generator(X, Y, this, CEILING, "H_Turret", hTurrets, "homing");
			}
			
			else if (id == 90)
			{
				var gen_hTurret_F:Generator = new Generator(X, Y, this, FLOOR, "H_Turret", hTurrets, "homing");
			}
			
			else if (id == 91)
			{
				var gen_nFlak_L:Generator = new Generator(X, Y, this, LEFT, "N_Flak", nFlaks, "normal");
			}
			
			else if (id == 92)
			{
				var gen_nFlak_R:Generator = new Generator(X, Y, this, RIGHT, "N_Flak", nFlaks, "normal");
			}
			
			else if (id == 93)
			{
				var gen_nFlak_C:Generator = new Generator(X, Y, this, CEILING, "N_Flak", nFlaks, "normal");
			}
			
			else if (id == 94)
			{
				var gen_nFlak_F:Generator = new Generator(X, Y, this, FLOOR, "N_Flak", nFlaks, "normal");
			}
			
			else if (id == 95)
			{
				var gen_hFlak_L:Generator = new Generator(X, Y, this, LEFT, "H_Flak", hFlaks, "homing");
			}
			
			else if (id == 96)
			{
				var gen_hFlak_R:Generator = new Generator(X, Y, this, RIGHT, "H_Flak", hFlaks, "homing");
			}
			
			else if (id == 97)
			{
				var gen_hFlak_C:Generator = new Generator(X, Y, this, CEILING, "H_Flak", hFlaks, "homing");
			}
			
			else if (id == 98)
			{
				var gen_hFlak_F:Generator = new Generator(X, Y, this, FLOOR, "H_Flak", hFlaks, "homing");
			}
			
			else if (id == 99)
			{
				(redRobots.recycle(RedRobot) as RedRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, apples, enemies, targets, "normal");
			}
			
			else if (id == 100)
			{
				(blueRobots.recycle(BlueRobot) as BlueRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 101)
			{
				(blackRobots.recycle(BlackRobot) as BlackRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 102)
			{
				(yellowRobots.recycle(YellowRobot) as YellowRobot).setPos(X, Y, enemyBullets, player, blueExplosions, this, bulletTrails, textGroup, bananas, enemies, targets, "normal");
			}
			
			else if (id == 103)
			{
				
			}
			
			else if (id == 104)
			{
				
			}
			
			else if (id == 105)
			{
				
			}
			
			else if (id == 106)
			{
				
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
			
			else
			{
				throw new Error("unit ID is out of range");
			}
		}
		
	}

}
package units 
{
	import hud.CountdownTimer;
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Generator extends Targetable
	{
		
		private var map:LevelMap;
		private var orientation:uint;
		private var unitType:String;
		private var bulletType:String;
		private var recycleGroup:FlxGroup;
		private var sensor:FlxObject;
		
		//timer vars
		private var spawnRate:Number = 2000;
		private var nextSpawn:Number = 0;
		
		public function Generator(X:int, Y:int, _map:LevelMap, _orientation:uint, _unitType:String, _recycleGroup:FlxGroup, _bulletType:String = null) 
		{
			map = _map;
			orientation = _orientation;
			unitType = _unitType;
			bulletType = _bulletType;
			recycleGroup = _recycleGroup;
			
			super(map.player, map.textGroup, map.blueExplosions);
			immovable = true;
			
			health = 160;
			points = 800;
			
			this.x = X;
			this.y = Y;
			
			sensor = new FlxObject(0, 0, 48, 48);
			
			
			if (orientation == FLOOR)
			{	
				loadGraphic(AssetsRegistry.generatorPNG);
				
				sensor.x = this.x;
				sensor.y = this.y - sensor.height;
			}
			
			else if (orientation == CEILING)
			{
				loadGraphic(AssetsRegistry.generatorPNG);
				
				angle = 180;
				
				sensor.x = this.x;
				sensor.y = this.y + this.height;
			}
			
			else if (orientation == LEFT)
			{
				
				loadGraphic(AssetsRegistry.generatorSidePNG, false, true);
				
				facing = LEFT;
				
				sensor.x = this.x - sensor.width;
				sensor.y = this.y;
			}
			
			else
			{
				loadGraphic(AssetsRegistry.generatorSidePNG);
				
				sensor.x = this.x + this.width;
				sensor.y = this.y;
			}
			
			map.enemies.add(this);
			map.targets.push(this);
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.onScreen() && (CountdownTimer.getTimer() > nextSpawn))
			{
				nextSpawn = CountdownTimer.getTimer() + spawnRate;
				
				spawn();
			}
			
		}
		
		private function spawn():void
		{
			for each (var unit:FlxSprite in map.targets)
			{
				if (unit.alive && unit.overlaps(sensor))
				{
					return;
				}
			}
			
			if (player.overlaps(sensor))
			{
				return
			}
			
			
			var pulledSprite:FlxBasic;
			
			if (unitType == "RedRobot")
			{
				pulledSprite = recycleGroup.recycle(RedRobot);
			
				(pulledSprite as RedRobot).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.apples, map.enemies, map.targets, bulletType);
			}
			
			else if (unitType == "BlueRobot")
			{
				pulledSprite = recycleGroup.recycle(BlueRobot);
			
				(pulledSprite as BlueRobot).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.bananas, map.enemies, map.targets, bulletType);
			}
			
			else if (unitType == "BlackRobot")
			{
				pulledSprite = recycleGroup.recycle(BlackRobot);
			
				(pulledSprite as BlackRobot).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.apples, map.enemies, map.targets, bulletType);
			}
			
			else if (unitType == "YellowRobot")
			{
				pulledSprite = recycleGroup.recycle(YellowRobot);
			
				(pulledSprite as YellowRobot).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.bananas, map.enemies, map.targets, bulletType);
			}
			
			else if (unitType == "N_Turret")
			{
				pulledSprite = recycleGroup.recycle(Turret);
				
				(pulledSprite as Turret).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.apples, map.enemies, map.targets, "normal", orientation);
			}
			
			else if (unitType == "H_Turret")
			{
				pulledSprite = recycleGroup.recycle(Turret);
				
				(pulledSprite as Turret).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.apples, map.enemies, map.targets, "homing", orientation);
			}
			
			else if (unitType == "N_Flak")
			{
				pulledSprite = recycleGroup.recycle(Flak);
				
				(pulledSprite as Flak).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, bulletType, map.pineapples, map.enemies, map.targets);
			}
			
			else if (unitType == "H_Flak")
			{
				pulledSprite = recycleGroup.recycle(Flak);
				
				(pulledSprite as Flak).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, bulletType, map.pineapples, map.enemies, map.targets);
			}
			
			else if (unitType == "BrownBlock")
			{
				pulledSprite = recycleGroup.recycle(BrownBlock);
				
				(pulledSprite as BrownBlock).setPos(sensor.x, sensor.y, map.player, map.blueExplosions, map.textGroup, map.oranges, map.collideableUnits, map.bulletDamageableObstacles, map.targets);
			}
			
			else if (unitType == "BigBomb")
			{
				pulledSprite = recycleGroup.recycle(BigBomb);
				
				(pulledSprite as BigBomb).setPos(sensor.x, sensor.y, map.player, map.mediumExplosionAreas, map.textGroup, map.oranges, map.collideableUnits, map.bulletDamageableObstacles, map.targets);
			}
			
			else if (unitType == "LifeUpCrate")
			{
				pulledSprite = recycleGroup.recycle(LifeUpCrate);
				
				(pulledSprite as LifeUpCrate).setPos(sensor.x, sensor.y, map.player, map.blueExplosions, map.textGroup, map.bulletDamageableObstacles, map.collideableUnits, map.targets, map.lifeUps);
			}
			
			if (orientation == FLOOR)
			{
				(pulledSprite as FlxObject).x = sensor.getMidpoint().x - ((pulledSprite as FlxObject).width / 2);
				(pulledSprite as FlxObject).y += this.y - ((pulledSprite as FlxObject).y + (pulledSprite as FlxObject).height);
			}
			
			else if (orientation == CEILING)
			{
				(pulledSprite as FlxObject).x = sensor.getMidpoint().x - ((pulledSprite as FlxObject).width / 2);
			}
			
			else if (orientation == LEFT)
			{
				(pulledSprite as FlxObject).y = sensor.getMidpoint().y - ((pulledSprite as FlxObject).height / 2);
				(pulledSprite as FlxObject).x += this.x - ((pulledSprite as FlxObject).x + (pulledSprite as FlxObject).width);
			}
			
			else
			{
				(pulledSprite as FlxObject).y = sensor.getMidpoint().y - ((pulledSprite as FlxObject).height / 2);
			}
			
			pulledSprite = null;
		}
		
		override public function kill():void
		{
			super.kill();
			
			(map.bananas.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), map.player, map.textGroup, "banana");
			
			sensor.kill();
		}
		
		override public function destroy():void
		{
			sensor.destroy();
			
			super.destroy();
		}
		
	}

}
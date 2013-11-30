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
		private var lastSpawn:Number = 0;
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
			
			sensor = new FlxObject(0, 0, 64, 64);
			
			if (orientation == FLOOR || orientation == CEILING)
			{
				makeGraphic(64, 16);
				
				sensor.x = this.x;
				sensor.y = this.y + this.height;
			}
			
			map.collideableUnits.add(this);
			map.bulletDamageableObstacles.add(this);
			map.targets.push(this);
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.onScreen() && (CountdownTimer.getTimer() > nextSpawn))
			{
				lastSpawn = CountdownTimer.getTimer();
				nextSpawn = CountdownTimer.getTimer() + spawnRate;
				
				spawn();
			}
			
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			
		}
		
		override public function postUpdate():void 
		{
			super.postUpdate();
			
			
		}
		
		private function spawn():void
		{
			for each (var unit:FlxSprite in map.targets)
			{
				if (unit.alive && unit.overlaps(sensor))
				{
					FlxG.log(this);
					
					return;
				}
			}
			
			if (player.overlaps(sensor))
			{
				return
			}
			
			
			if (unitType == "RedRobot")
			{
			
				(recycleGroup.recycle(RedRobot) as RedRobot).setPos(sensor.x, sensor.y, map.enemyBullets, map.player, map.blueExplosions, map, map.bulletTrails, map.textGroup, map.apples, map.enemies, map.targets, bulletType);
			}
			
			else if (unitType == "BrownBlock")
			{
				(recycleGroup.recycle(BrownBlock) as BrownBlock).setPos(sensor.x, sensor.y, map.player, map.blueExplosions, map.textGroup, map.oranges, map.collideableUnits, map.bulletDamageableObstacles, map.targets);
			}
			
			else if (unitType == "BigBomb")
			{
				(recycleGroup.recycle(BigBomb) as BigBomb).setPos(sensor.x, sensor.y, map.player, map.mediumExplosionAreas, map.textGroup, map.oranges, map.collideableUnits, map.bulletDamageableObstacles, map.targets);
			}
			
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
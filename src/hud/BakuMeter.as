package hud 
{
	import items.LifeUp;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BakuMeter extends FlxGroup
	{
		
		private var map:LevelMap;
		private var smallRedExplosions:FlxGroup;
		private var explosionAreas:FlxGroup;
		
		private var explosionCounter:FlxText;
		
		//how many explosion is takes to recieve a prize
		public const PRIZE_INTERVAL:int = 100;
		
		public var break100:Boolean = false;
		public var break200:Boolean = false;
		public var break300:Boolean = false;
		public var break400:Boolean = false;
		public var break500:Boolean = false;
		
		public function BakuMeter(_map:LevelMap, _smallRedExplosions:FlxGroup, _explosionAreas:FlxGroup) 
		{
			super(2);
			
			map = _map;
			smallRedExplosions = _smallRedExplosions;
			explosionAreas = _explosionAreas;
			
			explosionCounter = new FlxText(0, 0, 150);
			explosionCounter.setFormat(null, 16, 0xffFFFFFF, "center");
			explosionCounter.x = FlxG.width / 2 - explosionCounter.width / 2;
			explosionCounter.y = explosionCounter.height*2;
			explosionCounter.scrollFactor.x = explosionCounter.scrollFactor.y = 0;
			
			add(explosionCounter);
		}
		
		override public function update():void
		{
			super.update();
			
			var explosionNum:int = 0;
			
			explosionNum += smallRedExplosions.countExplosions(this);
			
			for each (var group:FlxGroup in explosionAreas)
			{
				explosionNum += group.countExplosions(this, explosionNum);
			}
			
			if (explosionNum <= 0)
			{
				explosionNum = 0;
				
				break100 = false;
				break200 = false;
				break300 = false;
				break400 = false;
				break500 = false;
			}
			
			explosionCounter.text = String(explosionNum);
			if (explosionNum < 100)
			{
				explosionCounter.size = 16;
				explosionCounter.color = 0xffFFFFFF;
			}
			
			else
			{
				explosionCounter.size = 22;
				explosionCounter.color = 0xffFF0000;
			}
			
			if (explosionNum > GameData.highestExplosion) GameData.highestExplosion = explosionNum;
		}
		
		public function spawnLife(X:int, Y:int):void
		{
			(map.lifeUps.recycle(LifeUp) as LifeUp).setPos(X, Y);
		}
		
		public function activateInvinceable():void
		{
			map.player.activateInvince();
		}
		
	}

}
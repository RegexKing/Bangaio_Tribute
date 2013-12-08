package hud 
{
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
		
		public function BakuMeter(_map:LevelMap, _smallRedExplosions:FlxGroup, _explosionAreas:FlxGroup) 
		{
			super(2);
			
			map = _map;
			smallRedExplosions = _smallRedExplosions;
			explosionAreas = _explosionAreas;
			
			explosionCounter = new FlxText(0, 0, 150);
			explosionCounter.setFormat(null, 16, 0xffFFFFFF, "center");
			explosionCounter.x = FlxG.width / 2 - explosionCounter.width / 2;
			explosionCounter.y = FlxG.height - explosionCounter.height*2;
			explosionCounter.scrollFactor.x = explosionCounter.scrollFactor.y = 0;
			
			add(explosionCounter);
		}
		
		override public function update():void
		{
			super.update();
			
			var explosionNum:int = 0;
			
			explosionNum += smallRedExplosions.countOnScreen();
			
			for each (var group:FlxGroup in explosionAreas)
			{
				explosionNum += group.countOnScreen();
			}
			
			if (explosionNum < 0) explosionNum = 0;
			
			explosionCounter.text = String(explosionNum);
		}
		
	}

}
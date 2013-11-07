package units 
{
	import maps.LevelMap;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SolidGate extends FlxSprite implements Gate
	{
		
		private var map:LevelMap;
		private var index:FlxPoint;
		
		public function SolidGate(_map:LevelMap, _index:FlxPoint) 
		{
			map = _map;
			index = _index;
			
			health = 10;
			
			makeGraphic(16, 16);
			
			//TODO, set to invisible, collideable tile
			map.setTile(index.x, index.y, 6);
		}
		
		public function activateGate():void
		{
			kill();
			
			map.setTile(index.x, index.y, 0);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			index = null;
		}
		
	}

}
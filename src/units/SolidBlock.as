package units 
{
	import maps.LevelMap;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SolidBlock extends Scoreable implements GateChain
	{
		
		private var map:LevelMap;
		private var xMapCoord:int = 0;
		private var yMapCoord:int = 0;
		
		public function SolidBlock(_map:LevelMap, _textGroup:FlxGroup, xCoord:int, yCoord:int) 
		{
			super(_textGroup);
			
			immovable = true;
			
			map = _map;
			
			xMapCoord = xCoord;
			yMapCoord = yCoord;
			
			health = 10;
			points = 10;
			
			makeGraphic(16, 16, 0xff666666);
			
			//TODO, set to invisible, collideable tile
			map.setTile(xCoord, yCoord, 6);
		}
		
		public function activateGate():void
		{
			kill();
			
			map.setTile(xMapCoord, yMapCoord, 0);
		}
		
	}

}
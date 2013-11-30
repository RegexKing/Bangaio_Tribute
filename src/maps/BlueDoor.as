package maps 
{
	import org.flixel.*;
	import units.Player;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BlueDoor extends FlxSprite
	{
		private var map:LevelMap;
		private var orientation:String;
		private var gates:Vector.<FlxPoint>;
		
		public function BlueDoor(X:int, Y:int, _map:LevelMap, _orientation:String) 
		{
			super(X, Y);
			
			immovable = true;
			
			map = _map;
			orientation = _orientation;
			
			gates = new Vector.<FlxPoint>();
			
			if (orientation == "vert")
			{
				loadGraphic(AssetsRegistry.redDoorVertPNG, true, false, 32, 128);
			}
			else
			{
				loadGraphic(AssetsRegistry.redDoorHoriPNG, true, false, 128, 32);
			}
			
			addAnimation("close", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 60, false);
			addAnimation("open", [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 60, false);
			addAnimation("closeInit", [9], 0, false);
			
			if (orientation == "vert")
			{
				
				for (var i:int = 0; i < this.height/LevelMap.TILE_SIZE; i++)
				{
					gates.push(new FlxPoint((this.x / LevelMap.TILE_SIZE) + 1, (this.y / LevelMap.TILE_SIZE) + i));
				}
				
				for (var j:int = 0; j < this.height/LevelMap.TILE_SIZE; j++)
				{
					gates.push(new FlxPoint(this.x / LevelMap.TILE_SIZE, (this.y / LevelMap.TILE_SIZE) + j));
				}
			}
			
			else
			{
				
				for (var k:int = 0; k < this.width/LevelMap.TILE_SIZE; k++)
				{
					gates.push(new FlxPoint((this.x / LevelMap.TILE_SIZE) + k, (this.y / LevelMap.TILE_SIZE) + 1));
				}
				
				for (var l:int = 0; l < this.width/LevelMap.TILE_SIZE; l++)
				{
					gates.push(new FlxPoint((this.x / LevelMap.TILE_SIZE) + l, this.y / LevelMap.TILE_SIZE));
				}
			}
			
			closeDoor();
			play("closeInit");
		}
		
		override public function destroy():void
		{
			gates.length = 0;
			gates = null;
			
			super.destroy();	
		}
		
		private function closeDoor():void
		{
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 14);
			}
			
			play("close");
		}
		
		private function openDoor():void
		{
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 0);
			}
			
			play("open");
		}
		
	}

}
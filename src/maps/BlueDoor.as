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
				
				for (var i:int = 0; i < this.height/16; i++)
				{
					gates.push(new FlxPoint((this.x / 16) + 1, (this.y / 16) + i));
				}
				
				for (var j:int = 0; j < this.height/16; j++)
				{
					gates.push(new FlxPoint(this.x / 16, (this.y / 16) + j));
				}
			}
			
			else
			{
				
				for (var k:int = 0; k < this.width/16; k++)
				{
					gates.push(new FlxPoint((this.x / 16) + k, (this.y / 16) + 1));
				}
				
				for (var l:int = 0; l < this.width/16; l++)
				{
					gates.push(new FlxPoint((this.x / 16) + l, this.y / 16));
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
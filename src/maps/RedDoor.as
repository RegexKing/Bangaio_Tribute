package maps 
{
	import org.flixel.*;
	import units.Player;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class RedDoor extends FlxSprite
	{
		private var map:LevelMap;
		private var player:Player;
		private var orientation:uint;
		private var gates:Vector.<FlxPoint>;
		private var sensor:FlxRect;
		private var insideRect:Boolean = false;
		private var doorClosed:Boolean = false;
		
		public function RedDoor(X:int, Y:int, _map:LevelMap, _player:Player, _orientation:uint) 
		{
			super(X, Y);
			
			immovable = true;
			
			map = _map;
			player = _player;
			orientation = _orientation;
			
			gates = new Vector.<FlxPoint>();
			sensor = new FlxRect();
			
			if (orientation == LEFT)
			{
				makeGraphic(32, 128);
				
				for (var i:int = 0; i < this.height/16; i++)
				{
					gates.push(new FlxPoint((this.x / 16) + 1, (this.y / 16) + i));
				}
			}
			
			else if (orientation == RIGHT)
			{
				makeGraphic(32, 128);
				
				for (var j:int = 0; j < this.height/16; j++)
				{
					gates.push(new FlxPoint(this.x / 16, (this.y / 16) + j));
				}
			}
			
			else if (orientation == CEILING)
			{
				makeGraphic(128, 32);
				
				for (var k:int = 0; k < this.width/16; k++)
				{
					gates.push(new FlxPoint((this.x / 16) + k, (this.y / 16) + 1));
				}
			}
			
			else if (orientation == FLOOR)
			{
				makeGraphic(128, 32);
				
				for (var l:int = 0; l < this.width/16; l++)
				{
					gates.push(new FlxPoint((this.x / 16) + l, this.y / 16));
				}
			}
			
			sensor.x = this.x;
			sensor.y = this.y;
			sensor.width = this.width;
			sensor.height = this.height;
			
			openDoor();
		}
		
		override public function update():void
		{
			super.update();
			
			
			if (!doorClosed)
			{
				if (insideRect)
				{
					if (orientation == LEFT)
					{
						if (player.x > sensor.x + sensor.width) closeDoor();
					}
					
					else if (orientation == RIGHT)
					{
						if (player.x + player.width < sensor.x) closeDoor();
					}
					
					else if (orientation == CEILING)
					{
						if (player.y > sensor.y + sensor.height) closeDoor();
					}
					
					else if (orientation == FLOOR)
					{
						if (player.y + player.height < sensor.y) closeDoor();
					}
				}
				
				if (orientation == LEFT || orientation == CEILING) insideRect = FlxMath.pointInFlxRect(player.x, player.y, sensor);
				else insideRect = FlxMath.pointInFlxRect(player.x + player.width, player.y + player.height, sensor);
			}
			
			else
			{
				if (insideRect)
				{
					openDoor();
				}
				
				if (orientation == RIGHT || orientation == FLOOR) insideRect = FlxMath.pointInFlxRect(player.x, player.y, sensor);
				else insideRect = FlxMath.pointInFlxRect(player.x + player.width, player.y + player.height, sensor);
			}
		}
		
		override public function destroy():void
		{
			gates.length = 0;
			if (gates) gates = null;
			if (sensor) sensor = null;
			
			super.destroy();	
		}
		
		private function closeDoor():void
		{
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 6);
			}
			
			doorClosed = true;
			
			alpha = 1; //todo add close animation
		}
		
		private function openDoor():void
		{
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 0);
			}
			
			doorClosed = false;
			
			alpha = 0.5; //todo add open animation
		}
	}

}
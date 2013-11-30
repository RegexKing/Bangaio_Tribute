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
			
			if (orientation == LEFT || orientation == RIGHT)
			{
				loadGraphic(AssetsRegistry.redDoorVertPNG, true, false, 32, 128);
			}
			else
			{
				loadGraphic(AssetsRegistry.redDoorHoriPNG, true, false, 128, 32);
			}
			
			addAnimation("close", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 60, false);
			addAnimation("open", [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 60, false);
			addAnimation("openInit", [0], 60, false);
			
			if (orientation == LEFT || orientation == RIGHT)
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
			
			openDoor();
			play("openInit");
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
			gates = null;
			
			if (sensor) sensor = null;
			
			super.destroy();	
		}
		
		private function closeDoor():void
		{
			if (orientation == LEFT)
			{
				sensor.x -= this.width;
			}
			
			else if (orientation == RIGHT)
			{
				sensor.x += this.width;
			}
			
			else if (orientation == CEILING)
			{
				sensor.y -= this.height;
			}
			
			else
			{	
				sensor.y += this.height;
			}
			
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 14);
			}
			
			doorClosed = true;
			
			
			
			play("close");
		}
		
		private function openDoor():void
		{
			if (orientation == LEFT || orientation == RIGHT)
			{
				sensor.x = this.x;
				sensor.y = this.y - LevelMap.TILE_SIZE;
				sensor.width = this.width;
				sensor.height = this.height + LevelMap.TILE_SIZE*2;
			}
			
			else
			{
				sensor.x = this.x - LevelMap.TILE_SIZE;
				sensor.y = this.y;
				sensor.width = this.width + LevelMap.TILE_SIZE*2;
				sensor.height = this.height;
			}
			
			for each (var point:FlxPoint in gates)
			{
				map.setTile(point.x, point.y, 0);
			}
			
			doorClosed = false;
			
			play("open");
		}
	}

}
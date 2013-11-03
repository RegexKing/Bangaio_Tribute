package util 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BulletTrailsContainer extends FlxGroup
	{
		
		private var trails:Vector.<Queue>;
		private var timer:Number = 0;
		
		private var totalCols:int = 0;
		private var totalRows:int = 0;
		
		//**IMPORTANT**//
		//dimension of each container
		//most efficient size varies depending on map size
		private const CON_SIZE:int = 500;
		
		public function BulletTrailsContainer(_map:FlxTilemapExt) 
		{
			super();
			
			trails = new Vector.<Queue>();
			
			totalCols = Math.ceil(_map.width / CON_SIZE);
			totalRows = Math.ceil(_map.height / CON_SIZE);
			
			
			for (var j:int = 0; j < totalRows; j++)
			{
				for (var i:int = 0; i < totalCols; i++)
				{
					var box:FlxSprite = new FlxSprite((i) * CON_SIZE, (j) * CON_SIZE);
					box.makeGraphic(CON_SIZE, CON_SIZE, 0x0, true);
					
					this.add(box);
				}
			}

		}
		
		public function drawLine(startX:int, startY:int, endX:int, endY:int, trailColor:uint):Line
		{
			var y:int = Math.floor(startX / CON_SIZE);
			var x:int = Math.floor(startY / CON_SIZE);
			
			var index:int = y + (x * totalCols);
			
			var newStartX:int = startX % CON_SIZE;
			var newStartY:int = startY % CON_SIZE;
			var newEndX:int = endX - (y * CON_SIZE);
			var newEndY:int = endY - (x * CON_SIZE);
			
			trace(index + "  " + this.members[index]);
			
          	(this.members[index] as FlxSprite).drawLine(newStartX, newStartY, newEndX, newEndY, trailColor);
			
			return new Line(newStartX, newStartY, newEndX, newEndY, index);
		}
		
		public function getLines():Queue
		{
			for each (var lines:Queue in trails)
			{
				if (lines.empty)
				{	
					lines.write(Line.plugLine()); // fixes overdrive trails
					return lines;
				}
			}
			
			var newQueue:Queue = new Queue();
			
			
			newQueue.write(Line.plugLine()); // fixes overdrive trails
			trails.push(newQueue);
			return newQueue;
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FlxG.elapsed;
			
			if (timer >= 0.0161) // time it takes to erase lines
			{
				eraseLines();
				
				timer = 0;
				
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			trails = null;
		}
		
		private function eraseLines():void
		{
			for each (var lines:Queue in trails)
			{
				if (!lines.empty)
				{
					var line:Line = lines.read();
					
					if (line.index != -1)
					{
						(this.members[line.index] as FlxSprite).drawLine(line.startX, line.startY, line.endX, line.endY, 0x0, 4);
					}
					
					line = null;
				}
				
			}
		}
		
	}

}
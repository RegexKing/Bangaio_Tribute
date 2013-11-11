package hud 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class CountdownTimer extends FlxText
	{
		
		public static var timer:Number = 0;
		private var timeLimit:Number = 300;
		
		public function CountdownTimer() 
		{
			timer = 0;
			
			super(0, 0, 200);
			
			scrollFactor.x = scrollFactor.y = 0;
			
			x = FlxG.width / 2 - this.width / 2;
			y = this.height;
			
			setFormat(null, 16, 0xffFFFFFF, "center", 0xff000000);
			text = FlxU.formatTime(timeLimit);
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FlxG.elapsed;
			
			if (timeLimit > 0)
			{
				timeLimit -= FlxG.elapsed;
				
				if (timeLimit <= 0)
				{
					timeLimit = 0;
					color = 0xffFF0000;
					GameData.clearedTime = false;
				}
				
				text = FlxU.formatTime(timeLimit);
			}	
		}
		
		public static function getTimer():int
		{
			return int(timer * 1000);
		}
		
	}

}
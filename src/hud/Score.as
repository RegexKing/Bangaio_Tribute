package hud 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Score extends FlxText
	{
		
		private var scoreAmt:uint = 0;
		
		public function Score() 
		{
			super(0, 0, 300);
			
			scrollFactor.x = scrollFactor.y = 0;
			
			setFormat(null, 16, 0xffFFFFFF, "right", 0xff000000);
			text = String(scoreAmt);
			
			x = FlxG.width - this.width;
		}
		
		public function increaseScore(_val:uint):void
		{
			scoreAmt += _val;
			text = String(scoreAmt);
		}
		
		public function get score():uint
		{
			return scoreAmt;
		}
		
	}

}
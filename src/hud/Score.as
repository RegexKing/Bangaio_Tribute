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
		private const FORMAT:String = "0000000";
		
		public function Score() 
		{
			super(0, 0, 300);
			
			scrollFactor.x = scrollFactor.y = 0;
			
			setFormat(null, 16, 0xffFFFFFF, "left", 0xff000000);
			text = String("SCORE " + FORMAT);
			
			x = 10
		}
		
		public function increaseScore(_val:uint):void
		{
			scoreAmt += _val;
			
			var formattedScore:String = FORMAT;
			formattedScore = formattedScore.substr(0, formattedScore.length - String(scoreAmt).length);
			
			text = String("SCORE " + formattedScore + scoreAmt);
		}
		
		public function get score():uint
		{
			return scoreAmt;
		}
		
	}

}
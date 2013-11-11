package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Ball extends Scoreable
	{
		
		public function Ball(_textGroup:FlxGroup, _color:String = "green") 
		{
			super(_textGroup);
			
			immovable = true;
			
			health = 10;
			points = 10;
			
			if (_color == "green")
			{
				loadGraphic(AssetsRegistry.greenBallPNG);
			}
			
			else if (_color == "purple")
			{
				loadGraphic(AssetsRegistry.purpleBallPNG);
			}
			
		}
		
	}

}
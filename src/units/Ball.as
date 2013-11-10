package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Ball extends Destructible
	{
		
		public function Ball(_textGroup:FlxGroup, _color:String = "green") 
		{
			super(_textGroup);
			
			immovable = true;
			
			health = 10;
			points = 10;
			
			if (_color == "green")
			{
				makeGraphic(16, 16, 0xff009900);
			}
			
			else if (_color == "purple")
			{
				makeGraphic(16, 16, 0xff9933CC);
			}
			
		}
		
	}

}
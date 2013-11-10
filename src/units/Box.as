package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Box extends Destructible
	{
		
		public function Box(_textgroup:FlxGroup, _color:String = "blue") 
		{
			super(_textgroup);
			
			immovable = true;
			
			health = 10;
			points = 10;
			
			if (_color == "blue")
			{
				makeGraphic(16, 16, 0xff9AFFFB);
			}
			
			else if (_color == "green")
			{
				makeGraphic(16, 16, 0xff98FCA1);
			}
		}
		
	}

}
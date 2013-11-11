package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Box extends Scoreable
	{
		
		public function Box(_player:Player, _textgroup:FlxGroup, _color:String = "blue") 
		{
			super(_player,_textgroup);
			
			immovable = true;
			
			health = 10;
			points = 10;
			
			if (_color == "blue")
			{
				loadGraphic(AssetsRegistry.blueBoxPNG);
			}
			
			else if (_color == "green")
			{
				loadGraphic(AssetsRegistry.greenBoxPNG);
			}
		}
		
	}

}
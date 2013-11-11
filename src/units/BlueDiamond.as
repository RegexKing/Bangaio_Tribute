package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BlueDiamond extends Scoreable
	{
		
		public function BlueDiamond(_player:Player, _textGroup:FlxGroup) 
		{
			super(_player,_textGroup);
			
			immovable = true;
			
			points = 10;
			health = 10;
			
			loadGraphic(AssetsRegistry.blueDiamondPNG);
		}
		
	}

}
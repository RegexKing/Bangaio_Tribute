package units 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SmallPowerBomb extends Scoreable
	{
		
		public function SmallPowerBomb(_player:Player, _largeAreaExplosions:FlxGroup, _textGroup:FlxGroup) 
		{
			super(_player,_textGroup, _largeAreaExplosions);
		
			immovable = true;
			bombType = "largeRed";
			
			health = 10;
			points = 50;
			
			loadGraphic(AssetsRegistry.smallPowerBombPNG);
		}
	}

}
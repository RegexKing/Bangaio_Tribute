package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Targetable extends Scoreable
	{
		
		public function Targetable(_player:Player, _textGroup:FlxGroup, _blueExplosions:FlxGroup) 
		{
			super(_player, _textGroup,  _blueExplosions);
		}
		
	}

}
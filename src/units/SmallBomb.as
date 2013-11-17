package units 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SmallBomb extends Scoreable
	{
		
		public function SmallBomb(_player:Player, _smallAreaExplosions:FlxGroup, _textGroup:FlxGroup) 
		{
			super(_player,_textGroup, _smallAreaExplosions);
		
			immovable = true;
			bombType = "smallRed";
			
			health = 10;
			points = 20;
			
			loadGraphic(AssetsRegistry.smallBombPNG);
		}
	}

}
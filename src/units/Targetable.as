package units 
{
	import org.flixel.*;
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
		
		override public function kill():void
		{
			super.kill();
			
			FlxG.play(AssetsRegistry.targetExplosion_MP3);
		}
		
	}

}
package items 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import units.Player;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class FullLife extends FlxSprite implements Item
	{
		public function FullLife(X:int, Y:int) 
		{
			super(X, Y);
			
			immovable = true;
			
			loadGraphic(AssetsRegistry.fullLifePNG);
		}
		
		public function pickUp(_player:Player):void
		{
			_player.fillHealth();
			FlxG.play(AssetsRegistry.fullLife_MP3);
			
			kill();
		}
	}

}
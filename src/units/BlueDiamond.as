package units 
{
	import org.flixel.*;
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
		
		override public function kill():void
		{
			super.kill();
			
			FlxG.play(AssetsRegistry.blueDiamond_MP3);
		}
		
	}

}
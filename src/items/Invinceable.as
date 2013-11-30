package items 
{
	import org.flixel.FlxSprite;
	import units.Player;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Invinceable extends FlxSprite implements Item
	{
		public function Invinceable(X:int, Y:int) 
		{
			super(X, Y);
			
			immovable = true;
			
			loadGraphic(AssetsRegistry.invinceablePNG);
		}
		
		public function pickUp(_player:Player):void
		{
			// TODO, call function from player to be temp invinceable
			
			kill();
		}
	}

}
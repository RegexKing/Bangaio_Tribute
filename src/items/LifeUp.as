package items 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import units.Player;
	import units.Scoreable;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class LifeUp extends FlxSprite implements Item
	{
		private var used:Boolean = false;
		
		public function LifeUp() 
		{
			super();
			
			immovable = true;
		}
		
		
		public function setPos(X:int, Y:int):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (!used)
			{	
				used = true;
				
				loadGraphic(AssetsRegistry.lifeUpPNG);
			}
		}
		
		public function pickUp(_player:Player):void
		{
			_player.incHealth();
			FlxG.play(AssetsRegistry.lifeUp_MP3);
			
			kill();
		}
	}

}
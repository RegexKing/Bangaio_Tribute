package items 
{
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import units.Player;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class FullLife extends FlxSprite implements Item
	{
		
		private var flickerTimer:FlxDelay;
		private var killTimer:FlxDelay;
		
		public function FullLife(X:int, Y:int) 
		{
			super(X, Y);
			
			immovable = true;
			
			loadGraphic(AssetsRegistry.fullLifePNG);
			
			flickerTimer = new FlxDelay(10000);
			killTimer = new FlxDelay(5000);
			
			flickerTimer.callback = startFlicker;
			killTimer.callback = kill;
			
			flickerTimer.start();
		}
		
		public function pickUp(_player:Player):void
		{
			_player.fillHealth();
			
			kill();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			if (flickerTimer)
			{
				flickerTimer.abort();
				flickerTimer = null;
			}
			
			if (killTimer)
			{
				killTimer.abort();
				killTimer = null;
			}
		}
		
		private function startFlicker():void
		{
			this.flicker(5);
			
			killTimer.start();
		}
		
		
		
	}

}
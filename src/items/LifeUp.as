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
		
		private var flickerTimer:FlxDelay;
		private var killTimer:FlxDelay;
		private var used:Boolean = false;
		
		public function LifeUp() 
		{
			super();
			
			immovable = true;
			
			
			flickerTimer = new FlxDelay(10000);
			killTimer = new FlxDelay(5000);
			
			flickerTimer.callback = startFlicker;
			killTimer.callback = kill;
		}
		
		
		public function setPos(X:int, Y:int):void
		{
			revive();
			this.flicker(0);
			
			x = X;
			y = Y;
			
			if (!used)
			{	
				used = true;
				
				loadGraphic(AssetsRegistry.lifeUpPNG);
			}
			
			flickerTimer.start();
		}
		
		public function pickUp(_player:Player):void
		{
			_player.incHealth();
			
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
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
		
		private var explodeDelay:FlxDelay;
		
		public function SmallBomb(_player:Player, _smallAreaExplosions:FlxGroup, _textGroup:FlxGroup) 
		{
			super(_player,_textGroup, _smallAreaExplosions);
		
			immovable = true;
			isBomb = true;
			
			health = 10;
			points = 20;
			
			makeGraphic(16, 16, 0xffFF0000);
			
			explodeDelay = new FlxDelay(100);
			explodeDelay.callback = kill;
			
		}
		
		public function activateBomb():void
		{
			explodeDelay.start();
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			if (explodeDelay)
			{
				explodeDelay.abort();
				explodeDelay = null;
			}
		}
	}

}
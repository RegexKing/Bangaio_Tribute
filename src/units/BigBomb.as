package units 
{
	import items.Fruit;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BigBomb extends Scoreable
	{
		private var oranges:FlxGroup;
		
		public function BigBomb(_player:Player, _mediumAreaExplosions:FlxGroup, _textGroup:FlxGroup, _oranges:FlxGroup) 
		{
			super(_player, _textGroup, _mediumAreaExplosions);
			oranges = _oranges;

			bombType = "mediumRed";
			
			health = 10;
			points = 100;
			
			makeGraphic(32, 32, 0xffFF0000);
		}
		
		override public function kill():void
		{
			(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "orange");
			
			GameUtil.shakeCam();
			
			super.kill();
		}
	}

}
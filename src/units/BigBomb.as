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
	public class BigBomb extends Targetable implements Inertia
	{
		private var oranges:FlxGroup;
		
		public function BigBomb(X:int, Y:int, _player:Player, _mediumAreaExplosions:FlxGroup, _textGroup:FlxGroup, _oranges:FlxGroup) 
		{
			super(_player, _textGroup, _mediumAreaExplosions);
			immovable = true;
			x = X;
			y = Y;
			
			oranges = _oranges;

			bombType = "mediumRed";
			
			health = 10;
			points = 100;
			
			loadGraphic(AssetsRegistry.bigBombPNG);
		}
		
		override public function update():void
		{
			var tempY:int = this.y;
			
			super.update();
			
			acceleration.y = GameData.g_const;
			
			if (isTouching(FLOOR))
			{
				this.y = tempY;
				velocity.y = 0;
			}
		}
		
		override public function kill():void
		{
			(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "orange");
			
			GameUtil.shakeCam();
			
			super.kill();
		}
	}

}
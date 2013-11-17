package units 
{
	import items.Fruit;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Targetable implements Inertia
	{
		private var oranges:FlxGroup;
		
		public function BrownBlock(X:int, Y:int, _player:Player, _blueExplosions:FlxGroup, _textGroup:FlxGroup, _oranges:FlxGroup) 
		{
			super(_player, _textGroup, _blueExplosions);
			immovable = true;
			
			oranges = _oranges;
			
			this.x = X;
			this.y = Y;
			
			health = 10;
			points = 100;
			
			loadGraphic(AssetsRegistry.brownBoxPNG);
		}
		
		override public function update():void
		{
			var tempY:int = this.y;
			
			super.update();
			
			acceleration.y = 400;
			
			if (isTouching(FLOOR))
			{
				this.y = tempY;
				velocity.y = 0;
			}
		}
		
		override public function kill():void
		{
			(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "orange");
			
			super.kill();
		}
		
	}

}
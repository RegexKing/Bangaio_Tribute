package units 
{
	import items.Fruit;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Targetable
	{
		
		private var tempX:int = 0;
		
		private var oranges:FlxGroup;
		
		public function BrownBlock(X:int, Y:int, _textGroup:FlxGroup, _oranges:FlxGroup) 
		{
			super(_textGroup);
			
			oranges = _oranges;
			
			this.x = X;
			this.y = Y;
			tempX = this.x;
			
			health = 10;
			points = 100;
			
			loadGraphic(AssetsRegistry.brownBoxPNG);
		}
		
		override public function update():void
		{
			super.update();
			
			acceleration.y = 400;
			velocity.x = 0;
			acceleration.x = 0;
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			
			this.x = tempX;
		}
		
		override public function kill():void
		{
			(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), textGroup, "orange");
			
			super.kill();
		}
		
	}

}
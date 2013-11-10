package units 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Destructible
	{
		
		private var tempX:int = 0;
		
		public function BrownBlock(X:int, Y:int, _textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			this.x = X;
			this.y = Y;
			tempX = this.x;
			
			health = 10;
			points = 100;
			
			makeGraphic(32, 32, 0xff996600);
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
		
	}

}
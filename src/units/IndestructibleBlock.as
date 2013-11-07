package units 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class IndestructibleBlock extends FlxSprite
	{
		
		public function IndestructibleBlock() 
		{
			makeGraphic(32, 32);
			
		}
		
		override public function update():void
		{
			super.update();
			
			acceleration.y = 400;
			velocity.x = 0;
		}
		
		override public function hurt(value:Number):void
		{
			
		}
		
	}

}
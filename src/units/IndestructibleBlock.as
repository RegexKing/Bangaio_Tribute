package units 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class IndestructibleBlock extends FlxSprite implements Inertia
	{
		
		public function IndestructibleBlock(X:int, Y:int) 
		{
			super(X, Y);
			
			loadGraphic(AssetsRegistry.indestructableBlockPNG);
			immovable = true;
		}
		
		override public function update():void
		{
			super.update();
			
			acceleration.y = 400;
		}
		
		override public function hurt(_value:Number):void { }
		override public function kill():void { }
		
	}

}
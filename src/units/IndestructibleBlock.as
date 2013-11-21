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
			var tempY:int = this.y;
			
			super.update();
			
			acceleration.y = GameData.g_const;
			
			if (isTouching(FLOOR))
			{
				this.y = tempY;
				velocity.y = 0;
			}
		}
		
		override public function hurt(_value:Number):void { }
		override public function kill():void { }
		
	}

}
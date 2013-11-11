package units 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class IndestructibleBlock extends FlxSprite
	{
		
		private var tempX:int = 0;
		
		public function IndestructibleBlock(X:int, Y:int) 
		{
			super(X, Y);
			
			loadGraphic(AssetsRegistry.indestructableBlockPNG);
			
			tempX = this.x;
			
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
		
		override public function hurt(_value:Number):void { }
		override public function kill():void { }
		
	}

}
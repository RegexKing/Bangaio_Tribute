package hud 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class ScrollingText extends FlxText
	{
		private static const WIDTH:uint = 260;
		
		private var timer:Number = 0;
		private var timerOn:Boolean = false;
		public var lifespan:Number = 0.8;
		public var speed:Number = 50;
		
		public function ScrollingText() 
		{
			super(0, 0, WIDTH);
		}
		
		public function start():void
		{
			timerOn = true;
			this.velocity.y = -(speed);
		}
		
		public function setText(_size:Number, _color:uint, _text:String = "", _font:String = null):ScrollingText
		{
			this.setFormat(_font, _size, _color, "center", 0xff000000);
			this.text = _text;
			
			this.revive();
			
			return this;
		}
		
		
		override public function update():void
		{
			super.update();
			
			if (timerOn)
			{
				timer += FlxG.elapsed;
				
				if (timer >= lifespan)
				{
					this.velocity.y = 0;
					timer = 0;
					this.kill();
					timerOn = false;
				}
			}
		}
	}

}
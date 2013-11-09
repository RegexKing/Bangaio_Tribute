package units 
{
	import hud.ScrollingText;
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Destructible extends FlxSprite
	{
		private var textGroup:FlxGroup;
		
		protected var pointDisplay:ScrollingText;
		protected var points:uint = 0;
		
		public function Destructible(_textGroup:FlxGroup) 
		{
			super();
			
			textGroup = _textGroup;
		}
		
		override public function kill():void
		{
			super.kill();
			
			pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(12, 0xffFF3300);
			pointDisplay.text = points + "pnts";
			pointDisplay.x = this.getMidpoint().x - pointDisplay.width / 6;
			pointDisplay.y = this.getMidpoint().y - pointDisplay.height / 6;
			pointDisplay.start();
		}
		
	}

}
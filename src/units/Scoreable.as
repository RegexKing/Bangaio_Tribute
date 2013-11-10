package units 
{
	import hud.ScrollingText;
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Scoreable extends FlxSprite
	{
		protected var textGroup:FlxGroup;
		
		protected var pointDisplay:ScrollingText;
		protected var points:uint = 0;
		protected var scoreable:Boolean = true;
		
		public function Scoreable(_textGroup:FlxGroup) 
		{
			super();
			
			textGroup = _textGroup;
		}
		
		override public function kill():void
		{
			super.kill();
			
			if (scoreable)
			{
				var color:uint = 0;
				
				if (points >= 1000)
				{
					color = 0xff9900FF;
				}
				
				else if (points >= 500)
				{
					color = 0xff3399CC;
				}
				
				else 
				{
					color = 0xffFF3300;
				}
				
				pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(12, color);
				pointDisplay.text = points + "pnts";
				pointDisplay.x = this.getMidpoint().x - (pointDisplay.width/2);
				pointDisplay.y = this.getMidpoint().y - (pointDisplay.height/2);
				pointDisplay.start();
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			scoreable = true;
		}
		
	}

}
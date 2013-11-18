package units 
{
	import effects.BlueExplosion;
	import effects.RedExplosion;
	import hud.ScrollingText;
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Scoreable extends FlxSprite
	{
		protected var textGroup:FlxGroup;
		protected var player:Player;
		protected var blueExplosions:FlxGroup;
		
		protected var pointDisplay:ScrollingText;
		protected var points:uint = 0;
		protected var scoreable:Boolean = true;
		protected var enableExplosion:Boolean = true;
		protected var bombType:String = null;
		
		public function Scoreable(_player:Player, _textGroup:FlxGroup, _blueExplosions:FlxGroup = null) 
		{
			super();
			
			player = _player;
			textGroup = _textGroup;
			blueExplosions = _blueExplosions;
		}
		
		public function addScore():uint
		{
			player.score.increaseScore(points);
			
			return points;
		}
		
		override public function kill():void
		{
			super.kill();
			
			var countedPoints:uint = addScore();
			
			if (scoreable)
			{
				var color:uint = 0;
				
				if (countedPoints >= 1000)
				{
					color = 0xff9900FF;
				}
				
				else if (countedPoints >= 500)
				{
					color = 0xff3399CC;
				}
				
				else 
				{
					color = 0xffFF3300;
				}
				
				if (countedPoints < 500) pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(12, color);
				else if (countedPoints < 1000) pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(16, color);
				else pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(24, color);
				pointDisplay.text = countedPoints + "pt";
				pointDisplay.x = this.getMidpoint().x - (pointDisplay.width/2);
				pointDisplay.y = this.getMidpoint().y - (pointDisplay.height/2);
				pointDisplay.start();
				
			}
			
			if (enableExplosion && blueExplosions)
			{
				explode();
			}
			
		}
		
		protected function explode():void
		{
			
			if (bombType == "smallRed")
			{
				(blueExplosions.recycle(RedExplosion) as RedExplosion).startAt(this.getMidpoint(), "small" );
			}
			
			else if (bombType == "mediumRed")
			{
				(blueExplosions.recycle(RedExplosion) as RedExplosion).startAt(this.getMidpoint(), "medium" );
			}
			
			else if (bombType == "largeRed")
			{
				(blueExplosions.recycle(RedExplosion) as RedExplosion).startAt(this.getMidpoint(), "large" );
			}
			
			else 
			{
				(blueExplosions.recycle(BlueExplosion) as BlueExplosion).startAt(this.getMidpoint());
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			scoreable = true;
		}
		
	}

}
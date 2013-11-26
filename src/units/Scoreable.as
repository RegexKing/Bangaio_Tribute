package units 
{
	import effects.BlueExplosion;
	import effects.RedExplosion;
	import flash.geom.ColorTransform;
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
		protected var enableExplosion:Boolean = true;
		protected var bombType:String = null;
		protected var scoreColor:uint = 0xff3399CC;
		protected var flashAble:Boolean = false;
		private var isHurt:Boolean = false;
		private var timer:Number = 0;
		
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
		
		override public function update():void
		{
			super.update();
			
			if (isHurt)
			{
				timer += FlxG.elapsed;
				
				if (timer >= 0.032)
				{
					_colorTransform = null;
					calcFrame();
					
					isHurt = false;
					timer = 0;
				}
			}
		}
		
		override public function hurt(_damageNumber:Number):void
		{
			super.hurt(_damageNumber);
			if (flashAble)
			{
				_colorTransform = new ColorTransform();
				_colorTransform.color = 0xffFFFFFF;
				calcFrame();
				
				isHurt = true;
			}
		}
		
		override public function kill():void
		{	
			_colorTransform = null;
			
			super.kill();
			
			
			var countedPoints:uint = addScore();
				
			if (countedPoints < 500) pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(12, scoreColor);
			else if (countedPoints < 1000) pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(16, scoreColor);
			else pointDisplay = (textGroup.recycle(ScrollingText) as ScrollingText).setText(24, scoreColor);
			pointDisplay.text = countedPoints + "pt";
			pointDisplay.x = this.getMidpoint().x - (pointDisplay.width/2);
			pointDisplay.y = this.getMidpoint().y - (pointDisplay.height/2);
			pointDisplay.start();
			
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
		
	}

}
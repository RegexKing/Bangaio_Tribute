package effects 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SmallRedExplosion extends FlxSprite
	{
		
		public function SmallRedExplosion() 
		{
			super();
			
			loadGraphic(AssetsRegistry.redExplosionPNG, true, false, 32, 32);
			addAnimation("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 24, false);
		}
		
		public function startAt(_targetMidPoint:FlxPoint):void
		{	
			revive();
			
			this.x = _targetMidPoint.x - (this.width / 2);
			this.y = _targetMidPoint.y - (this.height / 2);
			
			play("explode");
		}
		
		override public function update():void
		{
			super.update();
			
			if (_curFrame == 21)
			{
				kill();
				
				FlxG.log("this");
			}
		}
	}

}
package effects 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class RedExplosion extends FlxSprite
	{
		
		private var used:Boolean = false;
		
		public function RedExplosion() 
		{
			super();
		}
		
		public function startAt(_targetMidPoint:FlxPoint, _explosionType:String):void
		{	
			revive();
			
			if (!used)
			{
				used = true;
				
				if (_explosionType == "small")
				{
					loadGraphic(AssetsRegistry.redExplosionPNG, true, false, 30, 30);
					addAnimation("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 24, false);
				}
				
				else if (_explosionType == "medium")
				{
					loadGraphic(AssetsRegistry.mediumRedExplosionPNG, true, false, 60, 60);
					addAnimation("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 24, false);
				}
				
				else if (_explosionType == "large")
				{
					loadGraphic(AssetsRegistry.largeRedExplosionPNG, true, false, 120, 120);
					addAnimation("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 24, false);
				}
			}
			
			this.x = _targetMidPoint.x - (this.width / 2);
			this.y = _targetMidPoint.y - (this.height / 2);
			
			play("explode");
		}
		
		override public function update():void
		{
			super.update();
			
			if (_curFrame == 20)
			{
				_curFrame = 0;
				kill();
			}
		}
	}

}
package units 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Target
	{
		
		private var tempX:int = 0;
		
		public function BrownBlock(_textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			health = 10;
			points = 100;
			
			makeGraphic(32, 32);
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			
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
		
	}

}
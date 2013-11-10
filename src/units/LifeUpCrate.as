package units 
{
	import items.LifeUp;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class LifeUpCrate extends Targetable
	{
		private var lifeUps:FlxGroup;
		
		public function LifeUpCrate() 
		{
			super(null);
			
			health = 10;
			points = 100;
			
		}
		
		public function setPos(X:int, Y:int, _textGroup:FlxGroup, _bulletDamageableObjects:FlxGroup, _collideableUnits:FlxGroup, _targets:Array, _lifeUps:FlxGroup):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				_bulletDamageableObjects.add(this);
				_collideableUnits.add(this);
				_targets.push(this);
				
				lifeUps = _lifeUps;
				
				makeGraphic(32, 32, 0xff7DB6B1);
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			(lifeUps.recycle(LifeUp) as LifeUp).setPos(this.x, this.y);
		}
		
	}

}
package units 
{
	import items.LifeUp;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class LifeUpCrate extends Targetable implements Inertia
	{
		private var lifeUps:FlxGroup;
		
		public function LifeUpCrate() 
		{
			super(null, null, null);
			immovable = true;
			
			health = 10;
			points = 100;
			
		}
		
		override public function update():void
		{
			var tempY:int = this.y;
			
			super.update();
			
			acceleration.y = GameData.g_const;
			
			if (isTouching(FLOOR))
			{
				this.y = tempY;
				velocity.y = 0;
			}
		}
		
		public function setPos(X:int, Y:int, _player:Player, _blueExplosions:FlxGroup, _textGroup:FlxGroup, _bulletDamageableObjects:FlxGroup, _collideableUnits:FlxGroup, _targets:Array, _lifeUps:FlxGroup):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (textGroup == null)
			{
				player = _player;
				textGroup = _textGroup;
				blueExplosions = _blueExplosions;
				_bulletDamageableObjects.add(this);
				_collideableUnits.add(this);
				_targets.push(this);
				
				lifeUps = _lifeUps;
				
				loadGraphic(AssetsRegistry.lifeUpCratePNG);
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			(lifeUps.recycle(LifeUp) as LifeUp).setPos(this.x, this.y);
		}
		
	}

}
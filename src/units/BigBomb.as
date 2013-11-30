package units 
{
	import items.Fruit;
	import org.flixel.*;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BigBomb extends Targetable implements Inertia
	{
		private var oranges:FlxGroup;
		
		public function BigBomb() 
		{
			super(null, null, null);
			immovable = true;

			bombType = "mediumRed";
			
			health = 10;
			points = 100;
			
			loadGraphic(AssetsRegistry.bigBombPNG);
			
			maxVelocity.y = 280;
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 10;
			points = 100;
			
			velocity.y = 0;
		}
		
		public function setPos(X:int, Y:int, _player:Player, _mediumAreaExplosions:FlxGroup, _textGroup:FlxGroup, _oranges:FlxGroup, _collideableUnits:FlxGroup, _bulletDamageableObjects:FlxGroup, _targets:Array):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (!textGroup)
			{
				player = _player;
				blueExplosions = _mediumAreaExplosions;
				textGroup = _textGroup;
				oranges = _oranges;
				
				_collideableUnits.add(this);
				_bulletDamageableObjects.add(this);
				_targets.push(this);
			}
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
		
		override public function kill():void
		{
			(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "orange");
			
			GameUtil.shakeCam();
			
			super.kill();
		}
	}

}
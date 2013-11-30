package units 
{
	import items.Fruit;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BrownBlock extends Targetable implements Inertia
	{
		private var oranges:FlxGroup;
		
		public function BrownBlock() 
		{
			super(null, null, null);
			immovable = true;
			
			health = 10;
			points = 100;
			
			loadGraphic(AssetsRegistry.brownBoxPNG);
			
			maxVelocity.y = 280;
		}
		
		public function setPos(X:int, Y:int, _player:Player, _blueExplosions:FlxGroup, _textGroup:FlxGroup, _oranges:FlxGroup, _collideableUnits:FlxGroup, _bulletDamageableObjects:FlxGroup, _targets:Array):void
		{	
			revive();
			
			this.x = X;
			this.y = Y;
			
			if (!textGroup)
			{
				player = _player;
				blueExplosions = _blueExplosions;
				textGroup = _textGroup;
				oranges = _oranges;
				
				_collideableUnits.add(this);
				_bulletDamageableObjects.add(this);
				_targets.push(this);
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 10;
			points = 100;
			
			velocity.y = 0;
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
			
			super.kill();
		}
		
	}

}
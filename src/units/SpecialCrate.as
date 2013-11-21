package units 
{
	import items.FullLife;
	import items.Invinceable;
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SpecialCrate extends Targetable implements Inertia
	{
		
		private var itemsGroup:FlxGroup;
		private var crateType:String;
		
		public function SpecialCrate(_player:Player, _blueExplosions:FlxGroup, _textGroup:FlxGroup,  _itemsGroup:FlxGroup, _crateType:String) 
		{
			super(_player, _textGroup, _blueExplosions);
			immovable = true;
			
			health = 10;
			points = 100;
			
			itemsGroup = _itemsGroup;
			crateType = _crateType;
			
			if (crateType == "fullLife")
			{
				loadGraphic(AssetsRegistry.fullLifeCratePNG);
			}
			
			else if (crateType == "invinceable")
			{
				loadGraphic(AssetsRegistry.invinceableCratePNG);
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
			super.kill();
			
			if (crateType == "fullLife")
			{
				itemsGroup.add(new FullLife(this.x, this.y));
			}
			
			else if (crateType == "invinceable")
			{
				itemsGroup.add(new Invinceable(this.x, this.y));
			}
		}
		
	}

}
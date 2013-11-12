package units 
{
	import items.FullLife;
	import items.Invinceable;
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SpecialCrate extends Targetable
	{
		
		private var itemsGroup:FlxGroup;
		private var crateType:String;
		
		public function SpecialCrate(_player:Player, _textGroup:FlxGroup,  _itemsGroup:FlxGroup, _crateType:String) 
		{
			super(_player,_textGroup, null);
			
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
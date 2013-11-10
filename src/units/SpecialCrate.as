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
		
		public function SpecialCrate(_textGroup:FlxGroup, _itemsGroup:FlxGroup, _crateType:String) 
		{
			super(_textGroup);
			
			health = 10;
			points = 100;
			
			itemsGroup = _itemsGroup;
			crateType = _crateType;
			
			if (crateType == "fullLife")
			{
				makeGraphic(32, 32, 0xff7DB6B1);
			}
			
			else if (crateType == "invinceable")
			{
				makeGraphic(32, 32, 0xff7DB6B1);
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
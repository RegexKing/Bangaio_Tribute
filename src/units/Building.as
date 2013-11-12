package units 
{
	import effects.BlueExplosion;
	import hud.ScrollingText;
	import items.Fruit;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Building extends Targetable
	{
		
		private var buildingType:String;
		
		private var oranges:FlxGroup;
		private var bananas:FlxGroup;
		private var pineapples:FlxGroup;
		private var watermelons:FlxGroup;
		
		public function Building(_player:Player, _blueExplosions:FlxGroup, _buildingType:String, _textGroup:FlxGroup, _oranges:FlxGroup, _bananas:FlxGroup, _pineapples:FlxGroup, _watermelons:FlxGroup, _upOrDown:uint = UP) 
		{
			super(_player,_textGroup, _blueExplosions);
			
			buildingType = _buildingType;
			
			oranges = _oranges;
			bananas = _bananas;
			pineapples = _pineapples;
			watermelons = _watermelons;
			
			immovable = true;
			
			buildingType = _buildingType;
			
			if (_buildingType == "house")
			{
				health = 20;
				points = 100;
				
				loadGraphic(AssetsRegistry.housePNG, true, false, 32, 32);
			}
			else if (_buildingType == "wideBuilding")
			{
				health = 50;
				points = 200;
				
				loadGraphic(AssetsRegistry.wideBuildingPNG, true, false, 64, 32);
			}
			else if (_buildingType == "tallBuilding")
			{
				health = 160;
				points = 300;
				
				loadGraphic(AssetsRegistry.tallBuildingPNG, true, false, 48, 64);
			}
			else if (_buildingType == "car")
			{
				health = 160;
				points = 500;
				
				loadGraphic(AssetsRegistry.carPNG, true, false, 32, 16);
			}
			
			if (_upOrDown == UP)
			{
				angle = 0;
			}
			
			else if (_upOrDown == DOWN)
			{
				angle = 180;
			}
			
			addAnimation("intact", [0]);
			addAnimation("destroyed", [1]);
			
			play("intact");
		}
		
		override public function kill():void
		{
			
			if (buildingType == "house")
			{
				(oranges.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "orange");
			}
			else if (buildingType == "wideBuilding")
			{
				(bananas.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "banana");
			}
			else if (buildingType == "tallBuilding")
			{
				(pineapples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "pineapple");
			}
			else if (buildingType == "car")
			{
				(watermelons.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "watermelon");
			}
			
			play("destroyed");
			
			active = false;
			alive = false;
			solid = false;
			visible = true;
			
			//since kill is overwritten
			(blueExplosions.recycle(BlueExplosion) as BlueExplosion).startAt(this.getMidpoint());
		}
		
	}

}
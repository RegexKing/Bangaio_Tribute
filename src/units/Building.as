package units 
{
	import effects.BlueExplosion;
	import hud.ScrollingText;
	import items.Fruit;
	import org.flixel.*;
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
			super(_player, _textGroup, _blueExplosions);
			flashAble = true;
			
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
				
				loadGraphic(AssetsRegistry.housePNG, true, false, 30, 30);
			}
			else if (_buildingType == "wideBuilding")
			{
				health = 50;
				points = 200;
				
				loadGraphic(AssetsRegistry.wideBuildingPNG, true, false, 60, 30);
			}
			else if (_buildingType == "tallBuilding")
			{
				health = 160;
				points = 300;
				
				loadGraphic(AssetsRegistry.tallBuildingPNG, true, false, 45, 60);
			}
			else if (_buildingType == "car")
			{
				health = 160;
				points = 500;
				
				loadGraphic(AssetsRegistry.carPNG, true, false, 30, 15);
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
		
		override public function hurt(_damageNumber:Number):void
		{
			super.hurt(_damageNumber);
			
			if (health <= 0)
			{
				_colorTransform = null;
				calcFrame();
			}
			
			if (buildingType != "car") FlxG.play(AssetsRegistry.objectHurt_MP3);
			
			else
			{
				//play car sounds
			}
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
				
				FlxG.play(AssetsRegistry.wideBuilding_MP3);
			}
			else if (buildingType == "tallBuilding")
			{
				(pineapples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "pineapple");
				FlxG.play(AssetsRegistry.tallBuilding_MP3);
			}
			else if (buildingType == "car")
			{
				(watermelons.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "watermelon");
			}
			
			super.kill();
			super.revive();
			
			play("destroyed");
			
			active = false;
			alive = false;
			solid = false;
			visible = true;
			
			_colorTransform = null;
			calcFrame();
			
			//since kill is overwritten
			(blueExplosions.recycle(BlueExplosion) as BlueExplosion).startAt(this.getMidpoint());
		}
		
	}

}
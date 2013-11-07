package units 
{
	import hud.ScrollingText;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Building extends Target
	{
		
		private var buildingType:String;
		
		public function Building(_buildingType:String, _textGroup:FlxGroup, _upOrDown:uint = UP) 
		{
			super(_textGroup);
			
			buildingType = _buildingType;
			
			if (_buildingType == "2x2")
			{
				health = 20;
				points = 100;
				makeGraphic(32, 32);
			}
			else if (_buildingType == "4x2")
			{
				health = 50;
				points = 200;
				makeGraphic(64, 32);
			}
			else if (_buildingType == "3x4")
			{
				health = 160;
				points = 300;
				makeGraphic(48, 64);
			}
			else if (_buildingType == "car")
			{
				health = 160;
				points = 500;
				makeGraphic(32, 16);
			}
			
			if (_upOrDown == UP)
			{
				angle = 0;
			}
			
			else if (_upOrDown == DOWN)
			{
				angle = 180;
			}
			
			immovable = true;
		}
		
	}

}
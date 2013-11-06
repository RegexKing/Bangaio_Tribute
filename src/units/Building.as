package units 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Building extends Target
	{
		
		public function Building(_buildingType:String) 
		{
			if (_buildingType == "1x1") makeGraphic(48, 32);
			else if ((_buildingType == "3x1") makeGraphic(32, 32);
			else if (_buildingType == "3x4") makeGraphic(48, 64);
			else if (_buildingType == "car") makeGraphic(32, 16);
			
			immovable = true;
		}
		
	}

}
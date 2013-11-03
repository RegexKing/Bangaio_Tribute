package util 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Line 
	{
		
		public var startX:int;
		public var startY:int;
		public var endX:int;
		public var endY:int;
		public var index:int;
		
		public function Line(_startX:int, _startY:int, _endX:int, _endY:int, _index:int) 
		{
			startX = _startX;
			startY = _startY;
			endX = _endX;
			endY = _endY;
			index = _index;
		}
		
		//function that fixes trail recycling when missleOverdrive occurs
		public static function plugLine():Line
		{
			return new Line(0, 0, 0, 0, -1);
		}
		
	}

}
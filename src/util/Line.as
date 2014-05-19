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
		
		private static var plug:Line;
		private static var lineStack:Vector.<Line> = new Vector.<Line>();
		private static var l:uint = 0;
		
		public function Line() 
		{
		}
		
		
		public static function getLine(_startX:int, _startY:int, _endX:int, _endY:int, _index:int):Line
		{
			if (l <= 0)
			{
				var newLine:Line = new Line();
				
				newLine.startX = _startX;
				newLine.startY = _startY;
				newLine.endX = _endX;
				newLine.endY = _endY;
				newLine.index = _index;
				
				return newLine;
			}
			
			else
			{	
				var extractedLine:Line = lineStack.pop();
				l--;
				
				extractedLine.startX = _startX;
				extractedLine.startY = _startY;
				extractedLine.endX = _endX;
				extractedLine.endY = _endY;
				extractedLine.index = _index;
				
				return extractedLine;
			}
			
		}
		
		public static function dumpLine(dumpedLine:Line):void
		{
			lineStack.push(dumpedLine);
			l++;
		}
		
		//function that fixes trail recycling when missleOverdrive occurs
		public static function plugLine():Line
		{
			if (plug) return plug;
			
			else
			{
				plug = new Line();
				
				plug.startX = 0;
				plug.startY = 0;
				plug.endX = 0;
				plug.endY = 0;
				plug.index = -1;
				
				return plug;
			}
		}
		
	}

}
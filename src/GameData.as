package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	 
	public class GameData 
	{
		public static const g_const:int = 200;
		
		public static var level:uint = 1;
		
		public static var clearedTime:Boolean = true;
		public static var highestExplosion:uint = 0;
		
		public static function resetData():void
		{
			clearedTime = true;
			highestExplosion = 0;
		}
	}
}
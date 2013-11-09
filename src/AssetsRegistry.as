package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class AssetsRegistry 
	{
		//-- Sprites --//
		[Embed(source = "../assets/sprites/player.png")] public static var playerPNG:Class;
		[Embed(source = "../assets/sprites/blue.png")] public static var bluePNG:Class;
		
		[Embed(source = "../assets/sprites/laser.png")] public static var laserPNG:Class;
		[Embed(source = "../assets/sprites/missle.png")] public static var misslePNG:Class;
		[Embed(source = "../assets/sprites/playerGibs.png")] public static var playerGibsPNG:Class;
		[Embed(source = "../assets/sprites/bulletShell.png")] public static var bulletShellPNG:Class;
		
		//Tiles
		[Embed(source = "../assets/tiles/tiles.png")] public static var tilesPNG:Class;
		
		//BGMS
		
		//539682_Omegeist
		[Embed(source = "../assets/sounds/bgm1.mp3")] public static var BGM1_MP3:Class;
		
		//Sound effects
		[Embed(source = "../assets/sounds/missleOverdrive.mp3")] public static var MISSLEOVERDRIVE_MP3:Class;
		[Embed(source = "../assets/sounds/bounceGun.mp3")] public static var BOUNCEGUN_MP3:Class;
		[Embed(source = "../assets/sounds/noAmmo.mp3")] public static var NOAMMO_MP3:Class;
		
		
		//-- Fonts --//
		
		//Megaman2
		[Embed(source = "../assets/fonts/megaman.ttf", fontFamily = "NES", embedAsCFF = "false")] public static var fontNES:String;
		
		// Level Maps
		[Embed(source = "../assets/maps/level_1_map.csv", mimeType = "application/octet-stream")] public static var level_1CSV:Class;
		
		// Sprite Maps
		[Embed(source = "../assets/maps/level_1_spriteMap.csv", mimeType = "application/octet-stream")] public static var level_1_SpritesCSV:Class;
		
		
		public function AssetsRegistry() {}
		
	}

}
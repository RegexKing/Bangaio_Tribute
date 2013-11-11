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
		
		[Embed(source = "../assets/sprites/bounce.png")] public static var bouncePNG:Class;
		[Embed(source = "../assets/sprites/missle.png")] public static var misslePNG:Class;
		[Embed(source = "../assets/sprites/playerGibs.png")] public static var playerGibsPNG:Class;
		[Embed(source = "../assets/sprites/bulletShell.png")] public static var bulletShellPNG:Class;
		
		
		//obstacles
		[Embed(source = "../assets/sprites/blueDiamond.png")] public static var blueDiamondPNG:Class;
		[Embed(source = "../assets/sprites/greenBall.png")] public static var greenBallPNG:Class;
		[Embed(source = "../assets/sprites/purpleBall.png")] public static var purpleBallPNG:Class;
		[Embed(source = "../assets/sprites/greenBox.png")] public static var greenBoxPNG:Class;
		[Embed(source = "../assets/sprites/blueBox.png")] public static var blueBoxPNG:Class;
		
		//buildings
		[Embed(source = "../assets/sprites/house.png")] public static var housePNG:Class;
		[Embed(source = "../assets/sprites/wideBuilding.png")] public static var wideBuildingPNG:Class;
		[Embed(source = "../assets/sprites/tallBuilding.png")] public static var tallBuildingPNG:Class;
		[Embed(source = "../assets/sprites/car.png")] public static var carPNG:Class;
		
		
		//Fruit sprites
		[Embed(source = "../assets/sprites/apple.png")] public static var applePNG:Class;
		[Embed(source = "../assets/sprites/orange.png")] public static var orangePNG:Class;
		[Embed(source = "../assets/sprites/banana.png")] public static var bananaPNG:Class;
		[Embed(source = "../assets/sprites/pineapple.png")] public static var pineapplePNG:Class;
		[Embed(source = "../assets/sprites/watermelon.png")] public static var watermelonPNG:Class;
		
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
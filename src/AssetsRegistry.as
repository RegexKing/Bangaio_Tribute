package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class AssetsRegistry 
	{
		//-- Sprites --//
		
		//effects
		[Embed(source = "../assets/sprites/bulletShell.png")] public static var bulletShellPNG:Class;
		[Embed(source = "../assets/sprites/redExplosion.png")] public static var redExplosionPNG:Class;
		[Embed(source = "../assets/sprites/mediumRedExplosion.png")] public static var mediumRedExplosionPNG:Class;
		[Embed(source = "../assets/sprites/largeRedExplosion.png")] public static var largeRedExplosionPNG:Class;
		[Embed(source = "../assets/sprites/blueExplosion.png")] public static var blueExplosionPNG:Class;
		
		[Embed(source = "../assets/sprites/bounce.png")] public static var bouncePNG:Class;
		[Embed(source = "../assets/sprites/missle.png")] public static var misslePNG:Class;
		[Embed(source = "../assets/sprites/playerGibs.png")] public static var playerGibsPNG:Class;
		
		[Embed(source = "../assets/sprites/player.png")] public static var playerPNG:Class;
		
		//enemies
		[Embed(source = "../assets/sprites/blue.png")] public static var bluePNG:Class;
		[Embed(source = "../assets/sprites/turret.png")] public static var turretPNG:Class;
		[Embed(source = "../assets/sprites/flak.png")] public static var flakPNG:Class;
		
		
		
		
		//obstacles
		[Embed(source = "../assets/sprites/blueDiamond.png")] public static var blueDiamondPNG:Class;
		[Embed(source = "../assets/sprites/greenBall.png")] public static var greenBallPNG:Class;
		[Embed(source = "../assets/sprites/purpleBall.png")] public static var purpleBallPNG:Class;
		[Embed(source = "../assets/sprites/greenBox.png")] public static var greenBoxPNG:Class;
		[Embed(source = "../assets/sprites/blueBox.png")] public static var blueBoxPNG:Class;
		[Embed(source = "../assets/sprites/brownBox.png")] public static var brownBoxPNG:Class;
		[Embed(source = "../assets/sprites/indestructibleBlock.png")] public static var indestructableBlockPNG:Class;
		
		//buildings
		[Embed(source = "../assets/sprites/house.png")] public static var housePNG:Class;
		[Embed(source = "../assets/sprites/wideBuilding.png")] public static var wideBuildingPNG:Class;
		[Embed(source = "../assets/sprites/tallBuilding.png")] public static var tallBuildingPNG:Class;
		[Embed(source = "../assets/sprites/car.png")] public static var carPNG:Class;
		
		//crates
		[Embed(source = "../assets/sprites/lifeUpCrate.png")] public static var lifeUpCratePNG:Class;
		[Embed(source = "../assets/sprites/fullLifeCrate.png")] public static var fullLifeCratePNG:Class;
		[Embed(source = "../assets/sprites/invinceableCrate.png")] public static var invinceableCratePNG:Class;
		
		//==items==//
		//energy crates
		[Embed(source = "../assets/sprites/lifeUp.png")] public static var lifeUpPNG:Class;
		[Embed(source = "../assets/sprites/fullLife.png")] public static var fullLifePNG:Class;
		[Embed(source = "../assets/sprites/invinceable.png")] public static var invinceablePNG:Class;
		
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
		[Embed(source = "../assets/sounds/switchWeapon.mp3")] public static var SWITCHWEAPON_MP3:Class;
		
		
		//-- Fonts --//
		
		//Megaman2
		[Embed(source = "../assets/fonts/megaman.ttf", fontFamily = "NES", embedAsCFF = "false")] public static var fontNES:String;
		
		// Level Maps
		[Embed(source = "../assets/maps/level_1_map.csv", mimeType = "application/octet-stream")] public static var level_1CSV:Class;
		[Embed(source = "../assets/maps/level_2_map.csv", mimeType = "application/octet-stream")] public static var level_2CSV:Class;
		
		// Sprite Maps
		[Embed(source = "../assets/maps/level_1_spriteMap.csv", mimeType = "application/octet-stream")] public static var level_1_SpritesCSV:Class;
		[Embed(source = "../assets/maps/level_2_spriteMap.csv", mimeType = "application/octet-stream")] public static var level_2_SpritesCSV:Class;
		
		
		public function AssetsRegistry() {}
		
	}

}
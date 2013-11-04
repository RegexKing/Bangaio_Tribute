package maps 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import org.flixel.*;
	import units.Block;
	import units.Blue;
	import units.Player;
	import util.BulletTrailsContainer;
	import util.FlxTilemapExt;
	 
	public class LevelMap extends FlxTilemapExt
	{
		public static const TILE_SIZE:int = 16;
		
		private var targets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var bulletTrails:BulletTrailsContainer;
		private var items:FlxGroup;
		private var player:Player;
		
		private var spriteMap:String;
		
		public function LevelMap(_level:uint = 1) 
		{
			if (_level == 1)  
			{
				this.loadMap(new AssetsRegistry.testCSV, AssetsRegistry.tilesPNG, 16, 16, OFF, 0, 1, 2);
				
				//TODO: load csv map of sprite positions
				//spriteMap = //sprite csv data
			}
		}
		
		public function InitializeLevel(_player:Player, _targets:FlxGroup, _enemyBullets:FlxGroup, _bulletTrails:BulletTrailsContainer, _items:FlxGroup):void
		{
			bulletTrails = _bulletTrails;
			player = _player;
			targets = _targets;
			enemyBullets = _enemyBullets;
			items = _items;
			
			// parseSpriteMap();
			// ^^ this function will parse the spritemapdata, will create/position game objects
			
			player.x = 1 * TILE_SIZE;
			player.y = 6 * TILE_SIZE;
			
			
			var enemy:FlxSprite = new FlxSprite(200, 200);
			enemy.makeGraphic(35, 35);
			enemy.health = 500;
			targets.add(enemy);
			
			
			var enemy2:Blue = new Blue(enemyBullets, player, this, bulletTrails);
			enemy2.x = 800;
			enemy2.y = 200;
			targets.add(enemy2);
		}
		
		
		private function parseSpriteMap():void
		{
			
		}
		
	}

}
package hud 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import units.Player;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Overdrive extends FlxGroup
	{
		private var overDriveMeter:FlxBar;
		private var charges:FlxText;
		private var player:Player;
		
		public function Overdrive(_player:Player) 
		{
			super();
			
			player = _player;
			
			overDriveMeter =  new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 200, 10, null, null, 0, 50);
			overDriveMeter.y = FlxG.height - overDriveMeter.height;
			
			charges = new FlxText(0, 0, 150);
			charges.setFormat(null, 16, 0xffFFFFFF, "left");
			charges.x = overDriveMeter.width;
			charges.y = FlxG.height - charges.height*2 + charges.height/2;
			
			overDriveMeter.scrollFactor.x = overDriveMeter.scrollFactor.y = 0;
			charges.scrollFactor.x = charges.scrollFactor.y = 0;
			
			add(overDriveMeter);
			add(charges);
			
			updateOverdriveHud();
		}
		
		public function updateOverdriveHud():void
		{
			overDriveMeter.currentValue = player.overdriveCharges % 50;
			charges.text = String(Math.floor(player.overdriveCharges / 50));
		}
		
	}

}
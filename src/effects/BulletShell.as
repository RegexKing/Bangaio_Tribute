package effects 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import org.flixel.*; 
	 
	public class BulletShell extends FlxParticle
	{
		
		public function BulletShell() 
		{
			super();
			
			loadRotatedGraphic(AssetsRegistry.bulletShellPNG, 64);
			
			exists = false;
		}
		
		override public function update():void
		{
			if (justTouched(FLOOR)) kill();
		}
		
	}

}
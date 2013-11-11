package weapons 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class E_NormalBullet extends BulletExt
	{
		
		public function E_NormalBullet() 
		{
			super();
			
			loadRotatedGraphic(AssetsRegistry.bouncePNG, 100);
			
			offset.x = 8;
			width = 16;
			offset.y = 8;
			height = 16;
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
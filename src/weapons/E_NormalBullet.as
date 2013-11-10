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
			
			loadRotatedGraphic(AssetsRegistry.bouncePNG, 200);
			
			offset.x = 8;
			width = 16;
			offset.y = 11;
			height = 8;
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
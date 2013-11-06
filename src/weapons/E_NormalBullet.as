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
			
			loadRotatedGraphic(AssetsRegistry.misslePNG, 200);
			
			offset.x = 14;
			width = 10;
			offset.y = 14;
			height = 10;
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
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
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
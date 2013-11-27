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
			
			loadRotatedGraphic(AssetsRegistry.e_normalBulletPNG, 60);
			
			offset.x = 2;
			width = 16;
			offset.y = 2;
			height = 16;
			
			trailColor = 0xffFF0000;
			
			angularVelocity = 200;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
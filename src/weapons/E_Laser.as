package weapons 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class E_Laser extends BulletExt
	{
		
		public function E_Laser() 
		{
			// Makes rendering rotations perform better, 200 rotations for 200 directions
			loadRotatedGraphic(AssetsRegistry.bouncePNG, 1);
			
			offset.x =11;
			width = 10;
			offset.y = 10;
			height = 11;
			
			visible = false;
			
			trailColor = 0xffFFFF00;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
		override public function hurt(_val:Number):void {}
		
	}

}
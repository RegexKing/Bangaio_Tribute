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
			width = 16;
			height = 16;
			
			visible = false;
			
			trailColor = 0xffFFFF00;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
		}
		
	}

}
package weapons 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class E_HomingBullet extends BulletExt
	{
		
		public const SPEED:uint = 4500;
		public const TURN_SPEED:Number = 0.1;
		
		public function E_HomingBullet() 
		{
			super();
			
			loadRotatedGraphic(AssetsRegistry.misslePNG, 200);
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
			
			if (player != null && player.exists)
			{
				angle = GameUtil.easeTowardsTarget(this, player, SPEED, TURN_SPEED);
			}
		}
		
	}

}
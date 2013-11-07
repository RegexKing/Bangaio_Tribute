package units 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class ExplosiveGate extends Target implements Gate
	{
		
		private var above:Gate;
		private var below:Gate;
		private var left:Gate;
		private var right:Gate;
		
		private var explodeDelay:FlxDelay;
		
		public function ExplosiveGate(_textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			health = 10;
			points = 20;
			
			makeGraphic(16, 16);
			
			explodeDelay = new FlxDelay(100);
			explodeDelay.callback = kill;
			
		}
		
		public function activateGate():void
		{
			explodeDelay.start();
		}
		
		public function setGate(gates:Array):void
		{
			for each (var gate:FlxSprite in gates)
			{
				if (gate.x == this.x - 16) left = (gate as Gate);
				else if (gate.x == this.x + 16) right = (gate as Gate);
				else if (gate.y == this.y - 16) above = (gate as Gate);
				else if (gate.y == this.y + 16) below = (gate as Gate);
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			activateSurroundingGates();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			if (explodeDelay != null)
			{
				explodeDelay.abort();
				explodeDelay = null;
			}
		}
		
		private function activateSurroundingGates():void
		{
			if (above) above.activateGate();
			if (below) below.activateGate();
			if (left) left.activateGate();
			if (right) right.activateGate();
		}
		
	}

}
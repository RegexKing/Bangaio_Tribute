package units 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SmallBomb extends Destructible implements GateChain
	{
		
		private var above:GateChain;
		private var below:GateChain;
		private var left:GateChain;
		private var right:GateChain;
		
		private var explodeDelay:FlxDelay;
		
		public function SmallBomb(_textGroup:FlxGroup) 
		{
			super(_textGroup);
		
			immovable = true;
			
			health = 10;
			points = 20;
			
			makeGraphic(16, 16, 0xffFF0000);
			
			explodeDelay = new FlxDelay(100);
			explodeDelay.callback = kill;
			
		}
		
		public function activateGate():void
		{
			explodeDelay.start();
		}
		
		public function setGate(gateChains:Array):void
		{
			for each (var gate:FlxSprite in gateChains)
			{
				if (gate.x == this.x - 16) left = (gate as GateChain);
				else if (gate.x == this.x + 16) right = (gate as GateChain);
				else if (gate.y == this.y - 16) above = (gate as GateChain);
				else if (gate.y == this.y + 16) below = (gate as GateChain);
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
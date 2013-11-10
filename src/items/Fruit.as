package items 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import units.Player;
	import units.Scoreable;
	
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Fruit extends Scoreable implements Item
	{
		private var chargeAmt:uint = 0;
		private var flickerTimer:FlxDelay;
		private var killTimer:FlxDelay;
		
		private var expired:Boolean = false;
		
		public function Fruit() 
		{
			super(null);
			
			immovable = true;
			
			points = 10;
			
			flickerTimer = new FlxDelay(10000);
			killTimer = new FlxDelay(5000);
			
			flickerTimer.callback = startFlicker;
			killTimer.callback = expireFruit;
		}
		
		public function setPos(X:int, Y:int, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				
				if (_fruitType == "orange")
				{
					loadGraphic(AssetsRegistry.orangePNG);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					loadGraphic(AssetsRegistry.applePNG);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					loadGraphic(AssetsRegistry.bananaPNG);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadGraphic(AssetsRegistry.pineapplePNG);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadGraphic(AssetsRegistry.watermelonPNG);
					chargeAmt = 50;
				}
			}
			
			flickerTimer.start();
		}
		
		public function setPosAt(targetMidpoint:FlxPoint, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				
				if (_fruitType == "orange")
				{
					loadGraphic(AssetsRegistry.orangePNG);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					loadGraphic(AssetsRegistry.applePNG);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					loadGraphic(AssetsRegistry.bananaPNG);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadGraphic(AssetsRegistry.pineapplePNG);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadGraphic(AssetsRegistry.watermelonPNG);
					chargeAmt = 50;
				}
			}
			
			x = targetMidpoint.x - (this.width / 2);
			y = targetMidpoint.y - (this.height / 2);
			
			flickerTimer.start();
		}
		
		public function pickUp(_player:Player):void
		{
			_player.setCharge(chargeAmt);
			
			kill();
		}
		
		private function expireFruit():void
		{
			scoreable = false;
			
			kill();
		}
		
		private function startFlicker():void
		{
			this.flicker(5);
			
			killTimer.start();
		}
		
	}

}
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
		
		public function Fruit() 
		{
			super(null);
			
			immovable = true;
			
			points = 10;
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
					makeGraphic(32, 32, 0xffFFB07F);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					makeGraphic(32, 32, 0xffFF7F7F);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					makeGraphic(32, 32, 0xffFFFF7F);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					makeGraphic(32, 32, 0xffF7D17B);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					makeGraphic(32, 32, 0xff7FFF7F);
					chargeAmt = 50;
				}
			}
		}
		
		public function setPosAt(targetMidpoint:FlxPoint, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				
				if (_fruitType == "orange")
				{
					makeGraphic(32, 32, 0xffFFB07F);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					makeGraphic(32, 32, 0xffFF7F7F);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					makeGraphic(32, 32, 0xffFFFF7F);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					makeGraphic(32, 32, 0xffF7D17B);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					makeGraphic(32, 32, 0xff7FFF7F);
					chargeAmt = 50;
				}
			}
			
			x = targetMidpoint.x - (this.width / 2);
			y = targetMidpoint.y - (this.height / 2);
		}
		
		public function pickUp(_player:Player):void
		{
			_player.setCharge(chargeAmt);
			
			kill();
		}
		
	}

}
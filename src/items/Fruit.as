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
		private var moveTowardsPlayer:Boolean = false;
		
		private var expired:Boolean = false;
		
		public function Fruit() 
		{
			super(null, null);
			
			immovable = true;
			enableExplosion = false;
			
			points = 10;
			
			flickerTimer = new FlxDelay(15000);
			killTimer = new FlxDelay(5000);
			
			flickerTimer.callback = startFlicker;
			killTimer.callback = expireFruit;
		}
		
		public function setPos(X:int, Y:int, _player:Player, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			this.flicker(0);
			moveTowardsPlayer = false;
			
			x = X;
			y = Y;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				player = _player;
				
				if (_fruitType == "orange")
				{
					loadRotatedGraphic(AssetsRegistry.orangePNG, 1);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					loadRotatedGraphic(AssetsRegistry.applePNG, 1);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					loadRotatedGraphic(AssetsRegistry.bananaPNG, 1);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadRotatedGraphic(AssetsRegistry.pineapplePNG, 1);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadRotatedGraphic(AssetsRegistry.watermelonPNG, 1);
					chargeAmt = 50;
				}
			}
		}
		
		public function setPosAt(targetMidpoint:FlxPoint, _player:Player, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			this.flicker(0);
			moveTowardsPlayer = true;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				player = _player;
				
				if (_fruitType == "orange")
				{
					loadRotatedGraphic(AssetsRegistry.orangePNG, 1);
					chargeAmt = 3;
				}
				
				else if (_fruitType == "apple")
				{
					loadRotatedGraphic(AssetsRegistry.applePNG, 1);
					chargeAmt = 5;
				}
				
				else if (_fruitType == "banana")
				{
					loadRotatedGraphic(AssetsRegistry.bananaPNG, 1);
					chargeAmt = 10;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadRotatedGraphic(AssetsRegistry.pineapplePNG, 1);
					chargeAmt = 20;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadRotatedGraphic(AssetsRegistry.watermelonPNG, 1);
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
			
			_player.overDriveHud.updateOverdriveHud();
			
			kill();
		}
		
		/*
		override public function update():void
		{
			super.update();
			
			if (moveTowardsPlayer)
			{
				angle = GameUtil.easeTowardsTarget(this, player, 8000, 0.1);
			}
		}
		*/
		
		override public function addScore():uint
		{
			var newScoreAmt:uint = player.multiplyFruit(points);
			
			player.score.increaseScore(newScoreAmt);
			
			return newScoreAmt;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			if (flickerTimer)
			{
				flickerTimer.abort();
				flickerTimer = null;
			}
			
			if (killTimer)
			{
				killTimer.abort();
				killTimer = null;
			}
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
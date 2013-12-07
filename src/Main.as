package 
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import flash.events.Event;
	import com.newgrounds.components.*;

	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame 
	{
		
		public function Main():void 
		{
			
			super(640, 480, PlayState, 1, 60, 60, true);
			
			forceDebugger = true;
		}
		
		
		override protected function create(FlashEvent:Event):void
		{
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE, onFocusLost);
			stage.removeEventListener(Event.ACTIVATE, onFocus);
			
			var medalPopup:MedalPopup = new MedalPopup();
            medalPopup.x = FlxG.width / 2 - medalPopup.width / 2;
			medalPopup.y = FlxG.height - medalPopup.height;
            stage.addChild(medalPopup);
		}
		

	}

}
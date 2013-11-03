package 
{
	import org.flixel.system.*;
	import com.newgrounds.*;
	
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Preloader extends FlxPreloader
	{
		public function Preloader():void
		{
			className = "Main";
			super();
			
			// Connect to Newgrounds
			API.connect(root, "34103:OfiTg172", "JUvXldRciZHRadgHTVooQEvoMGBgH4hY");
		}
	}
}
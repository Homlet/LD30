package uk.co.homletmoo.ld30
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld30.world.SplashWorld;
	
	[SWF (width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * Main engine class.
	 * 
	 * @author Homletmoo
	 */
	public class Main extends Engine 
	{
		public static const WIDTH:uint = 800;
		public static const HEIGHT:uint = 600;
		public static const SCALE:uint = 4;
		
		
		public function Main()
		{
			super(WIDTH, HEIGHT, 60, false);
			
			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
			
			FP.world = new SplashWorld();
		}
		
		override public function init():void
		{
		}
	}
}

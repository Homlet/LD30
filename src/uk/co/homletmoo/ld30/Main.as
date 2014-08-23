package uk.co.homletmoo.ld30
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	
	[SWF (width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine 
	{
		public function Main()
		{
			super(800, 600, 60, false);
			
			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
			
			// TODO: FP.world = ...
		}
		
		override public function init():void
		{
		}
	}
}

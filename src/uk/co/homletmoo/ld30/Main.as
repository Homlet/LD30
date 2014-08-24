package uk.co.homletmoo.ld30
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.assets.Sounds;
	import uk.co.homletmoo.ld30.world.LevelWorld;
	
	[SWF (width = "800", height = "600", backgroundColor = "#523e29")]
	
	/**
	 * Main engine class.
	 * 
	 * @author Homletmoo
	 */
	public class Main extends Engine 
	{	
		public static var instance:Main;
		
		public static const WIDTH:uint = 800;
		public static const HEIGHT:uint = 600;
		public static const SCALE:uint = 4;
		
		public var current_amt:Number;
		public var last_dir:Number;
		
		public function Main()
		{
			super(WIDTH, HEIGHT, 60);
			
			instance = this;
			
			current_amt = 0.0;
			last_dir = 0.0;
			
			//FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
			Controls.register();
			Sounds.load();
			FP.world = new LevelWorld(6);
		}
		
		public function tilt(amount:Number, direction:Number=NaN):void
		{
			if (direction != direction) { direction = last_dir; }
			last_dir = direction;
			current_amt += (amount - current_amt) / 20;
			transform.matrix3D = new Matrix3D();
			var dir_v:Vector3D = new Vector3D(
				Math.cos(direction / 180 * Math.PI),
				-Math.sin(direction / 180 * Math.PI)
			)
			transform.matrix3D.appendRotation(
				current_amt,
				dir_v,
				new Vector3D((1 - dir_v.y) * WIDTH / 2, (dir_v.x + 1) * HEIGHT / 2, 0, 1)
			);
		}
	}
}

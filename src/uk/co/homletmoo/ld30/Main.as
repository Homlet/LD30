package uk.co.homletmoo.ld30
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld30.assets.Controls;
	import uk.co.homletmoo.ld30.assets.Images;
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
		
		public var dir:uint = 0;
		
		public function Main()
		{
			super(WIDTH, HEIGHT, 60);
			
			instance = this;
			
			//FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
			Controls.register();
			FP.world = new LevelWorld(0);
		}
		
		override public function update():void
		{
			tilt(10, dir++);
			super.update();
		}
		
		public function tilt(amount:Number, direction:Number):void
		{
			var matrix:Matrix3D = new Matrix3D();
			var dir_v:Vector3D = new Vector3D(Math.cos(direction / 180 * Math.PI), -Math.sin(direction / 180 * Math.PI))
			matrix.appendRotation(
				amount,
				dir_v,
				new Vector3D((1 - dir_v.y) * WIDTH / 2, (dir_v.x + 1) * HEIGHT / 2, 0, 1)
			);
			transform.matrix3D = matrix;
		}
	}
}

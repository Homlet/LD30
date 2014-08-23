package uk.co.homletmoo.ld30.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld30.assets.Controls;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.Main;
	import uk.co.homletmoo.ld30.Utils;
	
	/**
	 * A marble that accelerates with the arrow keys.
	 * 
	 * @author Homletmoo
	 */
	public class Marble extends Entity
	{
		public static const G:Number = 980; // Pixels per second per second.
		public static const MU:Number = 0.08;
		public static const RESTITUTION:Number = 0.5;
		public static const SLOPE:Number = (1 - MU * Math.sqrt(3)) / 2;
		
		private var image:Image;
		
		private var velocity:Point;
		
		public function Marble(x:int, y:int) 
		{
			super(x + 2, y + 2);
			setHitbox(24, 24, -4, -4);
			type = "marble";
			
			image = new Image(Images.MARBLE);
			image.scale = Main.SCALE;
			graphic = image;
			
			velocity = new Point();
		}
		
		override public function update():void
		{
			var up:Boolean = Input.check(Controls.UP);
			var left:Boolean = Input.check(Controls.LEFT);
			var down:Boolean = Input.check(Controls.DOWN);
			var right:Boolean = Input.check(Controls.RIGHT);
			
			if (up)   { velocity.y -= G * SLOPE * FP.elapsed; }
			if (down) { velocity.y += G * SLOPE * FP.elapsed; }
			if (left)  { velocity.x -= G * SLOPE * FP.elapsed; }
			if (right) { velocity.x += G * SLOPE * FP.elapsed; }
			
			var friction:Number = G * MU * FP.elapsed;
			if (!Utils.xor(up, down))
			{
				if (Math.abs(velocity.y) >= friction)
				{
					velocity.y -= friction * (velocity.y / Math.abs(velocity.y));
				} else
				{
					velocity.y = 0;
				}
			}
			if (!Utils.xor(left, right))
			{
				if (Math.abs(velocity.x) > friction)
				{
					velocity.x -= friction * (velocity.x / Math.abs(velocity.x));
				} else
				{
					velocity.x = 0;
				}
			}
			
			var dx:int = int(right) - int(left);
			var dy:int = int(down) - int(up);
			if (up || left || down || right)
			{
				Main.instance.tilt(10, Math.atan2(dx, dy) / Math.PI * 180);
			} else
			{
				Main.instance.tilt(0);
			}
			
			moveBy(velocity.x * FP.elapsed, velocity.y * FP.elapsed, "wall");
		}
		
		override public function moveCollideX(other:Entity):Boolean 
		{
			if (Math.abs(velocity.x) > 30)
			{
				velocity.x *= -RESTITUTION;
			} else
			{
				velocity.x = 0;
			}
			
			return true;
		}
		
		override public function moveCollideY(other:Entity):Boolean 
		{
			if (Math.abs(velocity.y) > 30)
			{
				velocity.y *= -RESTITUTION;
			} else
			{
				velocity.y = 0;
			}
			
			return true;
		}
	}
}

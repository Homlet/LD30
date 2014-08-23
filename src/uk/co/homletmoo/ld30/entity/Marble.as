package uk.co.homletmoo.ld30.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A marble that accelerates with the arrow keys.
	 * 
	 * @author Homletmoo
	 */
	public class Marble extends Entity
	{
		public function Marble(x:int, y:int) 
		{
			super(x, y, Image.createCircle(20, 0xFF));
			setHitboxTo(graphic);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}

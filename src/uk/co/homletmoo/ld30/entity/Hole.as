package uk.co.homletmoo.ld30.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Pixelmask;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.Main;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Hole extends Entity 
	{
		public function Hole(x:uint, y:uint) 
		{
			super(x, y);
			mask = new Pixelmask(Images.HOLE_MASK);
			type = "hole";
		}
	}
}

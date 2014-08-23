package uk.co.homletmoo.ld30.entity 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Hole extends Entity 
	{
		public function Hole(x:uint, y:uint) 
		{
			super(x, y);
			setHitbox(16, 16, -12, -12);
			type = "hole";
		}
	}
}

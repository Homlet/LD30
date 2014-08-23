package uk.co.homletmoo.ld30.entity 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Target extends Entity
	{
		private var lit:Boolean;
		
		public function Target(x:uint, y:uint) 
		{
			super(x, y);
			setHitbox(4, 4, -18, -18);
			
			lit = false;
		}
		
		override public function update():void
		{
			lit = (collide("marble", x, y) != null);
		}
		
		public function is_lit():Boolean
		{
			return lit;
		}
	}
}

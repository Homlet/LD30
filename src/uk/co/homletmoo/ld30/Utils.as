package uk.co.homletmoo.ld30 
{
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Utils 
	{
		public static function xor(a:Boolean, b:Boolean):Boolean
		{
			return !(a && b) && (a || b);
		}
	}
}

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
		
		public static function time_format(seconds:uint):String
		{
			var minutes:uint = seconds / 60;
			seconds = seconds % 60;
			
			return minutes.toString() + ":" + zero_pad(seconds, 2);
		}
		
		public static function zero_pad(input:uint, length:uint):String
		{
			var output:String = input.toString();
			length -= output.length;
			while (length--) { output = "0".concat(output); }
			return output;
		}
		
		public static function pan(x:Number, width:Number):Number
		{
			return (3 * x) / width - 1.5;
		}
	}
}

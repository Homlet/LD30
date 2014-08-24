package uk.co.homletmoo.ld30.assets 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Sounds 
	{
		[Embed (source = "sounds/hole1.mp3")]
		public static var HOLE_1_RAW:Class;
		public static var HOLE_1:Sfx;
		
		[Embed (source = "sounds/hole2.mp3")]
		public static var HOLE_2_RAW:Class;
		public static var HOLE_2:Sfx;
		
		[Embed (source = "sounds/hole3.mp3")]
		public static var HOLE_3_RAW:Class;
		public static var HOLE_3:Sfx;
		
		public static var HOLES:Array;
		
		[Embed (source = "sounds/hit1.mp3")]
		public static var HIT_1_RAW:Class;
		public static var HIT_1:Sfx;
		
		[Embed (source = "sounds/hit2.mp3")]
		public static var HIT_2_RAW:Class;
		public static var HIT_2:Sfx;
		
		[Embed (source = "sounds/hit3.mp3")]
		public static var HIT_3_RAW:Class;
		public static var HIT_3:Sfx;
		
		[Embed (source = "sounds/hit4.mp3")]
		public static var HIT_4_RAW:Class;
		public static var HIT_4:Sfx;
		
		[Embed (source = "sounds/hit5.mp3")]
		public static var HIT_5_RAW:Class;
		public static var HIT_5:Sfx;
		
		[Embed (source = "sounds/hit6.mp3")]
		public static var HIT_6_RAW:Class;
		public static var HIT_6:Sfx;
		
		[Embed (source = "sounds/hit7.mp3")]
		public static var HIT_7_RAW:Class;
		public static var HIT_7:Sfx;
		
		[Embed (source = "sounds/hit8.mp3")]
		public static var HIT_8_RAW:Class;
		public static var HIT_8:Sfx;
		
		public static var HITS:Array;
		
		[Embed (source = "sounds/roll.mp3")]
		public static var ROLL_RAW:Class;
		public static var ROLL:Sfx;
		
		
		public static function load():void
		{
			HOLE_1 = new Sfx(HOLE_1_RAW);
			HOLE_2 = new Sfx(HOLE_2_RAW);
			HOLE_3 = new Sfx(HOLE_3_RAW);
			HOLES = [0, HOLE_1, HOLE_2, HOLE_3];
			
			HIT_1 = new Sfx(HIT_1_RAW);
			HIT_2 = new Sfx(HIT_2_RAW);
			HIT_3 = new Sfx(HIT_3_RAW);
			HIT_4 = new Sfx(HIT_4_RAW);
			HIT_5 = new Sfx(HIT_5_RAW);
			HIT_6 = new Sfx(HIT_6_RAW);
			HIT_7 = new Sfx(HIT_7_RAW);
			HIT_8 = new Sfx(HIT_8_RAW);
			HITS = [0, HIT_1, HIT_2, HIT_3, HIT_4, HIT_5, HIT_6, HIT_7, HIT_8];
			
			ROLL = new Sfx(ROLL_RAW);
		}
		
		public static function play_next(array:Array, volume:Number=1.0):void
		{
			(array[array[0] + 1] as Sfx).play(volume);
			array[0] = (array[0] + 1) % (array.length - 1);
		}
	}
}

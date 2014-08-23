package uk.co.homletmoo.ld30.assets 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Stores static references to image sources.
	 * 
	 * @author Homletmoo
	 */
	public class Images 
	{		
		// Images:
		[Embed (source = "images/hm.png")] public static var HM_LOGO:Class;
		[Embed (source = "images/flashpunk.png")] public static var FP_LOGO:Class;
		[Embed (source = "images/tiles.png")] public static var TILES:Class;
		[Embed (source = "images/marble.png")] public static var MARBLE:Class;
		[Embed (source = "images/hole_mask.png")] public static var HOLE_MASK:Class;
		
		// Levels:
		[Embed (source = "levels/01.png")] public static var LVL_01:Class;
		[Embed (source = "levels/02.png")] public static var LVL_02:Class;
		[Embed (source = "levels/03.png")] public static var LVL_03:Class;
		[Embed (source = "levels/04.png")] public static var LVL_04:Class;
		[Embed (source = "levels/05.png")] public static var LVL_05:Class;
		[Embed (source = "levels/06.png")] public static var LVL_06:Class;
		[Embed (source = "levels/07.png")] public static var LVL_07:Class;
		public static const LEVELS:Array = [LVL_01, LVL_02, LVL_03, LVL_04, LVL_05, LVL_06, LVL_07];
		
		
		public static var cache:Dictionary;
		public static function scale(source:Class, factor:uint):BitmapData
		{
			if (cache == null) { cache = new Dictionary(); }
			if (cache[source] != null) { return cache[source]; }
			
			var bitmap:BitmapData = FP.getBitmap(source);
			
			var width:uint = (bitmap.width * factor) || 1;
			var height:uint = (bitmap.height * factor) || 1;
			
			var scaled:BitmapData = new BitmapData(width, height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(factor, factor);
			scaled.draw(bitmap, matrix);
			
			cache[source] = scaled;
			
			return scaled;
		}
	}
}

package uk.co.homletmoo.ld30.world 
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.entity.Marble;
	import uk.co.homletmoo.ld30.Main;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class LevelWorld extends World
	{
		public static const TILE_WALL:uint = 0;
		public static const TILE_GROUND:uint = 1;
		public static const TILE_START:uint = 2;
		public static const TILE_END:uint = 3;
		
		private var bitmap:BitmapData;
		private var background:Tilemap;
		private var tile_size:uint;
		
		private var marbles:Array;
		
		
		public function LevelWorld(source:Class) 
		{
			bitmap = FP.getBitmap(source);
			tile_size = 10 * Main.SCALE;
			background = new Tilemap(
				Images.scale(Images.TILES, Main.SCALE),
				bitmap.width * tile_size,
				bitmap.height * tile_size,
				tile_size, tile_size
			);
			
			marbles = new Array();
			
			for (var i:uint = 0; i < bitmap.width; i++)
			for (var j:uint = 0; j < bitmap.height; j++)
			{
				var value:uint = map_pixel(bitmap.getPixel(i, j));
				background.setTile(i, j, value);
				
				if (value == TILE_START)
				{
					marbles.push(new Marble(i * tile_size, j * tile_size));
				}
			}
		}
		
		override public function begin():void
		{
			addGraphic(background);
			
			for each (var marble:Marble in marbles) { add(marble); }
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public static function map_pixel(color:uint):uint
		{
			switch (color)
			{
			case 0: return TILE_WALL;
			case 0xFFFFFF: return TILE_GROUND;
			case 0xFF0000: return TILE_START;
			case 0x00FF00: return TILE_END;
			default: return TILE_WALL;
			}
		}
	}
}

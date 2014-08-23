package uk.co.homletmoo.ld30.world 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.entity.Marble;
	import uk.co.homletmoo.ld30.entity.Target;
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
		public static const TILE_HOLE:uint = 4;
		
		private var index:uint;
		private var bitmap:BitmapData;
		private var background:Tilemap;
		private var collision:Entity;
		private var tile_size:uint;
		
		private var marbles:Array;
		private var targets:Array;
		
		
		public function LevelWorld(index:uint) 
		{
			this.index = index;
			bitmap = FP.getBitmap(Images.LEVELS[index]);
			tile_size = 10 * Main.SCALE;
			background = new Tilemap(
				Images.scale(Images.TILES, Main.SCALE),
				bitmap.width * tile_size,
				bitmap.height * tile_size,
				tile_size, tile_size
			);
			collision = new Entity(0, 0, null, new Grid(
				bitmap.width * tile_size,
				bitmap.height * tile_size,
				tile_size, tile_size
			));
			collision.type = "wall";
			
			marbles = new Array();
			targets = new Array();
			
			for (var i:uint = 0; i < bitmap.width; i++)
			for (var j:uint = 0; j < bitmap.height; j++)
			{
				var value:uint = map_pixel(bitmap.getPixel(i, j));
				background.setTile(i, j, value);
				
				if (value == TILE_WALL)
				{
					(collision.mask as Grid).setTile(i, j, true);
				}
				if (value == TILE_START)
				{
					marbles.push(new Marble(i * tile_size, j * tile_size));
				}
				if (value == TILE_END)
				{
					targets.push(new Target(i * tile_size, j * tile_size));
				}
			}
		}
		
		override public function begin():void
		{
			addGraphic(background);
			add(collision);
			
			for each (var marble:Marble in marbles) { add(marble); }
			for each (var target:Target in targets) { add(target); }
		}
		
		override public function update():void
		{
			var needed:uint = targets.length;
			for each (var target:Target in targets) {
				if (target.is_lit()) { needed-- };
			}
			
			if (!needed) { FP.world = new LevelWorld(index + 1); }
			
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
			case 0x0000FF: return TILE_HOLE;
			default: return TILE_WALL;
			}
		}
	}
}

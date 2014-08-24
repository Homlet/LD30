package uk.co.homletmoo.ld30.world 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.assets.Sounds;
	import uk.co.homletmoo.ld30.entity.Hole;
	import uk.co.homletmoo.ld30.entity.Marble;
	import uk.co.homletmoo.ld30.entity.Target;
	import uk.co.homletmoo.ld30.Main;
	import uk.co.homletmoo.ld30.Utils;
	
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
		private var holes:Array;
		
		private var seconds:Number;
		private var time_text:Text;
		
		
		public function LevelWorld(index:uint, seconds:Number=0.0) 
		{
			this.index = index;
			this.seconds = seconds;
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
			holes = new Array();
			
			for (var i:uint = 0; i < bitmap.width; i++)
			for (var j:uint = 0; j < bitmap.height; j++)
			{
				var value:uint = map_pixel(bitmap.getPixel(i, j));
				background.setTile(i, j, value);
				
				switch (value)
				{
				case TILE_WALL:
					(collision.mask as Grid).setTile(i, j, true);
					break;
				
				case TILE_START:
					marbles.push(new Marble(i * tile_size, j * tile_size));
					break;
				
				case TILE_END:
					targets.push(new Target(i * tile_size, j * tile_size));
					break;
				
				case TILE_HOLE:
					holes.push(new Hole(i * tile_size, j * tile_size));
					break;
				
				default: break;
				}
			}
			
			time_text = new Text(Utils.time_format(seconds), 4, 4);
			time_text.color = 0xEDCF9B;
			time_text.scale = Main.SCALE;
			time_text.size = 8;
		}
		
		override public function begin():void
		{
			addGraphic(background);
			addGraphic(time_text);
			add(collision);
			
			if (!Sounds.ROLL.playing) { Sounds.ROLL.loop(0); }
			Sounds.BELL.play(2);
			
			for each (var marble:Marble in marbles) { add(marble); }
			for each (var target:Target in targets) { add(target); }
			for each (var hole:Hole in holes) { add(hole); }
		}
		
		override public function update():void
		{
			super.update();
			
			seconds += FP.elapsed;
			time_text.text = Utils.time_format(uint(seconds));
			
			// Are all the targets lit?
			var needed:uint = targets.length;
			for each (var target:Target in targets) {
				if (target.is_lit()) { needed-- };
			}
			
			if (!needed)
			{
				if (index == Images.LEVELS.length - 1)
				{
					FP.world = new EndWorld(seconds);
				} else
				{
					FP.world = new LevelWorld(index + 1, seconds);
				}
			} 
			
			// Marbles fall into holes.
			var avg_speed:Number = 0.0;
			for each (var marble:Marble in marbles)
			{
				// Determine volume of rolling sound.
				avg_speed += marble.get_speed();
				
				var hole:Hole = (marble.collide("hole", marble.x, marble.y) as Hole);
				if (hole != null)
				{
					var f:Function = function(m:Marble, ...rest):void { m.reset(hole); }
					marbles.forEach(f);
					Sounds.play_next(Sounds.HOLES, 1, Utils.pan(hole.x, Main.WIDTH));
				}
			}
			
			// Dividing by zero is bad.
			if (marbles.length > 0)
			{
				avg_speed /= marbles.length;
				Sounds.ROLL.volume += (Ease.sineIn(avg_speed / 200) - Sounds.ROLL.volume) / 5;
				Sounds.ROLL.volume = Math.min(Sounds.ROLL.volume, 1.0);
			}
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

package uk.co.homletmoo.ld30.world 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.assets.Sounds;
	import uk.co.homletmoo.ld30.Main;
	import uk.co.homletmoo.ld30.Utils;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class EndWorld extends World 
	{
		public static const PAR:Number = 160;
		public static const HM:Number = 123;
		
		private var backdrop:Backdrop;
		private var image:Image;
		
		private var seconds:Number;
		private var score_text:Text;
		private var par_text:Text;
		private var hm_text:Text;
		
		private var buffer:Number;
		
		public function EndWorld(seconds:Number=0.0) 
		{			
			backdrop = new Backdrop(Images.scale(Images.BACKGROUND, Main.SCALE));
			
			image = new Image(Images.FOREGROUND);
			image.scale = Main.SCALE;
			
			this.seconds = seconds;
			
			score_text = new Text("Your score: " + Utils.time_format(seconds), 0, 210);
			score_text.color = 0x040200;
			score_text.scale = Main.SCALE;
			score_text.size = 16;
			score_text.x = (Main.WIDTH - score_text.scaledWidth) / 2;
			
			par_text = new Text("Par: " + Utils.time_format(PAR), 0, 290);
			par_text.color = 0x271603;
			par_text.scale = Main.SCALE;
			par_text.size = 16;
			par_text.x = (Main.WIDTH - par_text.scaledWidth) / 2;
			
			hm_text = new Text("Homletmoo: " + Utils.time_format(HM), 0, 370);
			hm_text.color = 0x271603;
			hm_text.scale = Main.SCALE;
			hm_text.size = 16;
			hm_text.x = (Main.WIDTH - hm_text.scaledWidth) / 2;
			
			buffer = 0.0;
		}
		
		override public function begin():void
		{
			addGraphic(backdrop);
			addGraphic(image);
			addGraphic(score_text);
			addGraphic(par_text);
			addGraphic(hm_text);
			
			Sounds.BELL.play(2);
		}
		
		override public function update():void
		{
			super.update();
			
			buffer += FP.elapsed;
			
			if (Input.released(Key.ANY) && buffer >= 3.0)
			{
				FP.world = new LevelWorld(0);
			}
			
			backdrop.x -= FP.elapsed * 50;
		}
	}
}

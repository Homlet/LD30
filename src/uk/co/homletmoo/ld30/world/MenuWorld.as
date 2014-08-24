package uk.co.homletmoo.ld30.world 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.Main;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class MenuWorld extends World 
	{
		private var backdrop:Backdrop;
		private var image:Image;
		
		public function MenuWorld() 
		{
			backdrop = new Backdrop(Images.scale(Images.BACKGROUND, Main.SCALE));
			backdrop.alpha = 0;
			
			image = new Image(Images.TITLE);
			image.scale = Main.SCALE;
			image.alpha = 0;
		}
		
		override public function begin():void
		{
			addGraphic(backdrop);
			addGraphic(image);
			
			FP.tween(backdrop, {alpha: 1}, 0.8, {easing: Ease.expoIn});
			FP.tween(image, {alpha: 1}, 0.8, {easing: Ease.expoIn});
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.released(Key.ANY)) { FP.world = new LevelWorld(0); }
			
			backdrop.x -= FP.elapsed * 50;
		}
	}
}

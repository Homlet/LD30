package uk.co.homletmoo.ld30.world 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld30.assets.Images;
	import uk.co.homletmoo.ld30.Main;
	
	/**
	 * Displays the HM and FlashPunk logos in sequence, then changes the world.
	 * 
	 * @author Homletmoo
	 */
	public class SplashWorld extends World 
	{
		private var hm_logo:Image;
		
		private var tweens:Array;
		private var stage:uint;
		
		
		public function SplashWorld() 
		{
			hm_logo = new Image(Images.HM_LOGO);
			hm_logo.scale = Main.SCALE * 2;
			hm_logo.alpha = 0.0;
			hm_logo.centerOrigin();
			
			tweens = [
				function():void { FP.tween(hm_logo, {alpha: 1}, 1, {complete: next, easing: Ease.expoIn}); },
				function():void { FP.tween(null, null, 1.25, {complete: next}); },
				function():void { FP.tween(hm_logo, {alpha: 0}, 0.5, {complete: next}); },
				function():void { done(); }
			];
		}
		
		override public function begin():void
		{
			addGraphic(hm_logo, 0, Main.WIDTH / 2, Main.HEIGHT / 2);
			
			tweens[0]();
		}
		
		private function next():void
		{
			tweens[++stage]();
		}
		
		private function done():void
		{
			// TODO@ FP.world = new ...World();
		}
	}
}

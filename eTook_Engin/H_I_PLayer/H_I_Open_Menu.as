package  eTook_Engin.H_I_PLayer{
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	public class H_I_Open_Menu extends MovieClip{
		private var MX:Number = MovieClip(parent).x
		private var MLX:Number = MovieClip(parent.parent).MovieList.x
		private var isOpen:Boolean = false;
		private var MOVE_VALUE = MovieClip(parent.parent).MovieList.width - 2;
		private var tw:TweenMax
		public function H_I_Open_Menu() {
			start_()
		}
		public function start_()
		{
			addEvent();
		}
		public function distory()
		{
			removeEvent();
		}
		private function addEvent()
		{
			this.addEventListener(MouseEvent.CLICK,MC)
		}
		private function removeEvent()
		{
			this.removeEventListener(MouseEvent.CLICK,MC)
		}
		private function MC(e:MouseEvent)
		{
			
			
			kill();
			if(!isOpen)
			{
				isOpen = true;
				tw = TweenMax.to(MovieClip(parent),0.3,{x:MX-MOVE_VALUE})
			}else
			{
				isOpen = false;
				tw = TweenMax.to(MovieClip(parent),0.3,{x:MX })
			}
		}
		private function kill()
		{
			if(tw)
				tw.kill();
		}

	}
}
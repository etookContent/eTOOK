package  eTook_Engin.H_I_Interactive{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;

	public class H_I_Interactive_Button extends MovieClip{
		private var x_:Number;
		private var y_:Number;
		private var tw:TweenMax
		public function H_I_Interactive_Button() 
		{
			// constructor code
			start_();
		}
		public function start_()
		{
			
			MovieClip(parent).stop();
			x_ = target_mc.x
			y_ = target_mc.y
			addEvent();
		}
		public function dispose()
		{
			removeEvent()
		}
		private function addEvent()
		{
			target_mc.addEventListener(MouseEvent.MOUSE_DOWN,MDown)
		}
		private function removeEvent()
		{
			target_mc.removeEventListener(MouseEvent.MOUSE_DOWN,MDown)
			this.removeEventListener(MouseEvent.MOUSE_MOVE,MMOVE)
			this.removeEventListener(MouseEvent.MOUSE_UP,MUP)
		}
		private function MDown(e:MouseEvent)
		{
			target_mc.removeEventListener(MouseEvent.MOUSE_DOWN,MDown)
			this.addEventListener(MouseEvent.MOUSE_MOVE,MMOVE)
			this.addEventListener(MouseEvent.MOUSE_UP,MUP)
		}
		private function MMOVE(e:MouseEvent)
		{
			target_mc.x = mouseX;
			target_mc.y = mouseY;
		}
		private function MUP(e:MouseEvent)
		{
			target_mc.addEventListener(MouseEvent.MOUSE_DOWN,MDown)
			this.removeEventListener(MouseEvent.MOUSE_MOVE,MMOVE)
			this.removeEventListener(MouseEvent.MOUSE_UP,MUP)
			kill();
			if(target_mc.hitTestObject(sible_mc))
			{
				target_mc.x = sible_mc.x+(sible_mc.width/2)
				target_mc.y = sible_mc.y+(sible_mc.height/2)
				dispose();
				MovieClip(this.parent).play();
			}
			else
				tw = TweenMax.to(target_mc,0.3,{x:x_,y:y_})
		}
		private function kill()
		{
			if(tw)
				tw.kill();
		}
	}
}
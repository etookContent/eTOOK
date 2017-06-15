package eTook_Engin.H_I_Exam.H_I_Drag_Drop{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import eTook_Engin.H_I_Sound.H_I_Sound_Attach;
	
	public class H_I_Drag_Drop_point extends MovieClip{

		private var count:Number = 0;
		private var PX:Number = 0;
		private var PY:Number = 0;
		private var tw:TweenMax;
		public function H_I_Drag_Drop_point() 
		{
			//start_()
		}
		public function start_()
		{
			this.visible = false;
			PX= MovieClip(parent).x;
			PY= MovieClip(parent).y;
			addEvent();
		}
		public function dispose()
		{
			
		}
		private function addEvent()
		{
			this.parent.addEventListener(MouseEvent.MOUSE_DOWN,MD);
		}
		private function removeEvent()
		{
			this.parent.removeEventListener(MouseEvent.MOUSE_DOWN,MD);
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_MOVE,MM);
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_UP,MU);
		}
		private function MD(e:MouseEvent)
		{
			//trace("MD")
			this.parent.removeEventListener(MouseEvent.MOUSE_DOWN,MD);
			H_I_Value.STAGE.addEventListener(MouseEvent.MOUSE_MOVE,MM);
			H_I_Value.STAGE.addEventListener(MouseEvent.MOUSE_UP,MU);
		}
		private function MM(e:MouseEvent)
		{
			//trace("MM")
			MovieClip(this.parent).x = MovieClip(this.parent.parent).mouseX;
			MovieClip(this.parent).y = MovieClip(this.parent.parent).mouseY;
		}
		private function MU(e:MouseEvent)
		{
			//trace("MU")
			removeEvent();
			addEvent();
			check_Ans();
		}
		private function check_Ans()
		{
			kill();
			var str:String = "true"
			removeEvent()
			var str_hit:String = hit();
			if(str_hit==("ans"+this.parent.name.substr(8)))
			{
				MovieClip(parent.parent).addScore();
				MovieClip(this.parent.parent).getChildByName("tick"+this.parent.name.substr(8)).visible = true;
				tw = TweenMax.to(MovieClip(this.parent) ,0.3,{x:MovieClip(parent.parent).getChildByName("ans"+this.parent.name.substr(8)).x+MovieClip(this.parent).height+100})
				MovieClip(this.parent).y = MovieClip(parent.parent).getChildByName("ans"+this.parent.name.substr(8)).y
				active_sound(true);
			}else
			{
				MovieClip(parent.parent).subScore();
				str = "false"
				tw = TweenMax.to(MovieClip(this.parent),0.3,{x:PX,y:PY,onComplete:complete_})
				active_sound(false);
			}
			if(str_hit!= "null")
				MovieClip(MovieClip(parent.parent).getChildByName(str_hit)).gotoAndStop(str)
		}
		private function complete_()
		{
			addEvent();
		}
		private function kill()
		{
			if(tw)
				tw.kill();
		}
		private function active_sound(isTrue:Boolean)
		{
			if(isTrue)
				H_I_Sound_Attach.start_("correct_snd");
			else
				H_I_Sound_Attach.start_("incorrect_snd");
		}
		private function hit():String
		{
			var str:String = "null";
			for(var i = 1;;i++)
			{
				if(MovieClip(this.parent.parent).getChildByName("ans"+i)==null)
					break;
				else if(this.hitTestObject(MovieClip(this.parent.parent).getChildByName("ans"+i)))
					str ="ans"+i.toString();
					
				count+=1
			}
			return str
		}
	}
}
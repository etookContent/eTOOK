package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import eTook_Engin.H_I_Value.H_I_Value;
	
	public class H_I_VideoText extends MovieClip{
		private var TF:TextFormat;
		public var isCliCK:Boolean = false;
		public function H_I_VideoText() 
		{
			start_()
		}
		public function start_()
		{
			
			addEvent()
			/*if(this.name=="v1")
			{
				MC(null)
			}*/
		}
		public function dispose()
		{
			removeEvent();
		}
		private function addEvent()
		{
			this.addEventListener(MouseEvent.CLICK,MC);
			this.addEventListener(MouseEvent.ROLL_OVER,ROV);
			this.addEventListener(MouseEvent.ROLL_OUT,ROU);
		}
		private function removeEvent()
		{
			this.removeEventListener(MouseEvent.CLICK,MC);
			this.removeEventListener(MouseEvent.ROLL_OVER,ROV);
			this.removeEventListener(MouseEvent.ROLL_OUT,ROU);
		}
		public function MC(e:MouseEvent)
		{
			isCliCK = true;
			removeEvent();
			MovieClip(parent.parent).manageButton(name);
			TF = new TextFormat();
			TF.color =0xFFFF00
			me.setTextFormat(TF);
			//trace("v l "+(String(H_I_Value.video_Array[H_I_Value.Index-1].video[Number(name.substr(1))-1].@src)))	
			MovieClip(parent.parent).start_Video(String(H_I_Value.video_Array[H_I_Value.Index-1].video[Number(name.substr(1))-1].@src))
			MovieClip(parent.parent).Current_index = Number(this.name.substr(1))
			MovieClip(parent.parent).check_visible_button();
		}
		private function ROV(e:MouseEvent)
		{
			TF = new TextFormat();
			TF.color =0x0066FF
			
			me.setTextFormat(TF)
		}
		private function ROU(e:MouseEvent)
		{
			TF = new TextFormat();
			TF.color = 0x0FFFFFF
			me.setTextFormat(TF)
		}
		public function reset()
		{
			isCliCK = false;
			addEvent();
			ROU(null)
		}
	}
}
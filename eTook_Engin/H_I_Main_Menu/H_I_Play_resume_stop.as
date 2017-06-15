package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import eTook_Engin.H_I_Value.H_I_Value;
	
	public class H_I_Play_resume_stop extends MovieClip{

		public function H_I_Play_resume_stop() {
			start_();
		}
		public function start_()
		{
			//trace(PR_btn.me)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.Reset,reset_);
			PR_btn.addEventListener(MouseEvent.CLICK,P_R_S_F);
			stop_btn.addEventListener(MouseEvent.CLICK,P_R_S_F);
		}
		public function dispose()
		{
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.Reset,reset_);
			PR_btn.removeEventListener(MouseEvent.CLICK,P_R_S_F);
			stop_btn.removeEventListener(MouseEvent.CLICK,P_R_S_F);
		}
		private function PRF(e:MouseEvent)
		{
			//trace("play")
		}
		public function reset_(e:Event)
		{
			PR_btn.gotoAndStop(2)
			MovieClip(parent).isPause = false;
			MovieClip(parent).isPlay = true;
		}
		public function PR_btn_f()
		{
			H_I_Value.BUTTON_PLAYER_CLICK = "PR_btn"
			if(PR_btn.currentFrame==2)
			{
				PR_btn.gotoAndStop(1)
				MovieClip(parent).isPause = true;
			}else
			{
				PR_btn.gotoAndStop(2)
				MovieClip(parent).isPause = false;
			}
			this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true));
		}
		private function P_R_S_F(e:MouseEvent)
		{
			//trace(e.currentTarget.name)
			switch(e.currentTarget.name)
			{
				case "PR_btn":
					//PR_btn.me.removeEventListener(MouseEvent.CLICK,P_R_S_F);
					PR_btn_f()
					//PR_btn.me.addEventListener(MouseEvent.CLICK,P_R_S_F);
				break;
				case "stop_btn":
						MovieClip(parent).isPause = true;
						H_I_Value.BUTTON_PLAYER_CLICK = "stop_btn"
						this.dispatchEvent(new Event(h_i_Event_eTook.STOP,true));
						PR_btn.gotoAndStop(1)
				break;
			}
			
		}
	}
	
}

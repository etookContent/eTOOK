package  eTook_Engin.H_I_PLayer{
	import flash.events.Event;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Loadear.H_I_LoaderManager;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;

	public class H_I_Timeline_Seek extends H_I_Seek_Base{

		public function H_I_Timeline_Seek()
		{
			
			isVideo = true;
			start_();
			ACtion_Function = setSlidTime;
			Action_Function_UP = setTimeAndPlay
		}
		override public function start_()
		{
			//m_width = H_I_Value.projress_current_menu[H_I_Value.Index-1];
			baseX = this.x
			super.start_();
			addEvent()
		}
		override public function dispose()
		{
			super.dispose();
			removeEvent()
		}
		private function addEvent()
		{
			
		}
		private function removeEvent()
		{
			
		}
		private function setSlidTime()
		{
			H_I_Value.IS_MOUSE_UP = false;
			var cnt:Number = 0
			
			if(MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0)).totalFrames==1)
			{
				
				//lnght_ = MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0)).content_mc.totalFrames
				cnt= lnght_ /100
				
				MovieClip(MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0))).content_mc.gotoAndPlay(Math.round(cnt*location_))
			}else
			{
				
				//lnght_ = H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0).totalFrames
				cnt = lnght_ /100
				if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
					MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0)).gotoAndPlay(Math.round(cnt*location_))
				else
					MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0)).rdcmndGotoFrameAndResume = Math.round(cnt*location_)
			}
			//MovieClip(parent).viteSlideTime_txt.text = Math.round(cnt / this.stage.frameRate/60)
			
			//H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.Reset,true));
			//trace("ppppppppppppppppppppppppppppp")
		}
		private function find_contetnt()
		{
			
		}
		private function setTimeAndPlay()
		{
			H_I_Value.IS_MOUSE_UP = true;
			
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.Reset,true));
		}
	}
}
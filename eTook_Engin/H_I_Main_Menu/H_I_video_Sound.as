package  eTook_Engin.H_I_Main_Menu {
	import eTook_Engin.H_I_PLayer.H_I_Seek_Base;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.media.SoundTransform;
	import flash.display.MovieClip;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import eTook_Engin.H_I_Value.H_I_Value;
	public class H_I_video_Sound extends H_I_Seek_Base{
		private var tw:TweenMax;
		private var isAnimated:Boolean = false;
		private var isStartUp:Boolean = true;
		
		public function H_I_video_Sound() 
		{
			 start_()
		}
	
		override public function start_()
		{
			isLimited = false;
			location_ = 50
			ACtion_Function = sund_vol_view;
			Action_Function_UP = Action_Function_UP_;
			baseX = 392
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
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.SET_VOLUME,setVolume);
		}
		private function removeEvent()
		{
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.SET_VOLUME,setVolume);
		}
		private function setVolume(e:Event)
		{
			sund_vol_view();
		}
		private function sund_vol_view()
		{
			if(!isAnimated &&!isStartUp)
			{
				//Animation_()
			}
			isStartUp = false
			H_I_Value.video_volume = location_/100
			if(MovieClip(parent.parent)._video!=null)
				MovieClip(parent.parent)._stream_ns.soundTransform = new SoundTransform(H_I_Value.video_volume)
				
			
			//MovieClip(parent).snd_vlmText.myText.text = String(location_);
		}
		private function Animation_()
		{
			isAnimated = true
			killTween()
			//tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:1})
		}
		private function killTween()
		{
			if(tw)
				tw.kill();
		}
		private function Action_Function_UP_()
		{
			isAnimated = false;
			killTween()
			//tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:0})
		}
	}
}

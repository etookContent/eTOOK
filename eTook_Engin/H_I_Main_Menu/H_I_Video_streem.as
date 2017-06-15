package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_PLayer.H_I_Seek_Base;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.NetStatusEvent;
	
	public class H_I_Video_streem extends H_I_Seek_Base{
		private var lenght_:Number;
		public function H_I_Video_streem() 
		{
			isLimited = false;
			isVideo = true;
			ACtion_Function = setVideoTime;
			Action_Function_UP = setVideoTimeAndPlay
			start_()
		}
		override public function start_()
		{
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
		private function setVideoTime()
		{
			lenght_ = H_I_Value.duration_video/100;
			lenght_ = Math.abs(Math.round(location_*lenght_)-1)
			MovieClip(parent.parent)._stream_ns.seek(lenght_);
			MovieClip(parent.parent).removeE_F();
			MovieClip(parent.parent)._stream_ns.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
		}
		private function statusHandler(e:NetStatusEvent)
		{
			MovieClip(parent.parent)._stream_ns.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);

			H_I_Value.oldNetTime = lenght_;
		}
		private function setVideoTimeAndPlay()
		{
			H_I_Value.IS_MOUSE_UP = true;
			MovieClip(parent.parent).EN_F();			
		}
	}
}

package  eTook_Engin.H_I_PLayer{
	import eTook_Engin.H_I_PLayer.H_I_Seek_Base;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class H_I_Video_Seek extends H_I_Seek_Base{

		public function H_I_Video_Seek() 
		{
			isVideo = true;
			ACtion_Function = setVideoTime;
			Action_Function_UP = setVideoTimeAndPlay
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
			MovieClip(parent).videoPack.my_viewer.setVideoSeek(location_)
		}
		private function setVideoTimeAndPlay()
		{
			MovieClip(parent).videoPack.my_viewer.setVideoSeek(location_,true)
		}
	}
}
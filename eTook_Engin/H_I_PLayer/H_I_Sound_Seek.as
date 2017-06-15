package  eTook_Engin.H_I_PLayer{
	import eTook_Engin.H_I_PLayer.H_I_Seek_Base;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	
	public class H_I_Sound_Seek extends H_I_Seek_Base{
		private var tw:TweenMax;
		private var isAnimated:Boolean = false;
		public function H_I_Sound_Seek() 
		{
			// constructor code
		}
		override public function start_()
		{
			ACtion_Function = sund_vol_view;
			Action_Function_UP = Action_Function_UP_;
			baseX = 136
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
		private function sund_vol_view()
		{
			if(!isAnimated)
				Animation_()
				
			
			MovieClip(parent).videoPack.my_viewer._stream_ns.soundTransform = new SoundTransform(location_/100)
			MovieClip(parent).snd_vlmText.myText.text = String(location_);
		}
		private function Animation_()
		{
			isAnimated = true
			killTween()
			tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:1})
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
			tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:0})
		}
	}
}

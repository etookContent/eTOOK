package  eTook_Engin.H_I_Main_Menu{
	import eTook_Engin.H_I_PLayer.H_I_Seek_Base;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Loadear.H_I_LoaderManager;
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import com.greensock.TweenMax;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
	public class H_I_Sound_timeline extends H_I_Seek_Base {
		private var tw:TweenMax;
		private var isAnimated:Boolean = false;
		private var isStartUp:Boolean = true;
		private var int_:Number=0;
		private var isMute:Boolean = false;
		private var location_old:Number = 0;
		public function H_I_Sound_timeline() 
		{
			 start_()
		}override public function start_()
		{
			isLimited = false;
			location_ = 50
			ACtion_Function = sund_vol_view;
			Action_Function_UP = Action_Function_UP_;
			baseX = 121
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
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.MUTE_SOUND,mute_)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.SET_VOLUME,setVolume);
		}
		private function removeEvent()
		{
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.MUTE_SOUND,mute_)
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
				Animation_()
			}
				isStartUp = false
			if(H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte"))
				if(H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").numChildren>0)
				{
					if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
						MovieClip(H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").getChildAt(0)).soundTransform = new SoundTransform(location_/100)
					else
						MovieClip(H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").getChildAt(0)).cpCmndVolume = (location_)
				}
				
			if(isMouse_Down)
				MovieClip(parent).snd_vlmText.myText.text = String(location_);
				
			 mute_check()
		}
		private function Animation_()
		{
			isAnimated = true
			killTween()
			if(isMouse_Down)
				tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:1})
		}
		private function killTween()
		{
			if(tw)
				tw.kill();
		}
		private function Action_Function_UP_()
		{
			
			clearTimeout(int_);
			isAnimated = false;
			killTween()
			tw = TweenMax.to(MovieClip(parent).snd_vlmText,0.7,{alpha:0})
		}
		public function plus_volume()
		{
			clearTimeout(int_);
			isMouse_Down = true
			if(this.x+10<=baseX+m_width)
			{
				this.x+=10
			}else
			{
				this.x = baseX+m_width
			}
			
			update_()
		}
		public function mute_(e:Event)
		{
			if(!isMute)
			{
				location_old = this.x;
				this.x=baseX;
				MovieClip(parent).mute_mc.equalizer.gotoAndStop(2)
			}
			else
			{
				this.x= location_old
				MovieClip(parent).mute_mc.equalizer.gotoAndStop(1)
			}
			update_();
		}
		public function menus_volume()
		{
			clearTimeout(int_);
			isMouse_Down = true
			if(this.x-10>=baseX)
			{
				this.x-=10
			}else
			{
				this.x = baseX
			}
			update_()
		}
		private function update_()
		{
			var mod:Number = m_width/100;
			location_ = Math.round(Math.abs((this.x-baseX)/mod))
			sund_vol_view();
			isMouse_Down = false
			//Action_Function_UP_()
			int_ = setTimeout(Action_Function_UP_,1000)	
		}
		private function mute_check()
		{
			if(location_==0)
			{
				isMute = true;
				MovieClip(parent).mute_mc.equalizer.gotoAndStop(2)
			}else
			{
				isMute = false;
				MovieClip(parent).mute_mc.equalizer.gotoAndStop(1)
			}
		}
		
	}
}
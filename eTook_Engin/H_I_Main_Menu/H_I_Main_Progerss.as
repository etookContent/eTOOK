package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	
	public class H_I_Main_Progerss extends MovieClip {

		public function H_I_Main_Progerss() 
		{
			// constructor code
			start_()
		}
		public function start_()
		{
			addEvent()
		}
		public function dispose()
		{
			removeEvent()
		}
		private function addEvent()
		{
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.PROGRESS_PLAY,PP);
		}
		private function removeEvent()
		{
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.PROGRESS_PLAY,PP);
		}
		private function PP(e:Event)
		{
			var num:Number = Math.round(100 / H_I_Value.All_path.length)
			H_I_Value.view_count +=1;
			lenght_mc.gotoAndStop(H_I_Value.view_count*num)
			lenght_mc.me_txt.text = String(H_I_Value.view_count*num) 
			if((H_I_Value.view_count*num)>=(H_I_Value.All_path.length*num))
			{
				lenght_mc.gotoAndStop(100)
				lenght_mc.me_txt.text = "100" 
			}
		}
	}
}
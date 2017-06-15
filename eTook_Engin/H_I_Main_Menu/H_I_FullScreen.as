package eTook_Engin.H_I_Main_Menu {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.display.StageDisplayState;
	import flash.display.SimpleButton;
	import flash.events.Event;
	
	public class H_I_FullScreen extends SimpleButton{

		public function H_I_FullScreen() 
		{
			this.addEventListener(MouseEvent.CLICK,FULLSCREEN_MC)
		}
		private function FULLSCREEN_MC(e:MouseEvent)
		{
			//this.dispatchEvent(new Event());
			//trace("click    "+H_I_Value.STAGE.displayState)
			if(H_I_Value.STAGE.displayState==StageDisplayState.NORMAL)
			{
				H_I_Value.STAGE.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE
			}else
			{
				H_I_Value.STAGE.displayState=StageDisplayState.NORMAL
			}
		}
	}
}

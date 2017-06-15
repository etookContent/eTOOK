package  eTook_Engin.H_I_PLayer{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class h_i_ButtonFull extends MovieClip{

		public function h_i_ButtonFull() {
			// constructor code
			
		}
		public function start_()
		{
			addEvent();
		}
		public function addEvent()
		{
			this.addEventListener(MouseEvent.CLICK,MC);
			this.addEventListener(MouseEvent.MOUSE_OVER,MOVER);
			this.addEventListener(MouseEvent.MOUSE_OUT,MOUT);
			
		}
		public function removeEvent()
		{
			this.removeEventListener(MouseEvent.CLICK,MC);
			this.removeEventListener(MouseEvent.MOUSE_OVER,MOVER);
			this.removeEventListener(MouseEvent.MOUSE_OUT,MOUT);
		}
		public function dispose()
		{
			removeEvent();
		}
		private function MC(e:MouseEvent)
		{
			this.dispatchEvent(new Event(h_i_Event_eTook.player_full_normal,true));
		}
		private function MOVER(e:MouseEvent)
		{
			
		}
		private function MOUT(e:MouseEvent)
		{
			
		}
	}
}
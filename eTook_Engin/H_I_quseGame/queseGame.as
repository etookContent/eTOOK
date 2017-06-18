package eTook_Engin.H_I_quseGame {
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class queseGame extends MovieClip{
		private var isAnsware:Boolean = false;
		[Inspectable(name = "جواب",variable = "isAns",defaultValue = "false",type = "Boolean")]
		public function set isAns( value_:Boolean):void {
	    	
			isAnsware = value_
		}
		public function queseGame() {
			trace(Object(parent.parent).stage)
			if(H_I_Value.STAGE == null)
				H_I_Value.STAGE = Object(parent).stage
			addEvent(null);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.ENABLE_EVENT_multiChooice,addEvent);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.DISABLE_EVENT_multiChooice,removeEvent);
		}
		private function addEvent(e:Event)
		{
			this.addEventListener(MouseEvent.CLICK,MC)
		}
		private function removeEvent(e:Event)
		{
			this.removeEventListener(MouseEvent.CLICK,MC)
		}
		private function MC(e:Event)
		{
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.SET_ALPHA,true));
			if(isAnsware)
			{
				H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.DISABLE_EVENT_multiChooice,true));
				this.gotoAndStop("correct")
				
			}
			else
			{
				H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.DISABLE_EVENT_multiChooice,true));
				this.gotoAndStop("incorrect")
			}
		}
	}
}
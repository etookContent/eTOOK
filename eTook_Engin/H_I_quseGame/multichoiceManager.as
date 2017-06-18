package eTook_Engin.H_I_quseGame {
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	
	public class multichoiceManager extends MovieClip{
		private var count:Number = 0;
		private var correcAnswer:Number = 0;
		private var inCorrecAnswer:Number = 0;
		public function multichoiceManager() 
		{
			
			count = this.totalFrames;
			addEvent();
		}
		
		private function addEvent()
		{
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.NEXT_QUIZE,nextQuize)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.FALSE_ANSWER,falseAns)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.SET_ALPHA,setAlphaF)
		}
		private function removeEvent()
		{
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.NEXT_QUIZE,nextQuize)
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.FALSE_ANSWER,falseAns)
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.SET_ALPHA,setAlphaF)
		}
		private function nextQuize(e:Event)
		{
			if(this.currentFrame<count)
			{
				correcAnswer+=1;
				this.nextFrame()
				reset()
			}else
			{
				reset()
				correcAnswer+=1;
				removeEvent();
				unvisible();
				score_mc.visible=true;
				score_mc.start_(count,correcAnswer,inCorrecAnswer);
			}
		}
		private function falseAns(e:Event)
		{	
			inCorrecAnswer +=1;
			reset()
		}
		private function unvisible()
		{
			
			for(var i=0;i<this.numChildren;i++)
			{
				if(this.getChildAt(i) is MovieClip)
					MovieClip(this.getChildAt(i)).visible =false
			}
		}
		private function reset()
		{
			for(var i=0;i<this.numChildren;i++)
			{
				if(this.getChildAt(i) is MovieClip)
				{
					MovieClip(this.getChildAt(i)).gotoAndStop(1)
					MovieClip(this.getChildAt(i)).alpha=1;
				}
			}
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.ENABLE_EVENT_multiChooice,true));
		}
		private function setAlphaF(e:Event)
		{
			trace("set alpha")
			for(var i=0;i<this.numChildren;i++)
			{
				if(this.getChildAt(i) is MovieClip)
				{
					MovieClip(this.getChildAt(i)).alpha=0.5;
				}
			}
		}
	}
}
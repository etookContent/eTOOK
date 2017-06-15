package eTook_Engin.H_I_Score {
	import flash.display.MovieClip;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.utils.setTimeout;
	
	public class H_I_Score extends MovieClip{
		private var count_q:Number = 0;
		private var correct_q:Number = 0;
		private var inCorrect_q:Number = 0;
		private var score:Number = 0;
		public function H_I_Score() {
			visible = false;
		}
		public function start_(count:Number , correct:Number,inCorrect:Number)
		{
			
			count_q = count;
			correct_q = correct;
			inCorrect_q = inCorrect;
			
			count_Question_txt.text = count_q.toString();
			count_correct_txt.text = correct.toString();
			count_incorrect_txt.text = inCorrect.toString();
			
			calc();
		}
		private function calc()
		{
			score = correct_q - inCorrect_q
			if(score<0)
				score=0;
			
			score = score * 100 / count_q
			scoret_txt.text = score.toString()+"%";
			this.addEventListener(Event.ENTER_FRAME,EG)
			chart_mc.play()
			//this.addEventListener(h_i_Event_eTook.Draw_LINE_ENDGAME,EG)
		}
		private function EG(e:Event)
		{
			e.stopImmediatePropagation();
			this.removeEventListener(h_i_Event_eTook.Draw_LINE_ENDGAME,EG)
			chart_mc.stop()
			//this.dispatchEvent(new Event(h_i_Event_eTook.END_SCORE_VIEW,true));
			if(score==0)
				score=1
			
			if(chart_mc.currentFrame>=score)
			{
				this.removeEventListener(Event.ENTER_FRAME,EG)
				chart_mc.stop()
				setTimeout(go,2000)
				
			}else
			{
				chart_mc.play();
			}
		}
		private function go()
		{
			if(Number(score)>70)
				this.dispatchEvent(new Event(h_i_Event_eTook.END_SCORE_VIEW,true));
			else
				this.dispatchEvent(new Event(h_i_Event_eTook.JUMP_TO_SLIDE,true));

		}
	}
}

package eTook_Engin.H_I_Exam.H_I_Drag_Drop {
	
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Utility.H_I_Random;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	import flash.media.Sound;
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import flash.utils.getDefinitionByName;
	
	public class H_I_Drag_Drop_Manager extends MovieClip{

		private var count:Number = 0;
		public var isShowLog_:Boolean = false;
		private var ans_locY:Array = new Array();
		private var Q_locY:Array = new Array();
		private var Tick_locY:Array = new Array();
		private var correct_:Number = 0;
		private var inCorrect_:Number = 0;
		private var rnd1:Array
		private var rnd2:Array
		private var delay:Number=0;
		
		[Inspectable(name = "نمایش نتایج",variable = "isShowLog",defaultValue = "false",type = "Boolean")]
		public function set isShowLog( value_:Boolean):void {
			isShowLog_ = value_;
		}
		
		public function H_I_Drag_Drop_Manager() 
		{
			MovieClip(parent).stop();
			
			counter()
			createRandom()
			saveLocation()
		}
		private function counter()
		{
			for(var i = 0;i<this.numChildren;i++)
			{
				if(this.getChildAt(i)== null)
				{
					break;
				}
				else if(this.getChildAt(i).name== "score_mc")
				{
					i+=1
					continue;
				}
				count+=1;
			}
		}
		private function saveLocation()
		{
			for(var i=1;i<=count;i++)
			{
				//trace()
				ans_locY[i-1] = this.getChildByName("ans"+i).y
				Q_locY[i-1] = this.getChildByName("question"+i).y
				Tick_locY[i-1] = this.getChildByName("tick"+i).y;
			}
			changeLocation();
		}
		private function createRandom()
		{
			count /=3;
			rnd1 = H_I_Random.create(1,count,count);
			rnd2 = H_I_Random.create(1,count,count);
			
		}
		private function changeLocation()
		{
			for(var i=1;i<=count;i++)
			{
				this.getChildByName("ans"+i).y = ans_locY[rnd1[i-1]-1]
				this.getChildByName("question"+i).y = Q_locY[rnd2[i-1]-1]
				this.getChildByName("tick"+i).y = Tick_locY[rnd2[i-1]-1]
				MovieClip(this.getChildByName("question"+i)).me.start_()
			}
		}
		public function addScore()
		{
			
			correct_+=1;
			
			if(correct_>=count)
				if(isShowLog_)
					delay = setTimeout(show_score,1000);
				else
					delay = setTimeout(Move_,1000);
		}
		public function subScore()
		{
			inCorrect_+=1;
		}
		private function show_score()
		{
			clearTimeout(delay);
			// trace("show_score")
			MovieClip(this).score_mc.visible = true;
			MovieClip(this).score_mc.start_(count,correct_,inCorrect_);
			this.addEventListener(h_i_Event_eTook.END_SCORE_VIEW,END);
		}
		private function END(e:Event)
		{
			e.stopImmediatePropagation();
			this.removeEventListener(h_i_Event_eTook.END_SCORE_VIEW,END);
			clearTimeout(delay);
			 dispose();
			MovieClip(parent).play();
		}
		private function dispose()
		{
			//trace("ss")
			for(var i = 0;i<this.numChildren;i++)
				if(this.getChildAt(i).hasOwnProperty("dispose"))
					MovieClip(this.getChildAt(i)).dispose();
		}
		private function Move_()
		{
			MovieClip(parent).play();
		}
	}
}
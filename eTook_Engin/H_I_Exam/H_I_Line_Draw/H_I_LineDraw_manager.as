package  eTook_Engin.H_I_Exam.H_I_Line_Draw{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Utility.H_I_Random;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	import flash.media.Sound;
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import flash.utils.getDefinitionByName;
	import eTook_Engin.H_I_Sound.H_I_Sound_Attach;
	
	public class H_I_LineDraw_manager extends MovieClip
	{
		private var delay:Number = 0;
		public var correct:Number = 0;
		public var inCorrect:Number = 0;
		public var Count_Question:Number = 0;
		private var A_saveLoc:Array = new Array();
		private var Aj_saveLoc:Array = new Array();
		private var Q_saveLoc:Array = new Array();
		private var Qj_saveLoc:Array = new Array();
		private var rnd1:Array;
		private var rnd2:Array;
		private var counter:Number=0
		private var snd:Sound;
		public var isShowLog_:Boolean = false;
		public var isHaveStop_:Boolean = true;
		[Inspectable(name = "نمایش نتایج",variable = "isShowLog",defaultValue = "false",type = "Boolean")]
		public function set isShowLog( value_:Boolean):void {
			isShowLog_ = value_;
		}
		public var isSound:Boolean = true;
		[Inspectable(name = "فعال کردن صدا",variable = "isSounded",defaultValue = "false",type = "Boolean")]
		public function set isSounded( value_:Boolean):void {
			isSound = value_;
		}
		public var isIcon:Boolean = true;
		[Inspectable(name = "فعال کردن آیکن",variable = "isIconed",defaultValue = "false",type = "Boolean")]
		public function set isIconed( value_:Boolean):void {
			isIcon = value_;
		}
		[Inspectable(name = " stop با",variable = "isHaveStop",defaultValue = "true",type = "Boolean")]
		public function set isHaveStop( value_:Boolean):void {
			isHaveStop_ = value_;
		}
		public function H_I_LineDraw_manager() 
		{
			trace(isHaveStop_)
			if(isHaveStop_)
				MovieClip(parent).stop();
				
			counter_function();
			createRandom()
		}
		private function createRandom()
		{
			if(!(counter%2))
			{
				rnd1 = H_I_Random.create(1,counter/2,counter/2)
				rnd2 = H_I_Random.create(1,counter/2,counter/2)
				changeLocation();
			}
			else
				trace("تعداد خانه های برای وصل کردن زوج نیست")
		}
		private function counter_function()
		{
			for(var i = 0;i<this.numChildren;i++)
				if(this.getChildAt(i).hasOwnProperty("dispose"))
					counter+=1;
					
			for(var j=1;j<=counter/2;j++)
			{
				A_saveLoc[j] = this.getChildByName("a"+j.toString()).y
				Aj_saveLoc[j] = this.getChildByName("aj"+j.toString()).y
				Q_saveLoc[j] = this.getChildByName("q"+j.toString()).y
				Qj_saveLoc[j] = this.getChildByName("qj"+j.toString()).y
			}
		}
		private function changeLocation()
		{
			for(var j=1;j<=counter/2;j++)
			{
				this.getChildByName("a"+j.toString()).y = A_saveLoc[rnd1[j-1]]
				this.getChildByName("q"+j.toString()).y = Q_saveLoc[rnd2[j-1]]
				this.getChildByName("aj"+j.toString()).y = Aj_saveLoc[rnd1[j-1]]
				this.getChildByName("qj"+j.toString()).y = Qj_saveLoc[rnd2[j-1]]
			}
		}
		public function addScore()
		{
			if(isIcon)
				active_icon(true);
			if(isSound)
				active_sound(true);
			correct+=1;
			if(correct>=counter/2)
				if(isShowLog_)
					delay = setTimeout(show_score,1000);
				else
					delay = setTimeout(Move_,1000);
		}
		public function subScore()
		{
			if(isSound)
				active_sound(false);
			if(isIcon)
				active_icon(false);
			inCorrect+=1;
		}
		private function show_score()
		{
			clearTimeout(delay);
			var index:Number = 0;
			for(var i =0;i<this.numChildren;i++)
			{
				if(this.getChildAt(i).name=="score_mc")
					i+=1
				this.getChildAt(i).visible = false;
			}
			
			MovieClip(this).score_mc.visible = true;
			MovieClip(this).score_mc.start_(counter/2,correct,inCorrect);
			this.addEventListener(h_i_Event_eTook.END_SCORE_VIEW,END);
		}
		private function Move_()
		{
			MovieClip(parent).play();
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
			trace("ss")
			for(var i = 0;i<this.numChildren;i++)
				if(this.getChildAt(i).hasOwnProperty("dispose"))
					MovieClip(this.getChildAt(i)).dispose();
				   
			this.removeEventListener(h_i_Event_eTook.END_SCORE_VIEW,END);
		}
		private function active_icon(isTrue:Boolean)
		{
			MovieClip(this).reaction_mc.gotoAndStop(String(isTrue))
		}
		private function active_sound(isTrue:Boolean)
		{
			if(isTrue)
				H_I_Sound_Attach.start_("correct_snd");
			else
				H_I_Sound_Attach.start_("incorrect_snd");
	
		}
	}
}
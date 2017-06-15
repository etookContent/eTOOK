package eTook_Engin.H_I_PLayer {
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.Event;
	import eTook_Engin.H_I_Value.H_I_Value;
	
	public class h_i_main extends MovieClip{
		public var m_width:Number = 850;
		public var m_height:Number = 536;
		public var Defualt_width:Number;
		public var Defualt_height:Number;
		public var Defualt_X:Number;
		public var Defualt_Y:Number;
		public var my_X:Number;
		public var my_Y:Number;
		public var isFV:Boolean = false;
		[Inspectable(name = "طول",variable = "my_width",defaultValue = "null",type = "Number")]
		public function set my_width( value_:Number):void {
	    	
			m_width = value_;
		}
		[Inspectable(name = "ارتفاع",variable = "my_height",defaultValue = "null",type = "Number")]
		public function set my_height( value_:Number):void {
	    	
			m_height = value_;
		}
		[Inspectable(name = "x",variable = "my_x_",defaultValue = "null",type = "Number")]
		public function set my_x_( value_:Number):void {
	    	
			m_height = value_;
		}
		[Inspectable(name = "y",variable = "my_y_",defaultValue = "null",type = "Number")]
		public function set my_y_( value_:Number):void {
	    	
			m_height = value_;
		}
		public function h_i_main() {
			Defualt_width = this.width;
			Defualt_height = this.height;
			my_X = this.x;
			my_Y = this.y;
			
		}
		public function start_()
		{
			if(!H_I_Value.STAGE)
				trace(" معرفی نشده است stage : خطا h_i_main کلاس ")
			H_I_Value.STAGE_WIDTH = H_I_Value.STAGE.stageWidth;
			H_I_Value.STAGE_HEIGHT = H_I_Value.STAGE.stageHeight;
			addEvent();
			for(var i=0;i<this.numChildren;i++)
				if(this.getChildAt(i).hasOwnProperty("start_"))
					MovieClip(this.getChildAt(i)).start_();
		}
		private function addEvent()
		{
			this.addEventListener(h_i_Event_eTook.player_full_normal,setSize_);
		}
		private function removeEvent()
		{
			this.removeEventListener(h_i_Event_eTook.player_full_normal,setSize_);
		}
		public function dispose()
		{
			for(var i=0;i<this.numChildren;i++)
				if(this.getChildAt(i).hasOwnProperty("dispose"))
					MovieClip(this.getChildAt(i)).dispose();
				
			removeEvent()
		}
		private function setSize_(e:Event)
		{
			if(isFV)
			{
				isFV = false;
				
				this.width = m_width;
				this.height =m_height;
				this.x = 0;
				this.y = 0;
				trace("set Size Full")
			}else
			{
				isFV = true;
				this.width = Defualt_width
				this.height = Defualt_height
				this.x = my_X;
				this.y = my_Y;
				trace("set Size Normal")
			}
		}
	}
}
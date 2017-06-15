package  eTook_Engin.H_I_PLayer{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import eTook_Engin.H_I_Value.H_I_Value;
	
	public class H_I_Seek_Base extends MovieClip{
		protected var isMouse_Down:Boolean = false;
		protected var isLimited:Boolean = true;
		protected var isVideo:Boolean=false;
		protected var Action_Function_UP:Function;
		protected var baseX:Number=0;
		public var isgoto:Boolean = true
		protected var location_:Number = 0;
		protected var m_width:Number = 500;
		public var lnght_:Number=-1;
		protected var ACtion_Function:Function;
		
		
		[Inspectable(name = "طول مسیر",variable = "my_width",defaultValue = "500",type = "Number")]
		public function set my_width( value_:Number):void {
	    	
			m_width = value_;
		}
		
		[Inspectable(name = "آزاد باشد",variable = "isFree",defaultValue = "false",type = "Boolean")]
		public function set isFree( value_:Boolean):void {
	    	
			isLimited = !value_;
		}
		
		[Inspectable(name = "رفتن به اسلاید بعد",variable = "goSlid",defaultValue = "true",type = "Boolean")]
		public function set goSlid( value_:Boolean):void {
	    	
			trace("!value_    "+value_)
			isgoto = value_;
		}
		public function get goSlid():Boolean {
	    	
			return isgoto
		}
		public function H_I_Seek() 
		{
			// constructor code
		}
		public function reset()
		{
			
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
			this.addEventListener(MouseEvent.MOUSE_DOWN,MD);
		}
		private function removeEvent()
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,MD);
			Object(this.root.stage).removeEventListener(MouseEvent.MOUSE_UP,MU);
			this.removeEventListener(Event.ENTER_FRAME,EF);
		}
		private function MD(e:MouseEvent)
		{
			isMouse_Down = true;
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN,MD);
			Object(this.root.stage).addEventListener(MouseEvent.MOUSE_UP,MU);
			this.addEventListener(Event.ENTER_FRAME,EF);
			if(isLimited)
				this.startDrag(false,new Rectangle(baseX,this.y+0.2,H_I_Value.Progress_Menu[H_I_Value.Index]*1.5,0));
			else
				this.startDrag(false,new Rectangle(baseX,this.y+0.2,m_width,0));
		}
		protected function MU(e:MouseEvent)
		{
			isMouse_Down = false;
			if(Action_Function_UP != null)
				Action_Function_UP();
			
			this.stopDrag();
			Object(this.root.stage).removeEventListener(MouseEvent.MOUSE_UP,MU);
			this.removeEventListener(Event.ENTER_FRAME,EF);
			addEvent()
		}
		protected function EF(e:Event)
		{
			var mod:Number = m_width/100;
			
			location_ = Math.round(Math.abs((this.x-baseX)/mod))
			H_I_Value.projress_current_menu[H_I_Value.Index-1] = location_;
			if(ACtion_Function!=null)
				ACtion_Function();
		}
		public function setSeekLocation(loc:Number)
		{
			if(isVideo && !isMouse_Down)
			{
				var x_:Number = (m_width/100)*loc+baseX
				this.x = x_;
			}
			if(lnght_ !=-1)
			{
				//trace("lenght   "+(loc*lnght_)/100 )
				var m:String = String(Math.round(lnght_ / this.stage.frameRate)/60)
				var s:String = String(Math.round(lnght_ / this.stage.frameRate)%60).substr(0,2)
				
				var MN:Number = (loc*lnght_)/100;
				var cm:String = String(Math.round(MN / this.stage.frameRate)/60)
				if(m.indexOf(".") >0)
					m = m.substr(0,m.indexOf("."))
				
				if(cm.indexOf(".") >0)
					cm = cm.substr(0,cm.indexOf("."))
					
				var cs:String = String(Math.round(MN / this.stage.frameRate)%60).substr(0,2)
				if(cs.length>2)
					cs = cs.substr(0,2);
				if(cs.length==1)
				{
					cs = "0"+cs
				}
				if(s.length==1)
				{
					s = "0"+s
				}
				if(cm.length==1)
				{
					cm = "0"+cm
				}
				MovieClip(parent).viteSlideTime_txt.text = cm+":"+cs+" / "+m+":"+s
				///trace((cm+":"+cs+" / "+m+":"+s))
			}
		}
	}
}
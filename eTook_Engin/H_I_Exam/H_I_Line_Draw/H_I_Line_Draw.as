package eTook_Engin.H_I_Exam.H_I_Line_Draw{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.display.Shape;	
	
	public class H_I_Line_Draw extends MovieClip {
		private var Click_MX:Number=0;
		private var Click_MY:Number=0;
		private var my_shape:Shape
		private var line_size_:Number = 5;
		private var incorrect_color_:uint = 0x009900;
		private var correct_color_:uint = 0x006600;
		private var border_color_:uint = 0xCC0000;
		
		[Inspectable(name = "اندازه خط",variable = "line_size",defaultValue = "5",type = "Number")]
		public function set line_size( value_:Number):void {
			line_size_ = value_;
		}
		[Inspectable(name = "رنگ جواب نادرست",variable = "incorrect_color",defaultValue = "0x009900",type = "String")]
		public function set incorrect_color( value_:String):void {
	    	
			incorrect_color_ = uint(value_);
		}
		[Inspectable(name = "رنگ جواب درست",variable = "correct_color",defaultValue = "0x006600",type = "String")]
		public function set correct_color( value_:String):void {
	    	
			correct_color_ = uint(value_);
		}
		[Inspectable(name = "رنگ خط",variable = "border_color",defaultValue = "0xCC0000",type = "String")]
		public function set border_color( value_:String):void {
	    	
			border_color_ = uint(value_);
		}
		
		public function H_I_Line_Draw() 
		{
			start_()
		}
		public function start_()
		{
			my_shape = new Shape();
			MovieClip(parent).addChild(my_shape);
			addEvent();
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
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_MOVE,MM);
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_UP,MU);
		}
		private function MD(e:MouseEvent)
		{
			Click_MX = this.mouseX;
			Click_MY = this.mouseY;
			this.removeEventListener(MouseEvent.MOUSE_DOWN,MD);
			H_I_Value.STAGE.addEventListener(MouseEvent.MOUSE_MOVE,MM);
			H_I_Value.STAGE.addEventListener(MouseEvent.MOUSE_UP,MU);
		}
		private function MM(e:MouseEvent)
		{
			Draw_Line(MovieClip(parent).mouseX,MovieClip(parent).mouseY)
		}
		private function MU(e:MouseEvent)
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,MD);
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_MOVE,MM);
			H_I_Value.STAGE.removeEventListener(MouseEvent.MOUSE_UP,MU);
			if(!CheckAns())
			{
				my_shape.graphics.clear();
				MovieClip(parent).subScore();
			}
			else
			{
				disable()
				Draw_Line(MovieClip(parent).getChildByName(getname(false)).x,MovieClip(parent).getChildByName(getname(false)).y,true)
				MovieClip(parent).addScore();
			}
		}
		private function Draw_Line(x_:Number,y_:Number,isTrue:Boolean = false)
		{
			my_shape.graphics.clear();
			if(!isTrue)
				my_shape.graphics.lineStyle(line_size_, border_color_, 1);
			else
				my_shape.graphics.lineStyle(line_size_, correct_color_, 1);
			my_shape.graphics.beginFill(0x000000,1); 
			my_shape.graphics.moveTo(x, y); 
			my_shape.graphics.lineTo(x_,y_);
		}
		private function CheckAns():Boolean
		{

			var value_:Boolean = false;
			if(MovieClip(parent).getChildByName(getname(false)).x -(MovieClip(parent).getChildByName(getname(false)).width/2) <=MovieClip(parent).mouseX)
				if(MovieClip(parent).getChildByName(getname(false)).x +(MovieClip(parent).getChildByName(getname(false)).width/2) >=MovieClip(parent).mouseX)
					if(MovieClip(parent).getChildByName(getname(false)).y -(MovieClip(parent).getChildByName(getname(false)).height/2) <=MovieClip(parent).mouseY)
						if(MovieClip(parent).getChildByName(getname(false)).y +(MovieClip(parent).getChildByName(getname(false)).height/2) >=MovieClip(parent).mouseY)
							value_ = true
		
			return value_;
		}
		private function disable()
		{
			dispose();
			MovieClip(MovieClip(parent).getChildByName(getname(false))).dispose();
		}
		private function getname(isThis:Boolean)
		{
			var str:String = name.substr(1);
			var str1:String = name.substr(1);
			if(this.name.substr(0,1)=="a")
			{
			   str ="q"+str
			   str1 ="a"+str1
			}
			else
			{
				str ="a"+str
				str1 ="q"+str1
			}
			if(!isThis)
				return str;
			
				return str1;
		}
		
	}
}
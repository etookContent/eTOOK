package eTook_Engin.H_I_PLayer {
	
	import flash.display.MovieClip;
	
	
	public class H_I_Botton_Text extends MovieClip {
		
		[Inspectable(name = "lsdv",variable = "my_width",defaultValue = "null",type = "Number")]
		public function set my_width( value_:Number):void {
	    	
			m_width = value_;
		}
		public function H_I_Botton_Text() 
		{
			// constructor code
		}
	}
}
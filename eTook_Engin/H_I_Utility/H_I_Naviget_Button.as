package  eTook_Engin.H_I_Utility{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class H_I_Naviget_Button extends MovieClip {
		private var path:String = null;
		[Inspectable(name = "مسیر",variable = "mypath",defaultValue = "",type = "String")]
		public function set mypath( value_:String):void {
	    	
			path = value_;
		}
		public function H_I_Naviget_Button() {
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.CLICK,MC)
		}
		private function MC(e:MouseEvent)
		{
			navigateToURL(new URLRequest(path));
		}

	}
	
}

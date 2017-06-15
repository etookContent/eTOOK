package eTook_Engin.H_I_Utility {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import fl.text.TLFTextField;
	import flash.text.TextField;

	public class H_I_TextInput extends MovieClip {
		//private var ans_text:TLFTextField;
		public var Answer :String="جواب";
		[Inspectable(type="String", variable="setAns",defaultValue="جواب")]
  		public function set setAns(valu_)
		{
			Answer = valu_;
		}
		
		[Inspectable(type="Boolean", defaultValue="false")]
 		 public var isEnglish :Boolean;
		
		public function H_I_TextInput() {
			MovieClip(parent).stop();
			MovieClip(this).check_btn.addEventListener(MouseEvent.CLICK,MC)
			
		}
		private function MC(e:MouseEvent)
		{
			if(!isEnglish)
			 	checkAns(removeSpace())
			else
				checkAns(UpperWord())
		}
		private function removeSpace()
		{
			var str1:String= ans_text.text
			var str:String="";
			for(var i=0;i<str1.length;i++)
				if(str1.charAt(i)!=" ")
					str +=str1.charAt(i)
					
			return str
			
		}
		private function checkAns(str:String)
		{
			if(!isEnglish)
			{
				if(str==Answer)
				{
					MovieClip(this).check_btn.removeEventListener(MouseEvent.CLICK,MC)
					MovieClip(this).play()
				}
				 else
				 { 
					 MovieClip(this).reaction.play();
				 }
			}else
			{
				trace(str.toUpperCase()+"      "+Answer.toUpperCase())
				if(str.toUpperCase()==Answer.toUpperCase())
				{
					MovieClip(this).check_btn.removeEventListener(MouseEvent.CLICK,MC)
					MovieClip(this).play()
				}
				 else
				 {
					 MovieClip(this).reaction.play();
				 }
			}
		}
		private function UpperWord():String
		{
			var str:String= ans_text.text
			return str.toUpperCase()
		}
	}
}

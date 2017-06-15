package  eTook_Engin.H_I_XML{
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Main_Menu.H_I_Main_Menu;
	import eTook_Engin.H_I_Main_Menu.H_I_Name_Item;
	import flash.display.Sprite;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class H_I_XML_Parse extends Sprite{
		private var xml:XML = new XML()
		private var slid:Boolean = true;
		private var videos:Boolean = true;
		private var photos:Boolean = true;
		private var attachments:Boolean = true;
		
		public function H_I_XML_Parse()
		{
		}
		public function Splite_XML()
		{
			splite();
		}
		private function splite()
		{
			for(var i=0;;i++)
			{
				if(xml[0].slide[i]== null)
					break;
					
				slid = true;
				videos = true;
				photos = true;
				attachments= true;
				minify_slid(xml[0].slide[i],i)
				H_I_Value.COUNT_MENU_ITEM+=1;
			}
			//this.dispatchEvent(new Event(h_i_Event_eTook.SPLITE_XML_PARSE,true));
		}
		private function layer_1_slid()
		{
			
		}
		private function layer_2_slid((_xml:XML,num1:uint))
		{
			var obj:Object = new Object();
			for(var j:Number = 0;;j++)
			{
				if(!slid && !videos && !photos && !attachments)
					break;
				
				obj[H_I_Name_Item.IS_SLID] =true;
					
			}
		}
		private function layer_3_slid((_xml:XML,num1:uint,num2:uint))
		{
			
		}
	}
}
package eTook_Engin.H_I_Main_Menu {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Utility.H_I_ConvertFA;
	import flash.text.TextFieldAutoSize;
	import flashx.textLayout.formats.Direction;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import eTook_Engin.H_I_Value.H_I_Menu_Cloum;
	
	
	public class H_I_menuItem extends MovieClip {
		private var xml:XML
		private var index:Number
		private var child_:Number
		private var colume:String
		private var gallery_Array:Array
		private var videoList_Array:Array
		private var attachments_Array:Array
		private var slid_path:String;
		private var type_:String
		private var isOpen:Boolean =false

		public function H_I_menuItem() 
		{
			// constructor code
		}
		public function start_()
		{
			find_index();
			initiaze()
			addEvent();
		}
		private function find_index()
		{
			for(var i=0;i<H_I_Value.Names_Menu_Button.length;i++)
			{
				if(H_I_Value.Names_Menu_Button[i]==name)
				{
					index = i+1;
					return;
				}
			}
		}
		public function dispose()
		{
			removeEvent();
			gallery_Array=null;
			videoList_Array=null;
			attachments_Array = null;
		}
		private function addEvent()
		{
			this.addEventListener(MouseEvent.CLICK,MC);
			this.addEventListener(MouseEvent.ROLL_OVER,ROV);
			this.addEventListener(MouseEvent.ROLL_OUT,ROU);
		}
		private function removeEvent()
		{
			this.removeEventListener(MouseEvent.CLICK,MC);
			this.removeEventListener(MouseEvent.ROLL_OVER,ROV);
			this.removeEventListener(MouseEvent.ROLL_OUT,ROU);
		}
		private function MC(e:MouseEvent)
		{
			switch(type_)
			{
				case "slid":
					H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.GO_TO_FIND_SLID,true));
					slid_Click();
				break;
				case "menu":
					menu_click();
				break;
			}
		}
		private function ROV(e:MouseEvent)
		{
			
		}
		private function ROU(e:MouseEvent)
		{
			
		}
		private function initiaze()
		{
			Progress_mc.Progress.width = H_I_Value.Progress_Menu[index]
			
			if(this.name==H_I_Value.current_name_play)
			{
				set_viewreport(1)
			}
		}
		public function slid_Click()
		{

			var str:String = name.substr(name.indexOf("_")+1);
			str = str.substr(0,str.indexOf("_"));
			H_I_Value.rootIndex = Number(str);
			str = name.substr(name.indexOf("_")+1);
			str = str.substr(str.indexOf("_")+1);
			H_I_Value.middel_num = Number(str.substr(0,str.indexOf("_")));
			str = str.substr(str.indexOf("_")+1);
			H_I_Value.end_num = Number(str);
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.UPDATE_ROOT_MENU,true));
			H_I_Value.Index = index;
			H_I_Value.current_name_play = name;
			viewreport.gotoAndStop("startpreview");
			H_I_Value.video_Array = videoList_Array;
			H_I_Value.attachment_Array=attachments_Array;
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.Reset,true));
			H_I_Value.gallery_Array=gallery_Array;
			H_I_Value.SLID_PATH = String(xml[0].@src);
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.START_SLID_LOAD,true));
		}
		public function menu_click()
		{
			Condition();
			H_I_Menu_Cloum.isRemove = isOpen;
			
			var str:String = this.name.substr(this.name.indexOf("_")+1)
			str = str.substr(0,str.indexOf("_"))
			H_I_Menu_Cloum.COLUME_INDEX_1 = Number(str)			
			if(colume==H_I_Menu_Cloum.COLUME_1)
			{
				if(this.name.substr(this.name.lastIndexOf("_")+1)=="0")
					H_I_Menu_Cloum.COLUME_INDEX_2=1
					
					H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.CREATE_COLUME_2,true));
			}else if(colume==H_I_Menu_Cloum.COLUME_2)
			{
				var str2:String = this.name.substr(this.name.indexOf("_")+1)
				if(str2.length==5)
					str2 = str2.substr(str2.indexOf("_")+1,str2.indexOf("_"))
				else
					str2 = str2.substr(str2.indexOf("_")+1,str2.indexOf("_")-1)
				H_I_Menu_Cloum.COLUME_INDEX_2 = Number(str2)
				H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.CREATE_COLUME_3,true));
			}
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.VISIBLE_SCROLL,true));
			//trace("menu    "+MovieClip(MovieClip(root).menu.b).init)//.b.check_visible();
		}
		private function Condition()
		{
			if(arrow.currentFrame==1)
			{
				arrow.nextFrame();
				isOpen = false;
			}else
			{
				isOpen = true;
				arrow.prevFrame();
			}
		}
		public function reset()
		{
			set_viewreport(0);
		}
		private function set_viewreport(num:Number=1)
		{
			if(num==0)
			{
				viewreport.gotoAndStop("nopreview");
				return;
			}
			if(viewreport.currentFrame==1)
				viewreport.gotoAndStop("startpreview");
		}
		public function resiveData(xml_:XML,colume_:String)
		{
			
			colume =colume_
			xml = xml_;
			type_ = String(xml[0].@type);
			setType_And_Text()
		}
		private function setType_And_Text()
		{
			var textF:TextFormat = new TextFormat()
			textF.align = TextFormatAlign.RIGHT
			menu_text.autoSize = TextFieldAutoSize.RIGHT
			menu_text.text = H_I_ConvertFA.convertFA(reverse_multiline_text())
			
			if(type_=="slid")
			{
				slid_Setting()
			}else
			{
				viewreport.visible = false;
				menu_Setting();
			}
			
			bg_mc.height = menu_text.height
			Progress_mc.y = bg_mc.height - 1
			
		}
		private function reverse_multiline_text():String
		{
			
			var str:String = "";
			for(var i =0;i<xml[0].title.line.length();i++)
			{
				str+=String(xml[0].title.line[i]);
				str +="\n"
			}
			return str;
		}
		private function menu_Setting()
		{
			Progress_mc.visible = false;
		}
		private function slid_Setting()
		{
			arrow.gotoAndStop(3)
			gallery_set();
			videoList_set()
			attachments_set();
		}
		private function gallery_set()
		{
			gallery_Array = new Array();
			for(var i =0;i<xml[0].gallery.photo.length();i++)
			{
				var temp_array:Array = new Array();
				temp_array[0] = xml[0].gallery.photo[i].@src
				temp_array[1] = xml[0].gallery.photo[i].@thumb
				temp_array[2] = xml[0].gallery.photo[i].@title
				gallery_Array.push(temp_array);
			}
		}
		private function videoList_set()
		{
			videoList_Array = new Array();
			for(var i =0;i<xml[0].videoList.video.length();i++)
			{
				var temp_array:Array = new Array();
				temp_array[0] = xml[0].videoList.video[i].@src
				temp_array[1] = xml[0].videoList.video[i].@title
				temp_array[2] = xml[0].videoList.video[i].@duration
				temp_array[3] = xml[0].videoList.video[i].@size
				videoList_Array.push(temp_array);
			}
		}
		private function attachments_set()
		{
			attachments_Array = new Array();
			for(var i =0;i<xml[0].attachments.file.length();i++)
			{
				var temp_array:Array = new Array();
				temp_array[0] = xml[0].attachments.file[i].@src
				temp_array[1] = xml[0].attachments.file[i].@title
				attachments_Array.push(temp_array);
			}
		}
	}
}
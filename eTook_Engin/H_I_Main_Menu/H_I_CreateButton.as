package eTook_Engin.H_I_Main_Menu {
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Value.H_I_Menu_Cloum;
	import eTook_Engin.H_I_Value.H_I_Value;
	
	public class H_I_CreateButton extends MovieClip {
		private var menuSymbol:MovieClip
		private var xml:XML;
		private const space:Number = 25;
		private var name_Object:Object = new Object();
		public function H_I_CreateButton(menuSymbol_:MovieClip)
		{
			menuSymbol = menuSymbol_;
			H_I_Value.All_path = new Array();
			H_I_Value.Pdf_Array= new Array();
			
			H_I_Value.padkast_Array= new Array();
			H_I_Value.takalif_Array= new Array();
			H_I_Value.azmoon_Array= new Array();
			
			
			H_I_Value.Names_Menu_Button = new Array();
			H_I_Value.Jump_Array =new Array();
			H_I_Value.mode_ = new Array();
			H_I_Value.attachment_Array = new Array();
			H_I_Value.video_Array = new Array();
			H_I_Value.gallery_Array = new Array();
			H_I_Value.is_CP = new Array();
		}
		public function start_creat(xml_:XML)
		{
			
			if(H_I_Value.STAGE== null)
			{
				//trace("H_I_Value.STAGE =null")
				return;
			}
			
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.JUMP_TO_SLIDE,jump_to_slid)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.CREATE_COLUME_2,layer_2_slid);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.CREATE_COLUME_3,layer_3_slid);
			xml = xml_;
			find_All_path()
			layer_1_slid()
			jump();
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.UPDATE_ROOT_MENU,true));
		}
		private function find_All_path()
		{
			var ci:Number = 0;
			H_I_Value.maxIndex_Chapter = new Array();
			for(var i=0;i<xml[0].*.length();i++)
			{
								
				if(xml[0].node[i].@type=="slid")
				{
					ci+=1
					
					if(xml[0].node[i].@pakdastF != undefined)
						H_I_Value.padkast_Array.push(String(xml[0].node[i].@pakdastF))
					else
					{
						H_I_Value.padkast_Array.push(null)
					}
					
					if(xml[0].node[i].@takalifF != undefined)
						H_I_Value.takalif_Array.push(String(xml[0].node[i].@takalifF))
					else
					{
						H_I_Value.takalif_Array.push(null)
					}
					
					if(xml[0].node[i].@azmoonF != undefined)
						H_I_Value.azmoon_Array.push(String(xml[0].node[i].@azmoonF))
					else
					{
						H_I_Value.azmoon_Array.push(null)
					}
					
					
					if(xml[0].node[i].@pdf != undefined)
						H_I_Value.Pdf_Array.push(String(xml[0].node[i].@pdf))
					else
					{
						H_I_Value.Pdf_Array.push(null)
					}
					
					if(xml[0].node[i].@cp != undefined)
						H_I_Value.is_CP.push(String(xml[0].node[i].@cp))
				else
					H_I_Value.is_CP.push("false")
						
					H_I_Value.All_path.push(String(xml[0].node[i].@src))
					H_I_Value.mode_.push(String(xml[0].node[i].@mode))
					H_I_Value.Names_Menu_Button.push("item_"+(i+1).toString()+"_0_0")
					H_I_Value.attachment_Array.push(xml[0].node[i].attachments[0]);
					H_I_Value.gallery_Array.push(xml[0].node[i].gallery[0])
					H_I_Value.video_Array.push(xml[0].node[i].videoList[0]);
					if(xml[0].node[i].@jump!= null)
						H_I_Value.Jump_Array.push(String(xml[0].node[i].@jump))
					else
						H_I_Value.Jump_Array.push(null);
				}
					
				for(var j=0;j<xml[0].node[i].*.length()-1;j++)
				{
					if(xml[0].node[i].node[j] ==undefined)
						break;
					if(xml[0].node[i].node[j].@type=="slid")
					{
						ci+=1;
						H_I_Value.mode_.push(String(xml[0].node[i].node[j].@mode))
						
						if(xml[0].node[i].node[j].@pakdastF != undefined)
							H_I_Value.padkast_Array.push(String(xml[0].node[i].node[j].@pakdastF))
						else
						{
							H_I_Value.padkast_Array.push(null)
						}
						
						if(xml[0].node[i].node[j].@takalifF != undefined)
							H_I_Value.takalif_Array.push(String(xml[0].node[i].node[j].@takalifF))
						else
						{
							H_I_Value.takalif_Array.push(null)
						}
						
						if(xml[0].node[i].node[j].@azmoonF != undefined)
							H_I_Value.azmoon_Array.push(String(xml[0].node[i].node[j].@azmoonF))
						else
						{
							H_I_Value.azmoon_Array.push(null)
						}
						
						
						if(xml[0].node[i].node[j].@pdf != undefined)
							H_I_Value.Pdf_Array.push(String(xml[0].node[i].node[j].@pdf))
						else
						{
							H_I_Value.Pdf_Array.push(null)
						}
						
						if(xml[0].node[i].node[j].@cp != undefined)
							H_I_Value.is_CP.push(String(xml[0].node[i].node[j].@cp))
						else
							H_I_Value.is_CP.push("false")
						
						H_I_Value.All_path.push(String(xml[0].node[i].node[j].@src))
						H_I_Value.attachment_Array.push(xml[0].node[i].node[j].attachments[0]);
						H_I_Value.video_Array.push(xml[0].node[i].node[j].videoList[0]);
						H_I_Value.gallery_Array.push(xml[0].node[i].node[j].gallery[0])
						H_I_Value.Names_Menu_Button.push("item_"+(i+1).toString()+"_"+(j+1)+"_0")
						if(xml[0].node[i].node[j].@jump!= null)
							H_I_Value.Jump_Array.push(String(xml[0].node[i].node[j].@jump))
						else
							H_I_Value.Jump_Array.push(null);
					}
											
					for(var k=0;k<xml[0].node[i].node[j].*.length()-1;k++)
					{
						if(xml[0].node[i].node[j].node[k] ==undefined)
							break;
						if(xml[0].node[i].node[j].node[k].@type=="slid")
						{
							ci+=1
							H_I_Value.mode_.push(String(xml[0].node[i].node[j].node[k].@mode))
							
							
							if(xml[0].node[i].node[j].node[k].@pakdastF != undefined)
								H_I_Value.padkast_Array.push(String(xml[0].node[i].node[j].node[k].@pakdastF))
							else
							{
								H_I_Value.padkast_Array.push(null)
							}
							
							if(xml[0].node[i].node[j].node[k].@takalifF != undefined)
								H_I_Value.takalif_Array.push(String(xml[0].node[i].node[j].node[k].@takalifF))
							else
							{
								H_I_Value.takalif_Array.push(null)
							}
							
							if(xml[0].node[i].node[j].node[k].@azmoonF != undefined)
								H_I_Value.azmoon_Array.push(String(xml[0].node[i].node[j].node[k].@azmoonF))
							else
							{
								H_I_Value.azmoon_Array.push(null)
							}
							
							
							
							if(xml[0].node[i].node[j].node[k].@pdf != undefined)
								H_I_Value.Pdf_Array.push(String(xml[0].node[i].node[j].node[k].@pdf))
							else
							{
								H_I_Value.Pdf_Array.push(null)
							}
							
							if(xml[0].node[i].node[j].node[k].@cp != undefined)
								H_I_Value.is_CP.push(String(xml[0].node[i].node[j].node[k].@cp))
							else
								H_I_Value.is_CP.push("false")
							
							
							H_I_Value.All_path.push(String(xml[0].node[i].node[j].node[k].@src))
							H_I_Value.attachment_Array.push(xml[0].node[i].node[j].node[k].attachments[0]);
							H_I_Value.video_Array.push(xml[0].node[i].node[j].node[k].videoList[0]);
							H_I_Value.gallery_Array.push(xml[0].node[i].node[j].node[k].gallery[0])
							H_I_Value.Names_Menu_Button.push("item_"+(i+1).toString()+"_"+(j+1)+"_"+(k+1)+"")
							if(xml[0].node[i].node[j].node[k].@jump!= null)
								H_I_Value.Jump_Array.push(String(xml[0].node[i].node[j].node[k].@jump))
							else
								H_I_Value.Jump_Array.push(null);
						}
					}
				}
				H_I_Value.maxIndex_Chapter.push(ci)
			}
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.VISIBLE_SCROLL,true));
		}
		private function jump_to_slid(e:Event)
		{
			
			H_I_Value.SLID_PATH = H_I_Value.Jump_Array[H_I_Value.Index-1]
			
			find_index_jump()
			H_I_Value.current_name_play = H_I_Value.Names_Menu_Button[H_I_Value.Index-1];
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.START_SLID_LOAD,true));
			if(MovieClip(menuSymbol.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1]))!= null)
			{
				MovieClip(menuSymbol.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1])).slid_Click()
				
			}
			//H_I_Value.current_name_play = H_I_Value.Jump_Array[H_I_Value.Index-1]
		}
		private function find_index_jump()
		{
			for(var i=0;i<H_I_Value.All_path.length;i++)
			{
				if(H_I_Value.All_path[i]==H_I_Value.Jump_Array[H_I_Value.Index-1])
				{
					
					H_I_Value.Index=i+1;
					break;
				}
			}
		}
		private function jump()
		{
			
			H_I_Value.SLID_PATH = H_I_Value.All_path[H_I_Value.Index-1]
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.START_SLID_LOAD,true));
			if(MovieClip(menuSymbol.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1]))!= null)
			{
				MovieClip(menuSymbol.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1])).slid_Click()
				
			}
			H_I_Value.current_name_play = H_I_Value.Names_Menu_Button[H_I_Value.Index-1];
		}
		
		private function layer_1_slid()
		{
			//trace("start create layer 1   "+xml[0].*.length())
			var name_arr:Array = new Array();
			for(var i = 1;i<=xml[0].*.length();i++)
			{
				createButton_Colume1(i);
				name_arr.push("item_"+i.toString()+"_0_0")
			}
			name_Object.layer1 = name_arr
			set_y();
			
		}
		private function layer_2_slid(e:Event)
		{
			//trace("start create layer 2    "+xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].*.length())
			if(!H_I_Menu_Cloum.isRemove)
			{
				var name_arr:Array = new Array();
				for(var i = 1;i<=xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].*.length()-1;i++)
				{
					createButton_Colume2(H_I_Menu_Cloum.COLUME_INDEX_1,i);
					name_arr.push("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+i+"_0")
				}
				name_Object.layer2 = name_arr
			}else
				removeItem_(1);
		
			set_y();
		}
		private function layer_3_slid(e:Event)
		{
			//trace("start create layer 3")
			if(!H_I_Menu_Cloum.isRemove)
			{
				var name_arr:Array = new Array();
				for(var i = 1;i<=xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].node[H_I_Menu_Cloum.COLUME_INDEX_2-1].*.length()-1;i++)
				{
					createButton_Colume3(H_I_Menu_Cloum.COLUME_INDEX_1,H_I_Menu_Cloum.COLUME_INDEX_2,i);
					name_arr.push("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+H_I_Menu_Cloum.COLUME_INDEX_2.toString()+"_"+i+"")
				}
				name_Object.layer3 = name_arr
			}else
				removeItem_(2);
				
			set_y();
		}
		private function createButton_Colume1(index_:Number)
		{
			var menu_Item_:Class = getDefinitionByName("eTook_Engin.H_I_Main_Menu.H_I_menuItem") as Class
			var mc:MovieClip = new menu_Item_();
			mc.name = "item_"+index_.toString()+"_0_0";
			mc.x = 0
			menuSymbol.addChild(mc)
			mc.start_();
			mc.resiveData(xml[0].node[index_-1],H_I_Menu_Cloum.COLUME_1)
		}
		private function createButton_Colume2(index_:Number,index2:Number)
		{
			var menu_Item_:Class = getDefinitionByName("eTook_Engin.H_I_Main_Menu.H_I_menuItem") as Class
			var mc:MovieClip = new menu_Item_();
			mc.name = "item_"+index_.toString()+"_"+index2+"_0";
			mc.x = -10
			menuSymbol.addChild(mc)
			mc.start_();
			mc.resiveData(xml[0].node[index_-1].node[index2-1],H_I_Menu_Cloum.COLUME_2)
		}
		
		private function createButton_Colume3(index_:Number,index2:Number,index3:Number)
		{
			var menu_Item_:Class = getDefinitionByName("eTook_Engin.H_I_Main_Menu.H_I_menuItem") as Class
			var mc:MovieClip = new menu_Item_();
			mc.name = "item_"+index_.toString()+"_"+index2+"_"+index3+"";
			mc.x = -20
			menuSymbol.addChild(mc)
			mc.start_();
			mc.resiveData(xml[0].node[index_-1].node[index2-1].node[index3-1],H_I_Menu_Cloum.COLUME_3)
		}
		private function set_y()
		{
			
			var index_y:Number = 0;
			for(var i = 1;;i++)
			{
				if(i==1)
					menuSymbol.getChildByName("item_"+(i).toString()+"_0_0").y =menuSymbol.getChildByName("item_"+(i).toString()+"_0_0").height*index_y 
				else
					menuSymbol.getChildByName("item_"+(i).toString()+"_0_0").y =menuSymbol.getChildByName("item_"+(i-1).toString()+"_0_0").height*index_y 
				for(var j = 1;;j++)
				{
					
					if(menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_0")== null)
						break;
						index_y+=1;
						
						if(j==1)
							menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_0").y =menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_0").height*index_y;
						else
							menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_0").y =menuSymbol.getChildByName("item_"+(i).toString()+"_"+(j-1)+"_0").height*index_y;
						
						
						for(var k = 1;;k++)
						{
							if(menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_"+k+"")== null)
								break;
								index_y+=1;
								if(k==1)
									menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_"+k+"").y =menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_"+k+"").height*index_y
								else
									menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_"+k+"").y =menuSymbol.getChildByName("item_"+(i).toString()+"_"+j+"_"+(k-1)+"").height*index_y
						}
						
				}
				if(menuSymbol.getChildByName("item_"+(i+1).toString()+"_0_0")==null)
				{
					break;
				}
				index_y+=1;
			}
		}
		
		private function removeItem_(how:Number)
		{
			if(how==1)
			{
				for(var k=H_I_Menu_Cloum.COLUME_INDEX_2 ;k <= (xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].*.length()-1);k++)
				{
					if(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_0")!=null)
					{
						MovieClip(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_0")).dispose();
						menuSymbol.removeChild(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_0"))
					}
						
					for(var i = 1;i<=xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].node[k-1].*.length()-1;i++)
					{
						if(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_"+i+"")==null)
							break
						MovieClip(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_"+i+"")).dispose();
						menuSymbol.removeChild(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+k+"_"+i+""))
					}
				}
			}
			if( how==2)
			{
				for(var j = 1;j<=xml[0].node[H_I_Menu_Cloum.COLUME_INDEX_1-1].node[H_I_Menu_Cloum.COLUME_INDEX_2-1].*.length()-1;j++)
				{
					MovieClip(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+H_I_Menu_Cloum.COLUME_INDEX_2.toString()+"_"+j+"")).dispose();
					menuSymbol.removeChild(menuSymbol.getChildByName("item_"+H_I_Menu_Cloum.COLUME_INDEX_1.toString()+"_"+H_I_Menu_Cloum.COLUME_INDEX_2.toString()+"_"+j+""))
				}
			}
		}
		
	}
}
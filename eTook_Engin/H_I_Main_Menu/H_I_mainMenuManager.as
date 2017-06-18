package eTook_Engin.H_I_Main_Menu {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	import eTook_Engin.H_I_Loadear.H_I_LoaderManager;
	import flash.net.URLLoaderDataFormat;
	import eTook_Engin.H_I_Encrypt.H_I_Decrypt;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
import flash.net.URLVariables;
import flash.net.URLVariables;
import flash.net.navigateToURL;
	import flash.system.LoaderContext;
	import eTook_Engin.H_I_XML.H_I_XML_Structure;
	import eTook_Engin.H_I_XML.H_I_XmlReader;
	import flash.media.SoundMixer;
	import eTook_Engin.H_I_Utility.H_I_ConvertFA;
	import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import moodelService.local_playertrack_get_progress;

import moodelService.ServiceBase;
import moodelService.local_playertrack_set_progress;


public class H_I_mainMenuManager extends MovieClip {
		private var mc__:MovieClip 
		private var Menu_Button:H_I_CreateButton
		private var menu_X:Number;
		private var isOpen_Menu:Boolean = false;
		private var tw_listMenu:TweenMax;
		public var isPlay:Boolean = true;
		public var isPause:Boolean = false;
		private var url:URLLoader = new URLLoader()
		private var xml:XML;
		private var user_xml:XML;
		private var btn_Arr:Array = ["ostad","ahdaf","gallery","video_btn","zamaem_btn","pdf_btn","help_btn"]//,"padkast","takalif","azmoon"]
		private var count_off:Number =7;
		private var old_ch:Number = 0;
		private var cs:Number=0
		private var isN:Boolean = true;
		private var go_to:Number = 1;
		private var ci:Number=0
		private var m_i:Number=0;
		private var change_:Boolean = false;
		private var isClick:Boolean = false;
		private var help_load:Loader;

        /**Media parameters to save last status to the server*/
		private static var 	userid:uint = 2,
                            courseid:uint = 12,
							idnumber:uint = 1;

        /**Change it to null on final release*/
        private static var debugSWF_URL:String = null,//"http://etooklms.com/pluginfile.php/1941/mod_resource/content/2/parameter_detect.swf?courseid=12&userid=185&idnumber=1",
                            debugDomain:String = null;//"http://etooklms.com/";

        /**State saver interval in miliseconds*/
        private static const SaveDelay:uint = 10000 ;

        /**This is the moodles tocken*/
        private static const tocken:String = "b58782e93c105cc10e3bc5a0de86e6fb";

    /**Save state time out id*/
    private var saveTimeOutId:uint;



    public function H_I_mainMenuManager()
		{
			super();

            var swfURL:String;
            if(debugSWF_URL==null) {
                swfURL = this.loaderInfo.url;
            }
            else {
                swfURL = debugSWF_URL ;
            }

            var domainList:Array = swfURL.match(/http[s]{0,1}:\/\/[a-z\d\.]+[\\\/]/i);
            var domain:String = (domainList!=null)?domainList[0]:debugDomain;
            trace("Founded domain is : "+domain);

            if(domain==null)
            {
                addDebugger("The SWF's domain is not detectable.\nSWF URL is : "+swfURL+"\nDetected Domain is : "+domainList);
                return ;
            }

            var OtherParams:URLVariables = new URLVariables(swfURL.substring(swfURL.lastIndexOf('?')+1));
            trace("Detected params are : "+JSON.stringify(OtherParams));
            userid = uint(OtherParams.userid) ;
            courseid = uint(OtherParams.courseid) ;
            idnumber = uint(OtherParams.idnumber) ;

            if(userid==0 || courseid==0 || idnumber==0)
            {
                addDebugger("The swf parameters cannot parse.\nuserid="+userid+"\ncourseid="+courseid+"\nidnumber="+idnumber);
                return;
            }


			ServiceBase.setUp(domain,tocken);
            loadCurrentState();
		}

    /**Add the debugger to the stage*/
    private function addDebugger(UserHint:String):void
    {
        var maskMC:Sprite = new Sprite();
        stage.addChild(maskMC);
        maskMC.graphics.beginFill(0xffffff,0.8);
        maskMC.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
        var texter:TextField = new TextField();
        stage.addChild(texter);
        texter.width = stage.stageWidth;
        texter.height = stage.stageHeight;
        texter.defaultTextFormat = new TextFormat("Arial",30);
        texter.wordWrap = true ;
        trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"+UserHint);
        texter.text = UserHint ;

        stage.addEventListener(MouseEvent.CLICK,clearMe);
        function clearMe(e:*=null)
        {
            stage.removeChild(texter);
            stage.removeChild(maskMC);
        }
    }

    /**Get the user last status from server*/
    private function loadCurrentState(e:*=null):void {

        var srevice1:local_playertrack_get_progress = new local_playertrack_get_progress();
        srevice1.addEventListener(Event.COMPLETE, onLastStateLoaded);
        srevice1.addEventListener(IOErrorEvent.IO_ERROR, loadCurrentState);//Reload last state
        srevice1.load(userid,courseid ,idnumber);
    }

    /**User state loaded*/
    private function onLastStateLoaded(e:Event):void
    {
        var srevice:local_playertrack_get_progress = e.currentTarget as local_playertrack_get_progress ;
        try {
            var loadedState:Object = JSON.parse(JSON.parse(srevice.data) as String);
            trace("** server data is : "+srevice.data);
            trace("***loaded state is : "+loadedState);
            trace("**** Last state that loaded is : "+JSON.stringify(loadedState));
            if (
                    loadedState.Progress_Menu != null && loadedState.Progress_Menu.length > 0
                    &&
                    loadedState.Complete_Progress_Menu != null && loadedState.Complete_Progress_Menu.length > 0
            ) {
                trace("***** Loaded data is detectable!");
                H_I_Value.Progress_Menu = loadedState.Progress_Menu;
                H_I_Value.Complete_Progress_Menu = loadedState.Complete_Progress_Menu;

                for (var i = 0; i < H_I_Value.Progress_Menu.length; i++) {
                    if (H_I_Value.Complete_Progress_Menu[i]) {
                        H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.PROGRESS_PLAY, true, true));
                    }
                }
            }
        }
        catch (e){};
        StartSavingTheUserState();
    }

    /**Save the user state after a delay*/
    private function StartSavingTheUserState(e:*=null):void
    {
        saveTimeOutId = setTimeout(saveCurrentState,SaveDelay);
    }

		/**Save the current state of the media to moodle*/
		private function saveCurrentState():void
		{
            clearTimeout(saveTimeOutId);
            trace("Now is time to save current status");
			var toSaveObj:Object = {};
			toSaveObj.Progress_Menu = H_I_Value.Progress_Menu;
			toSaveObj.Complete_Progress_Menu = H_I_Value.Complete_Progress_Menu;
			var toSaveJSON:String = JSON.stringify(toSaveObj);
            trace("Save this : "+toSaveJSON);

			var saver:local_playertrack_set_progress = new local_playertrack_set_progress();
			saver.load(userid,courseid,idnumber,toSaveJSON);
            saver.addEventListener(Event.COMPLETE, userStateSavedSuccessfully);
            saver.addEventListener(IOErrorEvent.IO_ERROR, StartSavingTheUserState);//Retry to save last state
		}

        private function userStateSavedSuccessfully(event:Event):void {
            trace("********************User data is saved now******************");
            StartSavingTheUserState();
        }
		
		public function mainMenuManager() 
		{
			
		}
		public function start_(path:String)
		{
			loader_calc.visible = false;
			if(!H_I_Value.STAGE)
				H_I_Value.STAGE = this.stage
			
			H_I_Value.Progress_Menu = new Array();
			

			
			H_I_Value.Complete_Progress_Menu = new Array();
			initialize();
			menu_X = menu.x;
			url.addEventListener(Event.COMPLETE,CXL)
			//trace("path    "+path)
			url.load(new URLRequest(path))
			//var ld_XML_:H_I_XmlReader = new H_I_XmlReader();
			//H_I_XmlReader.XMLLoad(H_I_XML_Structure.temp_xml)
			addEvent();
			
			previouse_btn.enabled = false;
			previouse_btn.alpha = 0.5;
			
			
		}
		private function initialize()
		{
			H_I_Value.projress_current_menu = new Array();
			for(var i=0;i<150;i++)
			{
				H_I_Value.projress_current_menu[i] = 0;
				H_I_Value.Progress_Menu[i]=0;
				H_I_Value.Complete_Progress_Menu[i]=false;
			}
			//Update progress after here
		}
		public function dispose()
		{
			removeEvent();
			unload_();			
		}
		private function addEventButton()
		{
			menu_item.list_button.list_button.addEventListener(MouseEvent.CLICK,MC_List_menu);
			if(menu_item.pdf_btn.pdf_btn)
				menu_item.pdf_btn.pdf_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.video_btn.video_btn)
				menu_item.video_btn.video_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.gallery.gallery)
				menu_item.gallery.gallery.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.zamaem_btn.zamaem_btn)
				menu_item.zamaem_btn.zamaem_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ostad.ostad)
				menu_item.ostad.ostad.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ahdaf.ahdaf)
				menu_item.ahdaf.ahdaf.addEventListener(MouseEvent.CLICK,menuBtn);
			
			/*if(menu_item.help_btn.help_btn)
				menu_item.help_btn.help_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.padkast.padkast)
				menu_item.padkast.padkast.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.takalif.takalif)
				menu_item.takalif.takalif.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.azmoon.azmoon)
				menu_item.azmoon.azmoon.addEventListener(MouseEvent.CLICK,menuBtn);
				*/
			if(mute_mc)
			{
				mute_mc.addEventListener(MouseEvent.CLICK,mute_mouse_click)
			}
			
		}
		private function removeEventButton()
		{
			menu_item.list_button.list_button.removeEventListener(MouseEvent.CLICK,MC_List_menu);
			if(menu_item.pdf_btn.pdf_btn)
				menu_item.pdf_btn.pdf_btn.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.video_btn.video_btn)
				menu_item.video_btn.video_btn.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.gallery.gallery)
				menu_item.gallery.gallery.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.zamaem_btn.zamaem_btn)
				menu_item.zamaem_btn.zamaem_btn.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ostad.ostad)
				menu_item.ostad.ostad.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ahdaf.ahdaf)
				menu_item.ahdaf.ahdaf.removeEventListener(MouseEvent.CLICK,menuBtn);
				
			if(menu_item.help_btn.help_btn)
				menu_item.help_btn.help_btn.removeEventListener(MouseEvent.CLICK,menuBtn);
			
			/*if(menu_item.padkast.padkast)
				menu_item.padkast.padkast.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.takalif.takalif)
				menu_item.takalif.takalif.removeEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.azmoon.azmoon)
				menu_item.azmoon.azmoon.removeEventListener(MouseEvent.CLICK,menuBtn);
			*/
			if(mute_mc)
			{
				mute_mc.removeEventListener(MouseEvent.CLICK,mute_mouse_click)
			}
		}

		private function mute_mouse_click(e:MouseEvent)
		{
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.MUTE_SOUND,true));
		}
		private function reset_P_P(e:Event)
		{
			//if(p_p.PR_btn.currentFrame==1)
			//p_p.reset_()
		}
		private function addEvent()
		{
			addEventButton();
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.Close_Help,close_help);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.GO_TO_FIND_SLID,go_to_chapter);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.START_SLID_LOAD,SSL);
			H_I_Value.STAGE.addEventListener(Event.ENTER_FRAME,updatePlayer);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.NEXT_LOAD,NL);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.PREVIOUSE_LOAD,PL);
			next_btn.addEventListener(MouseEvent.CLICK,NBCK);
			previouse_btn.addEventListener(MouseEvent.CLICK,PBCK);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.STOP,STOPF);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.PLAY_RESUME,S_P_R);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.UPDATE_ROOT_MENU,rootMenuUpdate);
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.XML_Loading,XMLLE);
			
		}
		private function XMLLE(e:Event)
		{
			trace("sss   hi  "+H_I_XML_Structure.MY_TAG)
		}
		private function removeEvent()
		{
			removeEventButton()
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.GO_TO_FIND_SLID,go_to_chapter);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.START_SLID_LOAD,SSL);
			H_I_Value.STAGE.removeEventListener(Event.ENTER_FRAME,updatePlayer);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.NEXT_LOAD,NL);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.PREVIOUSE_LOAD,PL);
			next_btn.removeEventListener(MouseEvent.CLICK,NBCK);
			previouse_btn.removeEventListener(MouseEvent.CLICK,PBCK);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.STOP,STOPF);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.PLAY_RESUME,S_P_R);
			H_I_Value.STAGE.removeEventListener(h_i_Event_eTook.UPDATE_ROOT_MENU,rootMenuUpdate);
		}
		
		private function menuBtn(e:MouseEvent)
		{
			//trace("e.currentTarget.name    "+e.currentTarget.name)
			if(menu_item.list_button.currentFrame==2)
			{
				MC_List_menu(null);
			}
			manageButton()
			e.currentTarget.parent.gotoAndStop(2)
			trace(H_I_Value.Index+ "   a   "+H_I_Value.Pdf_Array[H_I_Value.Index-1])
			switch(e.currentTarget.name)
			{
				case "pdf_btn":
					trace(H_I_Value.Pdf_Array[H_I_Value.Index-1]+"      "+H_I_Value.Index)
					if(String(xml[0].@pdf).length != 0 && String(xml[0].@pdf != undefined))
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(xml[0].@pdf)));
					}
					else if(H_I_Value.Pdf_Array[H_I_Value.Index-1] != null)
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(H_I_Value.Pdf_Array[H_I_Value.Index-1])));
					}
							
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break
				case "video_btn":
					menu_window.gotoAndStop(e.currentTarget.name)
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "zamaem_btn":
					menu_window.gotoAndStop(e.currentTarget.name)
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "ahdaf":
					menu_window.gotoAndStop("ahdaf")
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "ostad":
					menu_window.gotoAndStop("ostad")
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "gallery":
					menu_window.gotoAndStop("gallery")
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "help_btn":
					helpLoad()
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "padkast":
					if(String(xml[0].@padkastF).length != 0 && String(xml[0].@padkastF != undefined))
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(xml[0].@padkastF)));
					}
					else if(H_I_Value.padkast_Array[H_I_Value.Index-1] != null)
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(H_I_Value.padkast_Array[H_I_Value.Index-1])));
					}
							
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "takalif":
					if(String(xml[0].@takalifF).length != 0 && String(xml[0].@takalifF != undefined))
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(xml[0].@takalifF)));
					}
					else if(H_I_Value.takalif_Array[H_I_Value.Index-1] != null)
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(H_I_Value.takalif_Array[H_I_Value.Index-1])));
					}
							
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				case "azmoon":
					if(String(xml[0].@azmoonF).length != 0 && String(xml[0].@azmoonF != undefined))
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(xml[0].@azmoonF)));
					}
					else if(H_I_Value.azmoon_Array[H_I_Value.Index-1] != null)
					{
						navigateToURL(new URLRequest(H_I_Value.plus_path+String(H_I_Value.azmoon_Array[H_I_Value.Index-1])));
					}
							
					this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
				break;
				
			}
			
			
		}
		private function helpLoad()
		{
			help_load = new Loader();
			help_load .load(new URLRequest(H_I_Value.plus_path+"help.swf"));
			this.addChild(help_load);
		}
		private function close_help(e:Event)
		{
			this.removeChild(help_load)
			help_load.unloadAndStop();
			SoundMixer.stopAll();
			this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
		}
		public function Enable_Button_Menu()
		{
			/*H_I_Value.video_Array[H_I_Value.Index-1][0].*.length()
			
			H_I_Value.gallery_Array[H_I_Value.Index-1][0].*.length()
			
			H_I_Value.attachment_Array[H_I_Value.Index-1][0].*.length()
			
			H_I_Value.attachment_Array[H_I_Value.Index-1][0].*.length()*/
			
			
			menu_item.list_button.list_button.addEventListener(MouseEvent.CLICK,MC_List_menu);
			if(menu_item.pdf_btn.pdf_btn)
				menu_item.pdf_btn.pdf_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.video_btn.video_btn)
				menu_item.video_btn.video_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.gallery.gallery)
				menu_item.gallery.gallery.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.zamaem_btn.zamaem_btn)
				menu_item.zamaem_btn.zamaem_btn.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ostad.ostad)
				menu_item.ostad.ostad.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.ahdaf.ahdaf)
				menu_item.ahdaf.ahdaf.addEventListener(MouseEvent.CLICK,menuBtn);
				
			/*if(menu_item.padkast.padkast)
				menu_item.padkast.padkast.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.takalif.takalif)
				menu_item.takalif.takalif.addEventListener(MouseEvent.CLICK,menuBtn);
			if(menu_item.azmoon.azmoon)
				menu_item.azmoon.azmoon.addEventListener(MouseEvent.CLICK,menuBtn);*/
			
		}
		public function manageButton()
		{
			removeEventButton();
			
			//menu_item.list_button.gotoAndStop(1)
			menu_item.ostad.gotoAndStop(1)
			menu_item.ahdaf.gotoAndStop(1)
			menu_item.gallery.gotoAndStop(1)
			menu_item.video_btn.gotoAndStop(1)
			menu_item.zamaem_btn.gotoAndStop(1)
			menu_item.pdf_btn.gotoAndStop(1)
			menu_item.help_btn.gotoAndStop(1)
			addEventButton();
		}
		private function rootMenuUpdate(e:Event)
		{
			H_I_Value.ahdaf_path = H_I_Value.plus_path+String(xml[0].node[H_I_Value.rootIndex-1].@ahdaf)
			H_I_Value.ostad_path = H_I_Value.plus_path+String(xml[0].node[H_I_Value.rootIndex-1].@ostad)
		}
		private function STOPF(e:Event)
		{
			if(mc__!= null)
			{
				if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
					mc__.gotoAndStop(1);
				else
				{
					mc__.rdcmndGotoFrame = 1;
					//mc__.rdcmndPause = 1
				}
				isPlay = false;
			}
		}
		private function S_P_R(e:Event)
		{
			if(mc__)
			{
				if(mc__ && isPlay)
				{
					if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
						mc__.stop()
					else
						mc__.rdcmndPause = 1
					isPlay = false;
					p_p.PR_btn.gotoAndStop(1)
				}
				else if(!isPause)
				{
					isPlay = true;
					if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
						mc__.play()
					else
						mc__.rdcmndResume = 1
					p_p.PR_btn.gotoAndStop(2)
				}
			}
		}
		private function ckeck_enabled()
		{
			if(H_I_Value.Index+1>H_I_Value.All_path.length)
			{
				next_btn.enabled = false;
				next_btn.alpha = 0.5;
			}else
			{
				next_btn.enabled = true;
				next_btn.alpha = 1;
			}
			if(H_I_Value.Index-1<=0)
			{
				previouse_btn.enabled = false;
				previouse_btn.alpha = 0.5;
			}else
			{
				previouse_btn.enabled = true;
				previouse_btn.alpha = 1;
			}
			enable_disable()
		}
		private function enable_disable()
		{
			
			//ویرایش true= false شد

			if((String(xml[0].@zamaem)=="false" || String(xml[0].@zamaem)=="dis")&& H_I_Value.attachment_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.zamaem_btn.zamaem_btn.mouseEnabled = false;
				menu_item.zamaem_btn_enabled.visible = false;
			}else
			{
				menu_item.zamaem_btn.zamaem_btn.mouseEnabled = true;
				menu_item.zamaem_btn_enabled.visible = true;
			}
			if((String(xml[0].@film)=="false" || String(xml[0].@film)=="dis")&& H_I_Value.video_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.video_btn.video_btn.mouseEnabled = false;
				menu_item.video_btn_enabled.visible = false;
			}else
			{
				menu_item.video_btn.video_btn.mouseEnabled = true;
				menu_item.video_btn_enabled.visible = true;
			}
			if((String(xml[0].@gallery)=="false" || String(xml[0].@gallery)=="dis") && H_I_Value.gallery_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.gallery.gallery.mouseEnabled = false;
				menu_item.gallery_enabled.visible = false;
			}else
			{
				menu_item.gallery.gallery.mouseEnabled = true;
				menu_item.gallery_enabled.visible = true;
			}
			/*if((String(xml[0].@padkast)=="false" || String(xml[0].@padkast)=="dis") && H_I_Value.padkast_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.padkast.padkast.mouseEnabled = false;
				menu_item.padkast_enabled.visible = false;
			}else
			{
				menu_item.padkast.padkast.mouseEnabled = true;
				menu_item.padkast_enabled.visible = true;
			}
			if((String(xml[0].@takalif)=="false" || String(xml[0].@takalif)=="dis") && H_I_Value.takalif_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.takalif.takalif.mouseEnabled = false;
				menu_item.takalif_enabled.visible = false;
			}else
			{
				menu_item.takalif.takalif.mouseEnabled = true;
				menu_item.takalif_enabled.visible = true;
			}
			//trace((String(xml[0].@azmoon)+String(xml[0].@azmoon)))
			if((String(xml[0].@azmoon)=="false" || String(xml[0].@azmoon)=="dis") && H_I_Value.azmoon_Array[H_I_Value.Index-1]==undefined)
			{
				menu_item.azmoon.azmoon.mouseEnabled = false;
				menu_item.azmoon_enabled.visible = false;
			}else
			{
				menu_item.azmoon.azmoon.mouseEnabled = true;
				menu_item.azmoon_enabled.visible = true;
			}*/
			if(!menu_item.ostad.visible)
				menu_item.ostad_enabled.visible = false;
				
			if(!menu_item.gallery.visible)
				menu_item.gallery_enabled.visible = false;
			
			
			if(!menu_item.video_btn.visible)
				menu_item.video_btn_enabled.visible = false;
			
			if(!menu_item.zamaem_btn.visible)
				menu_item.zamaem_btn_enabled.visible = false;
			
			if(!menu_item.pdf_btn.visible)
				menu_item.pdf_btn_enabled.visible = false;
				
			if(!menu_item.help_btn.visible)
				menu_item.help_btn_enabled.visible = false;
				
			/*if(!menu_item.padkast.visible)
				menu_item.padkast_enabled.visible = false;
				
			if(!menu_item.takalif.visible)
				menu_item.takalif_enabled.visible = false;
				
			if(!menu_item.takalif.visible)
				menu_item.takalif_enabled.visible = false;
			*/
			
			
			//trace("menu_item.azmoon_enabled.visible     "+menu_item.padkast_enabled.visible)
			//trace("menu_item.azmoon_enabled.visible     "+menu_item.takalif_enabled.visible)
			//trace("menu_item.azmoon_enabled.visible     "+menu_item.azmoon_enabled.visible)
		}
		private function NBCK(e:MouseEvent)
		{
			//go_to = false;
			isN =true;
			if(H_I_Value.Index+1<=H_I_Value.All_path.length)
			{
				
				H_I_Value.Index+=1
				index_button()
				rootMenuUpdate(null);
				
				
				if(MovieClip(menu.b.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1]))!= null)
					MovieClip(menu.b.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1])).slid_Click();
				else
				{
					H_I_Value.current_name_play = H_I_Value.Names_Menu_Button[H_I_Value.Index-1]
					
					//H_I_Value.mode_ = String(xml[0].@mode)
					//H_I_Value.video_Array = videoList_Array;
					//H_I_Value.attachment_Array=attachments_Array;
					//H_I_Value.gallery_Array=gallery_Array;
					H_I_Value.SLID_PATH = H_I_Value.All_path[H_I_Value.Index-1]
					H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.START_SLID_LOAD,true));
				}
			}
			//ckeck_enabled()
		}
		private function PBCK(e:MouseEvent)
		{
			//go_to = false;
			isN = false;
			
			if(H_I_Value.Index-1>0)
			{
				H_I_Value.Index-=1
				
				
				
				index_button()
				rootMenuUpdate(null);
				if(MovieClip(menu.b.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1]))!= null)
					MovieClip(menu.b.getChildByName(H_I_Value.Names_Menu_Button[H_I_Value.Index-1])).slid_Click();
				else
				{
					H_I_Value.current_name_play = H_I_Value.Names_Menu_Button[H_I_Value.Index-1]
					//H_I_Value.mode_ = String(xml[0].@mode)
					//H_I_Value.video_Array = videoList_Array;
					//H_I_Value.attachment_Array=attachments_Array;
					//H_I_Value.gallery_Array=gallery_Array;
					H_I_Value.SLID_PATH = H_I_Value.All_path[H_I_Value.Index-1]
					H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.START_SLID_LOAD,true));
				}
			}
			//ckeck_enabled()
			
		}
		private function index_button()
		{
			for(var i=0;i<H_I_Value.maxIndex_Chapter.length;i++)
			{
				if(H_I_Value.Index<=H_I_Value.maxIndex_Chapter[i])
				{
					H_I_Value.rootIndex= i+1;
					break;
				}
			}
				
		}
		private function SSL(e:Event)
		{
			find_chapter();
			loader_calc.visible = true;
			resetButton();
			ckeck_enabled()
			unload_();
			trace("ld path   "+(H_I_Value.plus_path+H_I_Value.SLID_PATH))
			H_I_LoaderManager.UrlLoader(H_I_Value.SLID_PATH,H_I_Value.plus_path+H_I_Value.SLID_PATH,LCF,P_Load,E_Load,URLLoaderDataFormat.BINARY);
			H_I_Value.OLD_PATH = H_I_Value.SLID_PATH;
		}
		private function go_to_chapter(e:Event)
		{
			go_to = 2;
		}
		private function counter_(i:Number):Number
		{
			var c:Number=0;
			for(var j=0;j<i;j++)
			{
				c +=H_I_Value.maxIndex_Chapter[j]
			}
			return c;
		}
		private function find_chapter()
		{
			
			if(go_to==1)
			{
				for(var i=0;i<H_I_Value.maxIndex_Chapter.length;i++)
				{
					if(H_I_Value.maxIndex_Chapter[i]>=H_I_Value.Index)
					{
						if(old_ch != (i+1))
						{
							old_ch = i+1;
							cs = 0;
							if(!isN)
							{
								cs= H_I_Value.maxIndex_Chapter[i] -counter_(i)
								/*if(i==0)
								{
									cs= H_I_Value.maxIndex_Chapter[i]
								}else
								{
									cs= H_I_Value.maxIndex_Chapter[i+1]-H_I_Value.maxIndex_Chapter[i];
								}*/
								change_ = true;
							}
						}
						if(isN)
							cs +=1;
						else if(!isN && !change_)
							cs= Number(currentslid_mc.currentslid_txt.text)-1
						if(i==0)
						{
							countslid_txt.text = "/ "+String(H_I_Value.maxIndex_Chapter[i])
						}
						else
						{
							countslid_txt.text = "/ "+String(H_I_Value.maxIndex_Chapter[i]-H_I_Value.maxIndex_Chapter[i-1])
						}
						
						change_ = false;
						currentslid_mc.currentslid_txt.text = String(cs)
						currentslid_mc.currentslid2_txt.text = String(cs)
						if(xml[0].@title != undefined)
						{
							chap_txt.text = H_I_ConvertFA.convertFA(xml[0].@title)
						}else
						{
							chap_txt.text=H_I_ConvertFA.convertFA("فصل "+(i+1))
						}
						break
					}
				}
			}else if(go_to==2)
			{
				go_to = 3;
				if(xml[0].@title != undefined)
				{
					chap_txt.text = H_I_ConvertFA.convertFA(xml[0].@title)
				}else
				{
					chap_txt.text= H_I_ConvertFA.convertFA("فصل "+(H_I_Value.rootIndex));
				}
				
				if(H_I_Value.rootIndex-1==0)
				{
					countslid_txt.text = "/ "+String(H_I_Value.maxIndex_Chapter[H_I_Value.rootIndex-1])
				}
				else
				{
					countslid_txt.text = "/ "+String(H_I_Value.maxIndex_Chapter[H_I_Value.rootIndex-1]-H_I_Value.maxIndex_Chapter[H_I_Value.rootIndex-2])
				}
				m_i = H_I_Value.end_num;
				
				ci=0;
				for(var ii=H_I_Value.rootIndex-1;ii<H_I_Value.rootIndex;ii++)
				{
					
					if(xml[0].node[ii].@type=="slid")
						ci+=1
						
					for(var j=0;j<H_I_Value.middel_num;j++)
					{
						if(xml[0].node[ii].node[j] ==undefined)
							break;
						if(xml[0].node[ii].node[j].@type=="slid")
							ci+=1
												
						for(var k=0;k<xml[0].node[ii].node[j].*.length();k++)
						{
							if(xml[0].node[ii].node[j].node[k] ==undefined)
								break;
								if((j+1)>=H_I_Value.middel_num && (k+1) == H_I_Value.end_num)
									break;
							if(xml[0].node[ii].node[j].node[k].@type=="slid")
							{
								ci+=1
							}
						}
					}
				}
				
				//ci+=1;
				cs = ci
				currentslid_mc.currentslid_txt.text = String(ci)
				currentslid_mc.currentslid2_txt.text = String(ci)
			}else
			{
				if(!isN)
				{
					cs = Number(currentslid_mc.currentslid_txt.text)
					if(cs-1==0)
					{
						change_ = true;
						old_ch = 2
						go_to = 1;
						find_chapter();
						return;
					}else
					{
						old_ch = cs;
						cs -= 1
						currentslid_mc.currentslid_txt.text = String(cs)
						currentslid_mc.currentslid2_txt.text = String(cs)
					}
				}else
				{
					if(cs+1==0 || cs+1 >Number(countslid_txt.text.substr(countslid_txt.text.indexOf("/")+1)))
					{
						go_to = 1;
						find_chapter();
						return;
					}else
					{
						old_ch = cs;
						cs += 1
						
						currentslid_mc.currentslid_txt.text = String(cs)
						currentslid_mc.currentslid2_txt.text = String(cs)
					}
				}
			}
		}
		
		private function resetButton()
		{
			for(var i=0;i<H_I_Value.Names_Menu_Button.length;i++)
			{
				if(menu.b.getChildByName(H_I_Value.Names_Menu_Button[i])&& H_I_Value.Names_Menu_Button[i]!= H_I_Value.current_name_play)
				{
					MovieClip(menu.b.getChildByName(H_I_Value.Names_Menu_Button[i])).reset();
				}
			}
		}
		private function LCF(e:Event)
		{
			H_I_LoaderManager.dispos(H_I_Value.SLID_PATH);
			var contex_:LoaderContext = new LoaderContext();
			contex_.allowCodeImport = true
			H_I_LoaderManager.byteLoad(H_I_Value.SLID_PATH+"Byte",H_I_Decrypt.StartDecrypt(e.target.data),LCBF,P_Load,E_Load,contex_)
		}
		private function LCBF(e:Event)
		{
			loader_calc.visible = false;
			if(H_I_Value.is_Big_Main)
			{
				if(H_I_Value.is_CP[H_I_Value.Index-1]=="true" && H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").width>881)
				{
					H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").width = 881
					H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte").height = 619
				}
			}
			loader_mc.addChild(H_I_LoaderManager.getLoader(H_I_Value.SLID_PATH+"Byte"))
			p_p.PR_btn.gotoAndStop(2)
			H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.SET_VOLUME,true));
			if(H_I_Value.mode_[H_I_Value.Index-1]=="0")
			{
				loader_mc.scaleX -=0.3
				loader_mc.scaleY -=0.3
				
			}else if(H_I_Value.mode_[H_I_Value.Index-1]=="1")
			{
				if(!H_I_Value.is_Big_Main)
					loader_mc.y = -14
				else
				{
					loader_mc.y = 8
				}
			}else if(H_I_Value.mode_[H_I_Value.Index-1]=="2")
			{
				if(!H_I_Value.is_Big_Main)
					loader_mc.y = 108
				else
					loader_mc.y = 134
			}
			//loader_mc.x=0
			
			if(String(xml[0].@pdf).length == 0 )
			{
				if(H_I_Value.Pdf_Array[H_I_Value.Index-1] != null)
				{
					menu_item.pdf_btn_enabled.visible = false;
				}else
				{
					menu_item.pdf_btn_enabled.visible = true;
				}
			}
			
			
			/*if(String(xml[0].@padkastF).length == 0 )
			{
				if(H_I_Value.padkast_Array[H_I_Value.Index-1] != null)
				{
					menu_item.padkast_enabled.visible = false;
				}else
				{
					menu_item.padkast_enabled.visible = true;
				}
			}
			
			if(String(xml[0].@takalifF).length == 0 )
			{
				if(H_I_Value.takalif_Array[H_I_Value.Index-1] != null)
				{
					menu_item.takalif_enabled.visible = false;
				}else
				{
					menu_item.takalif_enabled.visible = true;
				}
			}
			
			if(String(xml[0].@azmoonF).length == 0 )
			{
				if(H_I_Value.azmoon_Array[H_I_Value.Index-1] != null)
				{
					menu_item.azmoon_enabled.visible = false;
				}else
				{
					menu_item.azmoon_enabled.visible = true;
				}
			}
			
*/			
			
		}
		private function unload_()
		{
			for(var i=0;i<loader_mc.numChildren;i++)
			{
				Loader(loader_mc.getChildAt(i)).unloadAndStop(false);
				SoundMixer.stopAll();
				H_I_LoaderManager.disposAll();
			}
		}
		private function P_Load(e:Event)
		{
			
		}
		private function E_Load(e:Event)
		{
			
		}
		private function CXL(e:Event)
		{
			url.removeEventListener(Event.COMPLETE,CXL)
			Menu_Button = new H_I_CreateButton(menu.b)
			xml = new XML(e.target.data);
			//trace("H_I_Value.plus_path    "+H_I_Value.plus_path)
			if(H_I_Value.plus_path!="data/")
				H_I_Value.plus_path = H_I_Value.plus_path+String(xml[0].@plusPath)
			Menu_Button.start_creat(xml)
			if(this.getChildByName("eventButton") != null)
				MovieClip(this).eventButton.start_();
			on_off();
			disable();
			set_position_y();
		}
		private function on_off()
		{
			
			if(String(xml[0].@pdfon)=="false")
			{
				menu_item.pdf_btn.visible = false;
				menu_item.pdf_btn_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@rahnama)=="false")
			{
				menu_item.help_btn.visible = false;
				menu_item.help_btn_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@zamaem)=="false")
			{
				menu_item.zamaem_btn.visible = false;
				menu_item.zamaem_btn_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@film)=="false")
			{
				menu_item.video_btn.visible = false;
				menu_item.video_btn_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@gallery)=="false")
			{
				menu_item.gallery.visible = false;
				menu_item.gallery_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@ahdaf)=="false")
			{
				menu_item.ahdaf.visible = false;
				menu_item.ahdaf_enabled.visible = false;
				count_off-=1;
			}
			if(String(xml[0].@ostad)=="false")
			{
				menu_item.ostad.visible = false;
				menu_item.ostad_enabled.visible = false;
				count_off-=1;
			}
			
			/*if(String(xml[0].@padkast)=="false")
			{
				menu_item.padkast.visible = false;
				menu_item.padkast_enabled.visible = false;
				count_off-=1;
			}
			
			if(String(xml[0].@takalif)=="false")
			{
				menu_item.takalif.visible = false;
				menu_item.takalif_enabled.visible = false;
				count_off-=1;
			}
			
			if(String(xml[0].@azmoon)=="false")
			{
				menu_item.azmoon.visible = false;
				menu_item.azmoon_enabled.visible = false;
				count_off-=1;
			}*/
		}
		private function disable()
		{
			menu_item.pdf_btn_enabled.visible = false;
			menu_item.help_btn_enabled.visible = false;
			menu_item.zamaem_btn_enabled.visible = false;
			menu_item.video_btn_enabled.visible = false;
			menu_item.gallery_enabled.visible = false;
			menu_item.ahdaf_enabled.visible = false;
			menu_item.ostad_enabled.visible = false;
			
			/*menu_item.padkast_enabled.visible = false;
			menu_item.takalif_enabled.visible = false;
			menu_item.azmoon_enabled.visible = false;*/
			
			if(String(xml[0].@pdfon)=="dis")
			{
				menu_item.pdf_btn.pdf_btn.gotoAndStop(2)
				menu_item.pdf_btn_enabled.visible = true;
			}
			if(String(xml[0].@rahnama)=="dis")
			{
				menu_item.help_btn.help_btn.mouseEnabled = false;
				menu_item.help_btn_enabled.visible = true;
			}
			if(String(xml[0].@zamaem)=="dis")
			{
				menu_item.zamaem_btn.zamaem_btn.mouseEnabled = false;
				menu_item.zamaem_btn_enabled.visible = true;
			}
			if(String(xml[0].@film)=="dis")
			{
				menu_item.video_btn.video_btn.mouseEnabled = false;
				menu_item.video_btn_enabled.visible = true;
			}
			if(String(xml[0].@gallery)=="dis")
			{
				menu_item.gallery.gallery.mouseEnabled = false;
				menu_item.gallery_enabled.visible = true;
			}
			if(String(xml[0].@ahdaf)=="dis")
			{
				menu_item.ahdaf.ahdaf.mouseEnabled = false;
				menu_item.ahdaf_enabled.visible = true;
			}
			if(String(xml[0].@ostad)=="dis")
			{
				menu_item.ostad.ostad.mouseEnabled = false;
				menu_item.ostad_enabled.visible = true;
			}
			
			
			/*if(String(xml[0].@padkast)=="dis")
			{
				menu_item.padkast.padkast.mouseEnabled = false;
				menu_item.padkast_enabled.visible = true;
			}
			
			if(String(xml[0].@takalif)=="dis")
			{
				menu_item.takalif.takalif.mouseEnabled = false;
				menu_item.takalif_enabled.visible = true;
			}
			
			if(String(xml[0].@azmoon)=="dis")
			{
				menu_item.azmoon.azmoon.mouseEnabled = false;
				menu_item.azmoon_enabled.visible = true;
			}*/
			
			
		}
		private function set_position_y()
		{
			var y_:Array = new Array();
			var valid:Array = new Array();
			for(var i=0;i<btn_Arr.length;i++)
			{
				y_[i] = menu_item.getChildByName(btn_Arr[i]).y
				valid[i] = menu_item.getChildByName(btn_Arr[i]).visible
			}
			
			var ii:Number = 0;
			for(;ii<valid.length;ii++)
			{
				if(!valid[ii])
				{
					for(var jj=ii+1;jj<valid.length;jj++)
					{
						if(valid[jj])
						{
							menu_item.getChildByName(btn_Arr[jj]).y = y_[ii]
							menu_item.getChildByName(btn_Arr[jj]+"_enabled").y = y_[ii]
							
							valid[jj]=false;
							break;
						}
					}
				}
			}
		}

		private function MC_List_menu(e:MouseEvent)
		{
			//menu_item.list_button.gotoAndStop(2)
			kill_tween_listMenu();
			if(menu_item.list_button.currentFrame==1)
			{
				menu_item.list_button.gotoAndStop(2)
				if(!H_I_Value.is_Big_Main)
					tw_listMenu = TweenMax.to(menu,0.3,{x:835});
				else
					tw_listMenu = TweenMax.to(menu,0.3,{x:855});
				isOpen_Menu = true;
			}else
			{
				menu_item.list_button.gotoAndStop(1)
				tw_listMenu = TweenMax.to(menu,0.3,{x:menu_X});
				//menu.alpha=0.5// 
				//menu.x = 1266
				isOpen_Menu = false;
			}
			manageButton()
			//menu.alpha=0.5
		}
		private function moveMneu()
		{
			
		}
		private function kill_tween_listMenu()
		{
			if(tw_listMenu)
				tw_listMenu.kill();
		}
		private function updatePlayer(e:Event)
		{
			
			if(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte") != null)
				if(Loader(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte")).numChildren)
				{
					
					mc__ = MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0))			
					
					if(mc__.totalFrames==1)
						mc__ = MovieClip(MovieClip(H_I_LoaderManager.getLoader(H_I_Value.OLD_PATH+"Byte").getChildAt(0))).content_mc
					
					var location_:Number = 0
					if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
						location_ = back_motion_loc(mc__)
					else
					{
						var num_:Number = mc__.rdinfoFrameCount;
						location_=(Math.round(mc__.rdinfoCurrentFrame/(seek_tml.lnght_/100)))
					}
					
						if(H_I_Value.Progress_Menu[H_I_Value.Index]<location_*2 || H_I_Value.Progress_Menu[H_I_Value.Index].toString()== "NaN")
							H_I_Value.Progress_Menu[H_I_Value.Index] =location_*2
					
					currentslid_mc.m_h.height = H_I_Value.Progress_Menu[H_I_Value.Index]/8
					if(MovieClip(menu.b.getChildByName(H_I_Value.current_name_play)))
					{
						
						
						if(MovieClip(menu.b.getChildByName(H_I_Value.current_name_play)).Progress_mc.Progress.width < H_I_Value.Progress_Menu[H_I_Value.Index])
						{
							MovieClip(menu.b.getChildByName(H_I_Value.current_name_play)).Progress_mc.Progress.width = H_I_Value.Progress_Menu[H_I_Value.Index]
							H_I_Value.Progress_Menu[H_I_Value.Index] =location_*2
							
						}
					}
					if(H_I_Value.Progress_Menu[H_I_Value.Index] ==200 && !H_I_Value.Complete_Progress_Menu[H_I_Value.Index])
					{
						H_I_Value.Complete_Progress_Menu[H_I_Value.Index] = true;
						H_I_Value.STAGE.dispatchEvent(new Event(h_i_Event_eTook.PROGRESS_PLAY,true,true));
                        //Save the user state now
                        saveCurrentState();
					}
					if(H_I_Value.is_CP[H_I_Value.Index-1]=="false")
					{
						seek_tml.lnght_ = mc__.totalFrames;
						seek_tml.setSeekLocation(back_motion_loc(mc__))
						if(H_I_Value.IS_MOUSE_UP && mc__.currentFrame==mc__.totalFrames && MovieClip(this).seek_tml.isgoto)
							NBCK(null);
					}
					else
					{
						seek_tml.lnght_ = mc__.rdinfoFrameCount;
						seek_tml.setSeekLocation((Math.round(mc__.rdinfoCurrentFrame/(seek_tml.lnght_/100))))
						if(H_I_Value.IS_MOUSE_UP && mc__.rdinfoCurrentFrame==seek_tml.lnght_ && MovieClip(this).seek_tml.isgoto)
							NBCK(null);
					}
					
				}
		}
		private function back_motion_loc(mc___:MovieClip):Number
		{
			var mode_:Number = Math.round(mc___.currentFrame/(mc___.totalFrames/100))
			return mode_;
		}
		private function NL(e:Event)
		{
			NBCK(null)
		}
		private function PL(e:Event)
		{
			PBCK(null);
		}
		
	}
}
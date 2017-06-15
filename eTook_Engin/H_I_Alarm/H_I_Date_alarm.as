package  eTook_Engin.H_I_Alarm{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Loadear.H_I_LoaderManager;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.globalization.DateTimeFormatter;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class H_I_Date_alarm extends MovieClip{
		private var Date_:Date;
		private var day:Number;
		private var month_:Number;
		private var years:Number;
		private var xml:XML
		private var num:Number;
		private var event_arr:Array
		private var enentObject:Object;
		private var obj_name:Object = new Object();
		public function H_I_Date_alarm() 
		{
			
		}
		public function start_()
		{
			enentObject = new Object();
			H_I_LoaderManager.UrlLoader(H_I_Value.plus_path+"data/date_report.xml",H_I_Value.plus_path+"date_report.xml",CF,PR,IO,null)
		}
		private function CF(e:Event)
		{
			xml = new XML(e.target.data);
			MovieClip(parent).plusButton_mc.start_(xml)
			
			obj_name.poshtibani =poshtibani.y
			obj_name.roydad =roydad.y
			obj_name.porsesh =porsesh.y
			obj_name.online =online.y
			
			addEvent()
			setTime();
		}
		private function PR(e:ProgressEvent)
		{
			
		}
		private function IO(e:IOErrorEvent)
		{
			
		}
		public function dispose()
		{
			removeEvent();
		}
		private function addEvent()
		{
			num = setTimeout(setTime,1000)
			poshtibani.addEventListener(MouseEvent.CLICK,MC)
			roydad.addEventListener(MouseEvent.CLICK,MC)
			porsesh.addEventListener(MouseEvent.CLICK,MC)
			online.addEventListener(MouseEvent.CLICK,MC)
			
			
			poshtibani.addEventListener(MouseEvent.ROLL_OVER,RO)
			roydad.addEventListener(MouseEvent.ROLL_OVER,RO)
			porsesh.addEventListener(MouseEvent.ROLL_OVER,RO)
			online.addEventListener(MouseEvent.ROLL_OVER,RO)
			
			
			poshtibani.addEventListener(MouseEvent.ROLL_OUT,ROu)
			roydad.addEventListener(MouseEvent.ROLL_OUT,ROu)
			porsesh.addEventListener(MouseEvent.ROLL_OUT,ROu)
			online.addEventListener(MouseEvent.ROLL_OUT,ROu)
			
		}
		private function removeEvent()
		{
			poshtibani.removeEventListener(MouseEvent.CLICK,MC)
			roydad.removeEventListener(MouseEvent.CLICK,MC)
			porsesh.removeEventListener(MouseEvent.CLICK,MC)
			online.removeEventListener(MouseEvent.CLICK,MC)
			
			
			poshtibani.removeEventListener(MouseEvent.ROLL_OVER,RO)
			roydad.removeEventListener(MouseEvent.ROLL_OVER,RO)
			porsesh.removeEventListener(MouseEvent.ROLL_OVER,RO)
			online.removeEventListener(MouseEvent.ROLL_OVER,RO)
			
			
			poshtibani.removeEventListener(MouseEvent.ROLL_OUT,ROu)
			roydad.removeEventListener(MouseEvent.ROLL_OUT,ROu)
			porsesh.removeEventListener(MouseEvent.ROLL_OUT,ROu)
			online.removeEventListener(MouseEvent.ROLL_OUT,ROu)
			
		}
		private function RO(e:MouseEvent)
		{
			e.currentTarget.y +=6 
		}
		private function ROu(e:MouseEvent)
		{
			e.currentTarget.y = obj_name[e.currentTarget.name];
		}
		private function MC(e:MouseEvent)
		{
			this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
			H_I_Value.path_child_view = H_I_Value.plus_path+ e.currentTarget.name+".swf"
			MovieClip(parent).menu_window.gotoAndStop("topButton")
		}
		private function setTime()
		{
			clearTimeout(num);
			updateTime()
			event_check();
			event_question();
			event_online();
			num = setTimeout(setTime,1000)
		}
		
		private function event_check()
		{
			enentObject.yellow = splite_Date(String(xml[0].event[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].event[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].event[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].event[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].event[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].event[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].event[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].event[0].gray[0].@time))
			
			
			if(String(xml[0].event[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					//trace("roydad    yellow")
					roydad.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].event[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
				//	trace("roydad    red")
					roydad.gotoAndStop("red");
				}
			}
			if(String(xml[0].event[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//green
				{
					//trace("roydad    green")
					roydad.gotoAndStop("green");
				}
			}

			if(String(xml[0].event[0].gray[0].@on)=="true")
			{
				//trace(checkGray(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					//trace("roydad    gray")
					roydad.gotoAndStop("gray");
				}
			}
			
		}
		private function event_question()
		{
			enentObject.yellow = splite_Date(String(xml[0].question[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].question[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].question[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].question[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].question[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].question[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].question[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].question[0].gray[0].@time))
			
			
			if(String(xml[0].question[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					porsesh.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].question[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					porsesh.gotoAndStop("red");
				}
			}
			if(String(xml[0].question[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					porsesh.gotoAndStop("green");
				}
			}

			if(String(xml[0].question[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					porsesh.gotoAndStop("gray");
				}
			}
			
		}
		private function event_online()
		{
			enentObject.yellow = splite_Date(String(xml[0].online[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].online[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].online[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].online[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].online[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].online[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].online[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].online[0].gray[0].@time))
			
			
			if(String(xml[0].online[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					online.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].online[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					online.gotoAndStop("red");
				}
			}
			if(String(xml[0].online[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					online.gotoAndStop("green");
				}
			}

			if(String(xml[0].online[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					online.gotoAndStop("gray");
				}
			}
			
		}

		private function splite_Date(str:String):Array
		{
			var arr:Array =new Array();
			arr.push(Number(str.substr(0,str.indexOf("/"))))
			var str_ = str.substr(str.indexOf("/")+1)
			arr.push(Number(str_.substr(0,str_.indexOf("/"))))
			arr.push(Number(str_.substr(str_.indexOf("/")+1)))
			return arr;
		}
		private function spliteTime(str:String):Array
		{
			var arr:Array =new Array();
			arr.push(String(str.substr(0,str.indexOf(":"))))
			arr.push(String(str.substr(str.indexOf(":")+1)))
			return arr;
		}
		private function updateTime()
		{
			
			Date_=null;
			Date_ = new Date();
			day =Date_.date
			month_ =Date_.month+1
			years =Date_.fullYear;
		}
		private function checkGray(num1:Number,num2:Number,num3:Number,num4:Number,num5:Number,trc = null):Boolean
		{
			if(trc)
			{
			//	trace("(years==num1)  "+(years==num1)+"   (month_==num2)  "+(month_==num2)+"  (day==num3)  "+(day==num3)+"    (num4>=Date_.hours)  "+(num4.toString()>=Date_.hours.toString())+"   (num5>=Date_.minutes)   "+(num5.toString()>=Date_.minutes.toString()))
				
				
			//	trace("(years==num1)  "+(years+"  "+num1)+"   (month_==num2)  "+(month_+"   "+num2)+"  (day==num3)  "+(day+"  "+num3)+"    (num4>=Date_.hours)  "+(num4.toString()+"   "+Date_.hours.toString())+"   (num5>=Date_.minutes)   "+(num5.toString()+"   "+Date_.minutes.toString()))
			}
			if(years==num1)
			{
				if(month_==num2)
				{
					if(day==num3)
					{
						if(num4.toString()<=Date_.hours.toString())
						{
							if(num5.toString()>=Date_.minutes.toString())
							{
								return true;
							}
						}
					}else if(day>num3)
					{
						return true;
					}
				}else if(month_>num2)
				{
					return true;
				}
			}else if(years>num1)
			{
				return true;
			}
			return false;
		}
		private function checkForGo(num1:Number,num2:Number,num3:Number,num4:Number,num5:Number):Boolean
		{
			if(years==num1)
			{
				if(month_==num2)
				{
					if(day==num3)
					{
						
						if(num4.toString()==Date_.hours.toString())
						{
							if(num5.toString()==Date_.minutes.toString())
							{
								return true;
							}
						}
					}
				}
			}
			return false;
		}
	}
}
package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import flash.events.Event;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class H_I_ButtonsPlus extends MovieClip{
		private var Date_:Date;
		private var day:Number;
		private var month_:Number;
		private var years:Number;
		private var xml:XML
		private var num:Number;
		private var event_arr:Array
		private var enentObject:Object;
		private var save_y:Array;
		public function H_I_ButtonsPlus() 
		{
			//start_()
		}
		public function start_(xml_:XML)
		{
			save_y = new Array();
			save_y.push(android_mc.y);
			save_y.push(ios_mc.y);
			save_y.push(tamrin_mc.y);
			save_y.push(exam_mc.y);
			save_y.push(baresi_mc.y);
			

			xml = xml_;
			setTime();
			addEvent()
			
			num = setTimeout(setTime,1000)
		}
		public function dispose()
		{
			removeEvent()
		}
		private function addEvent()
		{
			android.addEventListener(MouseEvent.CLICK,MC);
			ios.addEventListener(MouseEvent.CLICK,MC);
			takalif.addEventListener(MouseEvent.CLICK,MC);
			azmoon.addEventListener(MouseEvent.CLICK,MC);
			amalkard.addEventListener(MouseEvent.CLICK,MC);
			
			
			android.addEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			ios.addEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			takalif.addEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			azmoon.addEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			amalkard.addEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			
			
			android.addEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			ios.addEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			takalif.addEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			azmoon.addEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			amalkard.addEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			
		}
		private function removeEvent()
		{
			android.removeEventListener(MouseEvent.CLICK,MC);
			ios.removeEventListener(MouseEvent.CLICK,MC);
			takalif.removeEventListener(MouseEvent.CLICK,MC);
			azmoon.removeEventListener(MouseEvent.CLICK,MC);
			amalkard.removeEventListener(MouseEvent.CLICK,MC);
			
			
			android.removeEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			ios.removeEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			takalif.removeEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			azmoon.removeEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			amalkard.removeEventListener(MouseEvent.ROLL_OVER,ROLL_OVERF);
			
			
			android.removeEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			ios.removeEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			takalif.removeEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			azmoon.removeEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
			amalkard.removeEventListener(MouseEvent.ROLL_OUT,ROLL_OUTF);
		}
		private function ROLL_OVERF(e:MouseEvent)
		{
			switch(e.currentTarget.name)
			{
				case "android":
					android_mc.y = save_y[0] - 7
				break;
				case "ios":
					ios_mc.y = save_y[1] - 7
				break;
				case "takalif":
					tamrin_mc.y = save_y[2] - 7
				break;
				case "azmoon":
					exam_mc.y = save_y[3] - 7
				break;
				case "amalkard":
					baresi_mc.y = save_y[4] - 7
				break;
			}
		}
		private function ROLL_OUTF(e:MouseEvent)
		{
			switch(e.currentTarget.name)
			{
				case "android":
					android_mc.y = save_y[0]
				break;
				case "ios":
					ios_mc.y = save_y[1]
				break;
				case "takalif":
					tamrin_mc.y = save_y[2]
				break;
				case "azmoon":
					exam_mc.y = save_y[3]
				break;
				case "amalkard":
					baresi_mc.y = save_y[4]
				break;
			}
		}
		private function MC(e:MouseEvent)
		{
			this.dispatchEvent(new Event(h_i_Event_eTook.PLAY_RESUME,true))
			H_I_Value.path_child_view = H_I_Value.plus_path+ e.currentTarget.name+".swf"
			//trace("H_I_Value.path_child_view   "+H_I_Value.path_child_view)
			MovieClip(parent).menu_window.gotoAndStop("other")
		}
		
		
		
		private function setTime()
		{
			enentObject=null
			enentObject = new Object()
			clearTimeout(num);
			updateTime()
			android_check();
			event_ios();
			event_tamrin();
			event_baresi()
			event_exam();
			num = setTimeout(setTime,1000)
		}
		
		private function android_check()
		{
			enentObject.yellow = splite_Date(String(xml[0].android[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].android[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].android[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].android[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].android[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].android[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].android[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].android[0].gray[0].@time))
			
			
			if(String(xml[0].android[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					android_mc.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].android[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					android_mc.gotoAndStop("red");
				}
			}
			if(String(xml[0].android[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					android_mc.gotoAndStop("green");
				}
			}

			if(String(xml[0].android[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					android_mc.gotoAndStop("gray");
				}
			}
			
		}
		private function event_ios()
		{
			enentObject.yellow = splite_Date(String(xml[0].ios[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].ios[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].ios[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].ios[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].ios[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].ios[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].ios[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].ios[0].gray[0].@time))
			
			
			if(String(xml[0].ios[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					ios_mc.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].ios[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					ios_mc.gotoAndStop("red");
				}
			}
			if(String(xml[0].ios[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					ios_mc.gotoAndStop("green");
				}
			}

			if(String(xml[0].ios[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					ios_mc.gotoAndStop("gray");
				}
			}
			
		}
		private function event_tamrin()
		{
			enentObject.yellow = splite_Date(String(xml[0].tamrin[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].tamrin[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].tamrin[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].tamrin[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].tamrin[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].online[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].tamrin[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].tamrin[0].gray[0].@time))
			
			
			if(String(xml[0].tamrin[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					tamrin_mc.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].tamrin[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					tamrin_mc.gotoAndStop("red");
				}
			}
			if(String(xml[0].tamrin[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					tamrin_mc.gotoAndStop("green");
				}
			}

			if(String(xml[0].tamrin[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					tamrin_mc.gotoAndStop("gray");
				}
			}
			
		}


		private function event_baresi()
		{
			enentObject.yellow = splite_Date(String(xml[0].baresi[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].baresi[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].baresi[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].baresi[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].baresi[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].baresi[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].baresi[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].baresi[0].gray[0].@time))
			
			
			if(String(xml[0].baresi[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					baresi_mc.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].baresi[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					baresi_mc.gotoAndStop("red");
				}
			}
			if(String(xml[0].baresi[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					baresi_mc.gotoAndStop("green");
				}
			}

			if(String(xml[0].baresi[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					baresi_mc.gotoAndStop("gray");
				}
			}
			
		}



		private function event_exam()
		{
			enentObject.yellow = splite_Date(String(xml[0].exam[0].yellow[0].@date))
			enentObject.yellowTime = spliteTime(String(xml[0].exam[0].yellow[0].@time))
			
			enentObject.red = splite_Date(String(xml[0].exam[0].red[0].@date))
			enentObject.redTime = spliteTime(String(xml[0].exam[0].red[0].@time))
			
			enentObject.green = splite_Date(String(xml[0].exam[0].green[0].@date))
			enentObject.greenTime = spliteTime(String(xml[0].exam[0].green[0].@time))
			
			enentObject.gray = splite_Date(String(xml[0].exam[0].gray[0].@date))
			enentObject.grayTime = spliteTime(String(xml[0].exam[0].gray[0].@time))
			
			
			if(String(xml[0].exam[0].yellow[0].@on)=="true")
			{
				if(checkForGo(enentObject.yellow[0],enentObject.yellow[1],enentObject.yellow[2],enentObject.yellowTime[0],enentObject.yellowTime[1]))//Yellow
				{
					exam_mc.gotoAndStop("yellow");
				}
			}
			if(String(xml[0].exam[0].red[0].@on)=="true")
			{
				if(checkForGo(enentObject.red[0],enentObject.red[1],enentObject.red[2],enentObject.redTime[0],enentObject.redTime[1]))//red
				{
					exam_mc.gotoAndStop("red");
				}
			}
			if(String(xml[0].exam[0].green[0].@on)=="true")
			{
				if(checkForGo(enentObject.green[0],enentObject.green[1],enentObject.green[2],enentObject.greenTime[0],enentObject.greenTime[1]))//red
				{
					exam_mc.gotoAndStop("green");
				}
			}

			if(String(xml[0].exam[0].gray[0].@on)=="true")
			{
				if(checkForGo(enentObject.gray[0],enentObject.gray[1],enentObject.gray[2],enentObject.grayTime[0],enentObject.grayTime[1]))//gray
				{
					exam_mc.gotoAndStop("gray");
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
		private function checkGray(num1:Number,num2:Number,num3:Number,num4:Number,num5:Number):Boolean
		{
			if(years==num1)
			{
				if(month_==num2)
				{
					if(day==num3)
					{
						if(num4.toString()>=Date_.hours.toString())
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
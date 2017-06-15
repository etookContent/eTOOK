package  eTook_Engin.H_I_Main_Menu{
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Utility.H_I_ConvertFA;
	import flash.net.NetConnection;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.events.Event;

	public class H_I_Video_manager extends MovieClip{
		public var _video:Video
		private var isFull:Boolean = false;
		private var x_:Number;
		private var y_:Number;
		private var width_:Number;
		private var haight_:Number;
		private var player_seek_loc:Point;
		private var player_loc:Point;
		private var player_transform:Point;
		private var window_button_loc:Point ;
		private var isFrist:Boolean = true;
		public var Current_index:Number=1;
		public var _connection_nc:NetConnection
		public var _stream_ns:NetStream 
		private var _client:Object
		private var isPlay:Boolean = true;
		public function H_I_Video_manager() {
			start_()
		}
 		public function start_()
		{
			addEvenet();
			initialize_text();			
		}
		public function dispose()
		{
			resetVideo()
			removeEvent();
			removeE_F();
		}
		private function addEvenet()
		{
			window_button.back_btn.addEventListener(MouseEvent.CLICK,MC)
			window_button.full.addEventListener(MouseEvent.CLICK,MC)			
			seek_player.next_btn.addEventListener(MouseEvent.CLICK,next_video)
			seek_player.previouse_btn.addEventListener(MouseEvent.CLICK,prev_video)
			
			seek_player.PR_btn.addEventListener(MouseEvent.CLICK,P_P_S)
			seek_player.stop_btn.addEventListener(MouseEvent.CLICK,P_P_S)
		}
		
		private function removeEvent()
		{
			window_button.back_btn.removeEventListener(MouseEvent.CLICK,MC)
			window_button.full.removeEventListener(MouseEvent.CLICK,MC)
			seek_player.next_btn.removeEventListener(MouseEvent.CLICK,next_video)
			seek_player.previouse_btn.removeEventListener(MouseEvent.CLICK,prev_video)
		}
		private function P_P_S(e:MouseEvent)
		{
			
			switch(e.currentTarget.name)
			{
				case "PR_btn":
					if(isPlay)
					{
						trace("pause")
						isPlay = false;
						seek_player.PR_btn.gotoAndStop(1)
						_stream_ns.pause()
					}else
					{
						trace("play")
						isPlay = true;
						seek_player.PR_btn.gotoAndStop(2)
						_stream_ns.resume();
					}
				break;
				case "stop_btn":
					isPlay = false;
					seek_player.PR_btn.gotoAndStop(1)
					_stream_ns.pause();
					_stream_ns.seek(0)
				break;
				case "":
				
				break;
			}
		}

		private function initialize_text()
		{
			window_button_loc = new Point(window_button.x,window_button.y);
			player_transform = new Point(player.width,player.height)
			player_seek_loc = new Point(seek_player.x,seek_player.y)
			player_loc = new Point(player.x,player.y);
			//trace(player_loc)
			x_= bg.x;
			y_= bg.y;
			width_= bg.width;
			haight_= bg.height;
			for(var i=0;i< 15;i++)
			{
				if(H_I_Value.video_Array[H_I_Value.Index-1]!= undefined&&i<H_I_Value.video_Array[H_I_Value.Index-1][0].*.length())
				{
					trace(H_I_ConvertFA.convertFA(H_I_Value.video_Array[H_I_Value.Index-1].video[i].@title))
					MovieClip(side_button.getChildByName("v"+(i+1))).me.text = H_I_ConvertFA.convertFA(String(H_I_Value.video_Array[H_I_Value.Index-1].video[i].@title))
					if(isFrist)
					{
						go()
					}
				}else
				{
					MovieClip(side_button.getChildByName("v"+(i+1))).visible =false;
				}
				
			}
		}
		private function back()
		{
			for(var i=0;i<side_button.numChildren;i++)
			{
				if(side_button.getChildAt(i) is MovieClip && side_button.getChildAt(i).hasOwnProperty("reset"))
				{
					MovieClip(side_button.getChildAt(i)).dispose();
				}
			}
		}
		private function MC(e:MouseEvent)
		{
			switch(e.currentTarget.name)
			{
				case "full":
					if(!isFull)
					{
						window_button.x += 140
						window_button.y -= 100
						player.width = 800
						player.height = 600
						seek_player.y = 292
						player.x = -430;
						player.y = -328;
						isFull = true
						bg.x=-438;
						bg.y=-328;
						bg.width=960
						bg.height=648
						side_button.x +=150
						side_button.y -=80
					}else
					{
						side_button.x -=150
						side_button.y +=80
						window_button.x = window_button_loc.x
						window_button.y = window_button_loc.y
						side_button.visible = true
						player.width = player_transform.x
						player.height = player_transform.y
						player.x = player_loc.x;
						player.y = player_loc.y;
						seek_player.x = player_seek_loc.x
						seek_player.y = player_seek_loc.y
						isFull = false;
						bg.x = x_
						bg.y = y_;
						bg.width =width_
						bg.height =haight_
					}
				break;
				case "back_btn":
					back()
					dispose();
					MovieClip(parent).play();
				break;
			}
			
			
		}
		public function manageButton(str:String)
		{
			if(isFrist)
			{
				isFrist = false;
				return
			}
			for(var i=0;i<side_button.numChildren;i++)
			{
				if(side_button.getChildAt(i) is MovieClip && side_button.getChildAt(i).hasOwnProperty("reset"))
				{
					if(side_button.getChildAt(i).name!=str)
					{
						MovieClip(side_button.getChildAt(i)).reset()
					}
				}
			}
		}
		public function check_visible_button()
		{
			//trace(Current_index+"      "+H_I_Value.video_Array[H_I_Value.Index-1][0].*.length())
			if(Current_index<H_I_Value.video_Array[H_I_Value.Index-1][0].*.length())
			{
				seek_player.next_btn.enabled = true;
				seek_player.next_btn.alpha = 1
			}else
			{
				seek_player.next_btn.enabled = false;
				seek_player.next_btn.alpha = 0.5
			}
			
			
			if(Current_index>1)
			{
				seek_player.previouse_btn.enabled = true;
				seek_player.previouse_btn.alpha = 1
			}else
			{
				seek_player.previouse_btn.enabled = false;
				seek_player.previouse_btn.alpha = 0.5
			}
		}
		private function next_video(e:MouseEvent)
		{
			
			if(Current_index<H_I_Value.video_Array[H_I_Value.Index-1][0].*.length())
			{
				Current_index+=1;
			}else
			{
				seek_player.next_btn.enabled = false;
				seek_player.next_btn.alpha = 0.5
			}
			go()
		}
		private function prev_video(e:MouseEvent)
		{
			
			if(Current_index>1)
			{
				Current_index-=1;
			}else
			{
				seek_player.previouse_btn.enabled = false;
				seek_player.previouse_btn.alpha = 0.5
			}
			go()
		}
		private function go()
		{
			if(!MovieClip(side_button.getChildByName("v"+Current_index)).isCliCK)
				MovieClip(side_button.getChildByName("v"+Current_index)).MC(null);
				
			seek_player.next_btn.enabled = true;
			seek_player.next_btn.alpha = 1
			
			seek_player.previouse_btn.enabled = true;
			seek_player.previouse_btn.alpha = 1
			
			
			if(Current_index<=1)
			{
				seek_player.previouse_btn.enabled = false;
				seek_player.previouse_btn.alpha = 0.5
			}
			
			if(Current_index>=H_I_Value.video_Array[H_I_Value.Index-1][0].*.length())
			{
				seek_player.next_btn.enabled = false;
				seek_player.next_btn.alpha = 0.5
			}
			
			
		}
		public function start_Video(path:String)
		{
			resetVideo()
			 _video = new Video();          
			_video.smoothing = true;
			 _connection_nc = new NetConnection();      
			 _connection_nc.connect(null);
			 _stream_ns= new NetStream(_connection_nc);
			 
			 _client = new Object();      
			 _stream_ns.client = _client; 
			 _client.onMetaData = onMetaData;
			 _video.attachNetStream(_stream_ns);
			 _video.width=531;
			 _video.height=398;
			 player.addChild(_video);
			 _stream_ns.play(H_I_Value.plus_path+path);
			 _stream_ns.soundTransform = new SoundTransform(H_I_Value.video_volume)
			 seek_player.PR_btn.gotoAndStop(2)
			 isPlay = true
			 EN_F()
			
		}
		public function EN_F()
		{
			this.addEventListener(Event.ENTER_FRAME,EF)
		}
		public function removeE_F()
		{
			this.removeEventListener(Event.ENTER_FRAME,EF)
		}
		private function onMetaData(metaData:Object):void
		{
			H_I_Value.duration_video = Number(metaData.duration)
			
            _stream_ns.bufferTime = metaData.duration/20
		}
		private function EF(e:Event)
		{
			var lenght_:Number = H_I_Value.duration_video/100;
			lenght_ = Math.round(_stream_ns.time/lenght_)
			if(H_I_Value.oldNetTime<=lenght_)
				seek_player.seek_mc.setSeekLocation(lenght_)
		}
		private function resetVideo()
		{
			if(_video !=null)
			{
				this.removeEventListener(Event.ENTER_FRAME,EF)
				player.removeChild(_video);
				_video.clear();
				_video= null;
				_connection_nc.close();
				_connection_nc = null
				_stream_ns.close();
				_stream_ns = null
				_client=null
			}
		}
	}
}
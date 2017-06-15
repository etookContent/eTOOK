package eTook_Engin.H_I_PLayer {
	import flash.display.MovieClip;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.media.Video;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	public class H_I_Video_Viewer extends MovieClip {
		private var isMove:Boolean = false;
		private var smallVideoSizeWidth_:Number = 545;
		private var smallVideoSizeHeight_:Number = 409;
		private var _connection_nc :NetConnection;
		public var _stream_ns :NetStream;
		private var P_T:Number=0;
		private var _client :Object;
		private var _video :Video;
		public var Location_:Number= 0;
		[Inspectable(name = "طول سایز کوچک",variable = "smallVideoSizeWidth",defaultValue = "545",type = "Number")]
		public function set smallVideoSizeWidth( value_:Number):void {
	    	
			smallVideoSizeWidth_ = value_;
		}
		
		[Inspectable(name = "ارتفاع سایز کوچک",variable = "smallVideoSizeHeight",defaultValue = "409",type = "Number")]
		public function set smallVideoSizeHeight( value_:Number):void {
	    	
			smallVideoSizeHeight_ = value_;
		}
		
		public function H_I_Video_Viewer() {
			start_()
		}
		public function start_()
		{
			 _video = new Video();          
      		
			 _connection_nc = new NetConnection();      
			 _connection_nc.connect(null);
			 _stream_ns = new NetStream(_connection_nc);      
			 _client = new Object();      
			 _stream_ns.client = _client; 
			 
			 _client.onMetaData = infoF;
			 addEvent();
			 _video.attachNetStream(_stream_ns);
				
			 this.addChild(_video);
			 if(H_I_Value.VIDEO_PATH)      
			 {
				 _stream_ns.play(H_I_Value.VIDEO_PATH);
			 }  
		}
		public function setVideoSeek(time_:Number,isPlay:Boolean = false)
		{
			isMove = true;
			this.removeEventListener(Event.ENTER_FRAME,MoveSeek);
			P_T = H_I_Value.LENGHT_TIME_VIDEO/100*time_ - 0.5
			if(P_T>H_I_Value.LENGHT_TIME_VIDEO)
				P_T = H_I_Value.LENGHT_TIME_VIDEO-0.5;
			
			_stream_ns.pause();
			_stream_ns.seek(P_T);
			if(isPlay)
			{
				_stream_ns.resume();
				this.addEventListener(Event.ENTER_FRAME,MoveSeek);
			}
		}
		function infoF(p_info:Object):void
		{
			_video.width = smallVideoSizeWidth_
			_video.height = smallVideoSizeHeight_
			_video.smoothing = true;
			_video.x=0;
			_video.y=0;
			H_I_Value.LENGHT_TIME_VIDEO = p_info.duration;
			
			//trace(H_I_Value.LENGHT_TIME_VIDEO)
			//trace("meta data   "+p_info.width+"   "+p_info.height+"   "+this.width+"   "+this.height)
			//length_txt.text = "Length: " + (p_info.duration*1000) + " ms";
			//copy_txt.text = "Codec: " + p_info.audiocodecid;
		}
		public function MoveSeek(e:Event)
		{
			
			Location_ = Math.round(_stream_ns.time/(H_I_Value.LENGHT_TIME_VIDEO/100));
			trace("Error    synk "+_stream_ns.time+"    "+P_T)
			MovieClip(parent.parent).handel_video.setSeekLocation(Location_);
			
		}
		public function dispose()
		{
			removeEvent();
		}
		private function addEvent()
		{
			_stream_ns.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			this.addEventListener(Event.ENTER_FRAME,MoveSeek);
		}
		private function removeEvent()
		{
			this.removeEventListener(Event.ENTER_FRAME,MoveSeek);
			_stream_ns.removeEventListener(NetStatusEvent.NET_STATUS, onStatus);
		}
		private function onStatus(p_evt:NetStatusEvent):void
		{

			if(p_evt.info.code == "NetStream.Play.FileStructureInvalid")
			{
				 trace("The MP4's file structure is invalid.", "Status");
			}
			else if(p_evt.info.code == "NetStream.Play.NoSupportedTrackFound")
			{
				 trace("The MP4 doesn't contain any supported tracks", "Status");
			}
			else if(p_evt.info.level == "error")
			{
				 trace("There was some sort of error with the NetStream", "Error");
			}
		}
	}
}

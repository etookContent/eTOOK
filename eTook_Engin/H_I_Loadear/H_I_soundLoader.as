package eTook_Engin.H_I_Loadear {
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundLoaderContext;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	internal class H_I_soundLoader {
		private var C_F:Function
		private var P_F:Function
		private var IO_F:Function
		private var sound_:Sound;
		private var urlR:URLRequest;
		public function H_I_soundLoader(){}
		public function soundLoad(path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:SoundLoaderContext = null)
		{
			C_F = completeFunction
			P_F = PROGRESS
			IO_F = IOError_
		
			sound_ = new Sound();
			urlR = new URLRequest(path);
			sound_.addEventListener(Event.COMPLETE,completeFunction,false,0,true);
			sound_.addEventListener(ProgressEvent.PROGRESS,PROGRESS,false,0,true);
			sound_.addEventListener(IOErrorEvent.IO_ERROR,IOError_,false,0,true);
			sound_.load(urlR,contex); 
		}
		public function dispose()
		{
			try
			{sound_.close();}catch(e:*){}
			sound_.addEventListener(Event.COMPLETE,C_F,false,0,true);
			sound_.addEventListener(ProgressEvent.PROGRESS,P_F,false,0,true);
			sound_.addEventListener(IOErrorEvent.IO_ERROR,IO_F,false,0,true);
			sound_ = null;
			urlR = null;
		}
	}
}

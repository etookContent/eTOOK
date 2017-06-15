package eTook_Engin.H_I_Loadear
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	internal class H_I_UrlLoader {
		private var C_F:Function
		private var P_F:Function
		private var IO_F:Function
		private var url:URLLoader;
		private var urlR:URLRequest;
		public function H_I_UrlLoader() {
			// constructor code
		}
		public function load(path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,dataFormat:String=null)
		{
			C_F = completeFunction
			P_F = PROGRESS
			IO_F = IOError_
			
			url = new URLLoader();
			urlR = new URLRequest(path);
			if(dataFormat)
				url.dataFormat = dataFormat;
			
			url.addEventListener(Event.COMPLETE,completeFunction,false,0,true);
			url.addEventListener(ProgressEvent.PROGRESS,PROGRESS,false,0,true);
			url.addEventListener(IOErrorEvent.IO_ERROR,IOError_,false,0,true);
			url.load(urlR); 
		}
		public function dispose(gc:Boolean = true)
		{
			try
			{url.close();}catch(e:*){}
			
			url.removeEventListener(Event.COMPLETE,C_F,false);
			url.removeEventListener(ProgressEvent.PROGRESS,P_F,false);
			url.removeEventListener(IOErrorEvent.IO_ERROR,IO_F,false);
			url = null;
			urlR = null;
		}
	}
	
}

package  eTook_Engin.H_I_Loadear{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.system.LoaderContext;
	
	internal class H_I_Loader {
		private var C_F:Function
		private var P_F:Function
		private var IO_F:Function
		
		public var loader_:Loader;
		private var urlR:URLRequest;
		public function H_I_Loader()
		{
			
		}
		public function load(path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:LoaderContext = null)
		{
			C_F = completeFunction
			P_F = PROGRESS
			IO_F = IOError_
			
			loader_ = new Loader();
			urlR = new URLRequest(path);
			loader_.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFunction,false,0,true);
			loader_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,PROGRESS,false,0,true);
			loader_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IOError_,false,0,true);
			loader_.load(urlR,contex); 
		}
		public function byteLoad(byteArr:ByteArray,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:LoaderContext = null)
		{
			C_F = completeFunction
			P_F = PROGRESS
			IO_F = IOError_
			loader_ = new Loader();
			loader_.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFunction,false,0,true);
			loader_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,PROGRESS,false,0,true);
			loader_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IOError_,false,0,true);
			loader_.loadBytes(byteArr,contex);
		}
		public function dispose(gc:Boolean = true)
		{
			try
			{loader_.close();}catch(e:*){}
			loader_.contentLoaderInfo.removeEventListener(Event.COMPLETE,C_F,false);
			loader_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,P_F,false);
			loader_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,IO_F,false);
			loader_.contentLoaderInfo.addEventListener(Event.UNLOAD,UNL);
			if(gc)
				loader_.unloadAndStop(gc);
		}
		private function UNL(e:Event)
		{
			loader_.contentLoaderInfo.removeEventListener(Event.UNLOAD,UNL);
			loader_ = null;
			urlR = null;
		}
	}
}

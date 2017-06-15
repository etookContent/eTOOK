package eTook_Engin.H_I_Loadear
{
	import flash.utils.Dictionary;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.media.SoundLoaderContext;
	public class H_I_LoaderManager {
		private static var Loader_Continer:Dictionary = new Dictionary(true);
		public function H_I_LoaderManager() 
		{
			// constructor code
		}
		public static function UrlLoader(name_:String,path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,dataFormat:String=null):void
		{
			if(Loader_Continer[name_] == undefined)
			{
				Loader_Continer[name_] = new H_I_UrlLoader();
				Loader_Continer[name_].load(path,completeFunction,PROGRESS,IOError_,dataFormat);
			}else
				trace("Error: UrlLoader in H_I_LoaderManager this name is found "+name_)
		}
		public static function soundLoader(name_:String,path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:SoundLoaderContext):void
		{
			if(Loader_Continer[name_] == undefined)
			{
				Loader_Continer[name_] = new H_I_soundLoader();
				Loader_Continer[name_].soundLoad(path,completeFunction,PROGRESS,IOError_,contex);
			}else
				trace("Error: loader in soundLoader this name is found "+name_)
		}
		public static function loader(name_:String,path:String,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:LoaderContext):void
		{
			if(Loader_Continer[name_] == undefined)
			{
				Loader_Continer[name_] = new H_I_Loader();
				Loader_Continer[name_].load(path,completeFunction,PROGRESS,IOError_,contex);
			}else
				trace("Error: loader in H_I_LoaderManager this name is found "+name_)
		}
		public static function getLoader(name_:String)
		{
			if(Loader_Continer[name_]==undefined)
				return null
			return Loader_Continer[name_].loader_
		}
		public static function byteLoad(name_:String,byteArr:ByteArray,completeFunction:Function,PROGRESS:Function,IOError_:Function,contex:LoaderContext):void
		{
			if(Loader_Continer[name_] == undefined)
			{
				Loader_Continer[name_] = new H_I_Loader();
				Loader_Continer[name_].byteLoad(byteArr,completeFunction,PROGRESS,IOError_,contex);
			}else
				trace("Error: loader in H_I_LoaderManager this name is found "+name_)
		}
		public static function dispos(name_:String,gc:Boolean=true):void
		{
			if(Loader_Continer[name_] != undefined)
			{
				Loader_Continer[name_].dispose(gc);
				delete Loader_Continer[name_];
			}else
				trace("Error: disposUrlLoader in H_I_LoaderManager this name is Not found "+name_)
		}
		public static function disposAll(gc:Boolean=true):void
		{
			for(var i in Loader_Continer)
			{
				Loader_Continer[i].dispose(gc);
				delete Loader_Continer[i];
			}
		}
	}
}

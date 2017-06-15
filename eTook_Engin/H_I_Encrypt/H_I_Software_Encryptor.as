package eTook_Engin.H_I_Encrypt
{
	// in class baraye drage kardane fileha be window ast
	import flash.display.MovieClip;
	import flash.desktop.NativeDragManager;
	import flash.desktop.ClipboardFormats;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;

	public class H_I_Software_Encryptor extends MovieClip
	{
		private var fileQue:Array;
		public var window:MovieClip;
		private var Enter:Function;
		private var Drop:Function;
		private var Exit:Function;
		public function H_I_Software_Encryptor()
		{

		}
		public function startDraged(window_:MovieClip,EnterDrage:Function = null,Dorp_:Function = null,ExitDrage:Function = null)
		{
			
			window = window_;
			Enter = EnterDrage;
			Exit = ExitDrage;
			Drop = Dorp_;
			startEvent();
		}
		public function stopDraged()
		{
			window.removeEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,dragEnterhandler);
			window.removeEventListener(NativeDragEvent.NATIVE_DRAG_DROP,dropHandler);
			window.removeEventListener(NativeDragEvent.NATIVE_DRAG_EXIT,dragExitHandler);
		}
		public function startEvent()
		{
			window.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,dragEnterhandler);
			window.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP,dropHandler);
			window.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT,dragExitHandler);
		}
		public function dispose()
		{
			stopDraged();
			fileQue = null;
			Enter = null;
			Drop = null;
			Exit = null;
		}
		private function dragEnterhandler(e:NativeDragEvent)
		{
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			
			if (files && files.length)
			{
				queFiles( files );
			}
			else
			{
				queFiles( null );
			}

			if (Enter != null)
			{
				Enter();
			}
		}
		private function dragExitHandler(e:NativeDragEvent)
		{
			queFiles( null );
			if (Exit != null)
			{
				Exit();
			}
		}
		private function dropHandler(e:NativeDragEvent)
		{
			
			var FileList:Array=new Array();
			for each (var file:File in fileQue)
			{
				//trace("sjn")
				FileList.push(file);// Fails because dragExitHandler has nulled fileQue
			}
			if (Drop != null)
			{
				Drop(FileList);
			}
			FileList = null;
		}
		private function queFiles( files:Array ):void
		{
			if (files)
			{
				fileQue = files;
				NativeDragManager.acceptDragDrop(window);
				// Update visuals;
			}else
			{
     			// Update visuals
			
			}
		}
	}
}
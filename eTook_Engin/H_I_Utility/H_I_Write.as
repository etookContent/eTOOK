package eTook_Engin.H_I_Utility {
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.ByteArray;
	
	public class H_I_Write {

		public function H_I_Write() {
			
		}
		public static function write_xml(xml_:XML,Path:String,feedBackFunction:Function=null)
		{
			var file:File = new File(Path);
			//file.nativePath = Path
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(xml_);
			fileStream.close();
			if(feedBackFunction!= null)
				feedBackFunction();
		}
		public static function write_Byte(B_A:ByteArray,Path:String,feedBackFunction:Function=null)
		{
			var file:File = new File(Path);
			//file.nativePath = Path
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(B_A);
			fileStream.close();
			if(feedBackFunction!= null)
				feedBackFunction();
		}
	}
}
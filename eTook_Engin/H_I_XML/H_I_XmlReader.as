package  eTook_Engin.H_I_XML{
	import flash.xml.XMLDocument;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class H_I_XmlReader extends XMLDocument{
		private static var XML_:XML;
		public static var xmlLoader:URLLoader
		public function H_I_XmlReader() {
			// constructor code
		}
		public static function XMLLoad(path_:String)
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onXMLResult);
			xmlLoader.load(new URLRequest(path_));
		}
		private static function onXMLResult(e:Event)
		{
			XML_ = new XML(e.target.data)
			XML_.ignoreWhitespace = true;
			this.dispatchEvent(new Event(h_i_Event_eTook.XML_Loading,true));
		}
	}
}
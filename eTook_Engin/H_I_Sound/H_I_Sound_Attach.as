package  eTook_Engin.H_I_Sound{
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	import flash.media.SoundChannel;
	import flash.events.Event;
	
	public class H_I_Sound_Attach {
		private static var snd:Sound;
		private static var my_Class:Class;
		private static var sndChanel:SoundChannel;
		public function H_I_Sound_Attach() 
		{
			
		}
		public static function start_(name_:String)
		{
			sndChanel = null;
			my_Class  = getDefinitionByName(name_) as Class
			snd = new my_Class();
			sndChanel = snd.play(0);
			sndChanel.addEventListener(Event.SOUND_COMPLETE,SC)
		}
		private static function SC(e:Event)
		{
			sndChanel.removeEventListener(Event.SOUND_COMPLETE,SC)
			snd = null;
			my_Class = null;
		}
	}	
}

package  eTook_Engin.H_I_PLayer{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.events.KeyboardEvent;
	
	public class H_I_VolumeBtn extends MovieClip{

		public function H_I_VolumeBtn() 
		{
			start_()
		}
		public function start_()
		{
			addEvent()
		}
		public function dispose()
		{
			removeEvent()
		}
		private function addEvent()
		{
			menus_vol.addEventListener(MouseEvent.CLICK,MC);
			plus_vol.addEventListener(MouseEvent.CLICK,MC);
			H_I_Value.STAGE.addEventListener(KeyboardEvent.KEY_UP,KU)
		}
		private function removeEvent()
		{
			menus_vol.removeEventListener(MouseEvent.CLICK,MC);
			plus_vol.removeEventListener(MouseEvent.CLICK,MC);
			H_I_Value.STAGE.removeEventListener(KeyboardEvent.KEY_UP,KU)
		}
		private function MC(e:MouseEvent)
		{
			
			switch(e.currentTarget.name)
			{
				case "plus_vol":
					MovieClip(parent).volume_seek_mc.plus_volume()
				break;
				case "menus_vol":
					MovieClip(parent).volume_seek_mc.menus_volume()
				break;
			}
			
			//isMute
		}
		private function KU(e:KeyboardEvent)
		{
			trace(e.keyCode)
			switch(e.keyCode.toString())
			{
				case "38":
					MovieClip(parent).volume_seek_mc.plus_volume()
				break;
				case "40":
					MovieClip(parent).volume_seek_mc.menus_volume()
				break;
			}
		}
	}
}
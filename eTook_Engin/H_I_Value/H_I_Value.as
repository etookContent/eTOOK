package eTook_Engin.H_I_Value {
	import flash.display.Stage;
	
	public class H_I_Value {

		public static var VIDEO_PATH:String = "flv.mp4";
		public static var LENGHT_TIME_VIDEO:Number = 0;
		public static var STAGE_WIDTH:Number = 0;
		public static var STAGE_HEIGHT:Number = 0;
		public static var STAGE:Stage;
		public static var COUNT_MENU_ITEM:Number = 0;
		public static var SLID_PATH:String="";
		public static var OLD_PATH:String = "";
		public static var plus_path:String=""
		public static var mode_:Array//="1"
		public static var video_Array:Array;
		public static var attachment_Array:Array;
		public static var gallery_Array:Array;
		public static var All_path:Array;
		public static var Names_Menu_Button:Array;
		public static var Jump_Array:Array
		public static var Progress_Menu:Array;
		public static var projress_current_menu:Array
		public static var Complete_Progress_Menu:Array;
		public static var Index:Number = 1;
		public static var current_name_play:String;
		public static var IS_MOUSE_UP:Boolean = true;
		public static var BUTTON_PLAYER_CLICK:String=""
		public static var small_window:String="";
		public static var rootIndex:Number = 1;
		public static var ahdaf_path:String;
		public static var ostad_path:String;
		public static var maxIndex_Chapter:Array 
		public static const USER_XML_NAME:String="etook.xml"
		public static var user_xml:XML;
		public static var video_volume:Number=0.5
		public static var duration_video:Number;
		public static var oldNetTime:Number=0;
		public static var howToFrame:Number = 0;
		public static var path_child_view:String=""
		public static var load_value:Number = 0;
		public static var middel_num:Number = 0;
		public static var end_num:Number = 0;
		public static var view_count:Number = 0;
		public static var Pdf_Array:Array;
		public static var is_Big_Main:Boolean = false
		public static var is_CP:Array;
		public static var is_Free:Boolean;
	}
}
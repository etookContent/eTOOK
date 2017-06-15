package eTook_Engin.H_I_StringUtil
{
	public class H_I_RemoveString
	{
		public function H_I_RemoveString()
		{

		}
		public static function remove(Text:String,removeStr:String,istrim:Boolean=true):String
		{
			var myText:String="";
			var topText:String="";
			var BottomText:String="";
			if (istrim)
			{
				myText = H_I_TrimString.trim(Text);
			}
			else
			{
				myText = Text;
			}
			while (myText.search(removeStr)!=-1)
			{
				var index:Number = myText.search(removeStr);
				if(index!= 0)
				{
					BottomText = myText.substr(0,index)
				}
				if(index != myText.length)
				{
					topText = myText.substr(index+removeStr.length)
				}
				myText = BottomText + topText;
			}
			BottomText = null;
			topText = null
			return myText;
		}
		public  function remove_String(Text:String,removeStr:String,istrim:Boolean=true):String
		{
			var myText:String="";
			var topText:String="";
			var BottomText:String="";
			if (istrim)
			{
				myText = H_I_TrimString.trim(Text);
			}
			else
			{
				myText = Text;
			}
			while (myText.search(removeStr)!=-1)
			{
				var index:Number = myText.search(removeStr);
				if(index!= 0)
				{
					BottomText = myText.substr(0,index)
				}
				if(index != myText.length)
				{
					topText = myText.substr(index+removeStr.length)
				}
				myText = BottomText + topText;
			}
			BottomText = null;
			topText = null
			return myText;
		}
		public static function remove_system_path(str_:String):String
		{
			var str = remove(str_,"/")
			str = str.replace(":","a")
			str = str.replace("|","a")
			return str;
		}
	}
}
package eTook_Engin.H_I_StringUtil
{
	public class H_I_ReverseString
	{
		public function H_I_ReverseString()
		{

		}
		public static function Reverse(Text:String,isTrim:Boolean=true):String
		{

			var str:String;
			if (isTrim)
			{
				str = H_I_TrimString.trim(Text);
			}
			else
			{
				str = Text;
			}
			var str2 = "";
			for (var i=str.length-1; i>=0; i--)
			{
				str2 +=  str.charAt(i);
			}
			return str2;
		}
	}
}
package eTook_Engin.H_I_StringUtil
{
	public class H_I_TrimString
	{
		public function H_I_TrimString()
		{
			
		}
		public static function trim(input:String):String
		{
			var startIndex:Number = 0;
			var endIndex:Number = 0;
			var str:String = input;
			input = str.toString();
			for (var i=0; i<input.length; i++)
			{
				if (input.charCodeAt(i) != 32 && input.charCodeAt(i) != 13 && input.charCodeAt(i) != 12 && input.charCodeAt(i) != 10 && input.charCodeAt(i) != 9 )
				{
					startIndex = i;
					break;
				}
			}
			for (var i2=input.length-1; i2>0; i2--)
			{
				if (input.charCodeAt(i2) != 32 && input.charCodeAt(i2) != 13 && input.charCodeAt(i2) != 12 && input.charCodeAt(i2) != 10 && input.charCodeAt(i2) != 9 )
				{
					endIndex = i2;
					break;
				}
			}
			return input.substr(startIndex,(endIndex+1 - startIndex));
		}
	}
}
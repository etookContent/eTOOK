package  eTook_Engin.H_I_Encrypt{
	import flash.utils.ByteArray;
	
	public class H_I_Decrypt {
		private static var lenght_:Number = 50;
		public function H_I_Decrypt() {
			// constructor code
		}
		public static function StartDecrypt(BA:ByteArray):ByteArray
		{
			/*if(BA.length>H_I_key_Lock.lenght_)
			{
				for(var i = 0;i<H_I_key_Lock.lenght_;i++)
				{
					BA[i]-= H_I_key_Lock.key_Lock;
				}
			}else
			{
				for(var j = 0;j<BA.length;j++)
				{
					BA[j]-= H_I_key_Lock.key_Lock;
				}
			}*/
			return BA;
		}
	}
}
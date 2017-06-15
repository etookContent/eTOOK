package  eTook_Engin.H_I_Utility{
	
	public class H_I_Random {
		
		public function H_I_Random() 
		{
			// constructor code
		}
		public static function create(min:Number,max:Number,count:Number):Array
		{
			var rnd_arr:Array = new Array();
			if(max-(min-1)<count)
			{
				trace("تعداد اعداد رندم در این محدوده کم است")
				return new Array()
			}
			for(var i=0;rnd_arr.length<count;i++)
			{
				var isFound:Boolean = false;
				var rnd:Number = Math.round(Math.random()*max)
				if(rnd<min || rnd>max)
				{
					i-=1;
					continue;
				}
				for(var j:Number = 0;j<rnd_arr.length;j++)
				{
					if(rnd==rnd_arr[j])
					{
						isFound = true
						i-=1;
						break;
					}
				}
				if(!isFound)
					rnd_arr.push(rnd);
											
			}
			
			return rnd_arr;
		}
	}
}
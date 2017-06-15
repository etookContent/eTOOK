package eTook_Engin.H_I_Utility
{
	import flash.text.TextField;
	public class H_I_ConvertFA
	{
		var charmapUTF8=			'آابپتثجچحخدذرزژسشصضطظعغفقکكگلمنوهیي؟()،ًئء«»:\nـ';
		var charmapParwin2005Small=	'{~†Š’`›¢¦ª¯±³µ·¹½ÁÅÉÍÑÕÙÝááåëïó÷ùýý?)($—„–><:\nƒ';
		var charmapParwin2005Big=  	'{}ˆŒ”™Ÿ¤¨¬®°²´¶»¿ÃÇËÏÓ×Ûßããçíñõöûÿÿ?)($—ÿ–><:\nƒ';
		var charmapParwin2005Begin=	'{}…‰‘•š¡¥©®°²´¶¸¼ÀÄÈÌÐÔØÜààäêîòöøüü?)($—‚–><:\nƒ';
		var charmapParwin2005End  =	'{~‡‹“˜œ£§«¯±³µ·º¾ÂÆÊÎÒÖÚÞââæìðô÷úþþ?)($—þ–><:\nƒ';
		//charmapParwin2005 = reverse(charmapParwin2005);
		
		private static function convertAndBreak(txt,breakLen)
		{
			var strConverted = convertFA (txt);		
			return breakLine(strConverted , breakLen);
		}
		
		private static function breakLine(txt, breakLen)
		{
			//return txt;
			if (txt.split("\n").length>1)
			{
				var a =txt.split("\n");
				
				var b="";
				for (var index=0;index<a.length;index++)
				{
					b= b +"\n"+ breakLine(a[index],breakLen) ;
				}
				return b;			
			}
		
			var strTemp = "";
			while (txt.length > breakLen)
			{
				var breakLoc = txt.length - breakLen;
				for (var i = breakLoc ; i< txt.length ; i++)
					if ('. ?؟,،!:'.indexOf(txt.charAt(i-1))!= -1)
					{
						breakLoc = i-1;
						break;
					}
				//*/
				strTemp += txt.substr(breakLoc)+"\n";
				txt = txt.substr(0,breakLoc);			
			}
			if (strTemp !="") 		
				txt = strTemp + txt;
			return txt;
		}
		
		public static function convertFA(txt)
		{
			var charmapUTF8=			'آابپتثجچحخدذرزژسشصضطظعغفقکكگلمنوهیي؟()،ًئء«»:\nـ';
		var charmapParwin2005Small=	'{~†Š’`›¢¦ª¯±³µ·¹½ÁÅÉÍÑÕÙÝááåëïó÷ùýý?)($—„–><:\nƒ';
		var charmapParwin2005Big=  	'{}ˆŒ”™Ÿ¤¨¬®°²´¶»¿ÃÇËÏÓ×Ûßããçíñõöûÿÿ?)($—ÿ–><:\nƒ';
		var charmapParwin2005Begin=	'{}…‰‘•š¡¥©®°²´¶¸¼ÀÄÈÌÐÔØÜààäêîòöøüü?)($—‚–><:\nƒ';
		var charmapParwin2005End  =	'{~‡‹“˜œ£§«¯±³µ·º¾ÂÆÊÎÒÖÚÞââæìðô÷úþþ?)($—þ–><:\nƒ';
			if (txt == undefined)
				return "";
			txt = convertEnter(txt);
			var txtNew="";
			var txtLTR = "";
			var newChar = "";
			txt = removeNoUse(txt);
	//		removeAt(
			for (var i=0;i<txt.length;i++)
			{
				var theChar = txt.charAt(i);
				//trace (txt.charCodeAt(i)- ('ا'.charCodeAt(0)));
				//if (isNoUse(theChar)) // this charachter isn't important and must be deleted
				//	continue;
				var index = charmapUTF8.indexOf(theChar);
				if (index<0)  // It's not a Persian character
				{
					txtLTR =txt.charAt(i) + txtLTR ; //reversing ltr parameters
					continue;
				}
				
				if (!nachasbAfter(txt,i) && !nachasbBefore(txt,i))
					newChar =charmapParwin2005Small.charAt(index);
				else if (nachasbAfter(txt,i) && nachasbBefore(txt,i))
					newChar =charmapParwin2005Big.charAt(index);
				else if (!nachasbAfter(txt,i) && nachasbBefore(txt,i))
					newChar =charmapParwin2005Begin.charAt(index);			
				else if (nachasbAfter(txt,i) && !nachasbBefore(txt,i))
					newChar =charmapParwin2005End.charAt(index);						
				
				 
				txtNew +=txtLTR +newChar;
				txtLTR="";
				//txtNew += charmapParwin2005.charAt(charmapUTF8.indexOf(txt.charCodeAt(i)))
				//trace (charmapUTF8.charAt(txt.charCodeAt(i)- ('ا'.charCodeAt(0)) ));
				//trace (txt.charCodeAt(i).toString(16));
			}
			txtNew +=txtLTR;
			txtNew = reverse(txtNew);
			//txt = txt.split("<br>.").join(".<br>");
			txtNew = txtNew.split("~ê").join("è").split("~ë").join("é"); // La farsi!
			//txtNew = txtNew.split("÷").join(":") // TAGHSIM
			return txtNew;
		}
		private static function nachasbAfter(s,i)
		{
			var charmapUTF8=			'آابپتثجچحخدذرزژسشصضطظعغفقکكگلمنوهیي؟()،ًئء«»:\nـ';
			if (i >= s.length-1)
				return true;
			var str = s.charAt(i+1)
			if (charmapUTF8.indexOf(str)<0)
				return true;	
			
			switch(str)
			{
				case ".":
				case " ":
				case ",":
				case "؟":
				case "(":
				case ")":
				case "آ":
				case "ء":	
				case "،":	
				case "«":	
				case "»":
				case ":":			
				case "\n":			
					return true;
				default:
					return false;
			}
		}
		
		private static function nachasbBefore(s,i)
		{
			var charmapUTF8=			'آابپتثجچحخدذرزژسشصضطظعغفقکكگلمنوهیي؟()،ًئء«»:\nـ';
			if (i<=0)
				return true;
				
			var str = s.charAt(i-1)
			if (charmapUTF8.indexOf(str)<0)
				return true;
			switch(str)
			{
				case ".":
				case " ":
				case ",":
				case "؟":
				case "ا":
				case "د":		
				case "ذ":		
				case "ر":
				case "ز":
				case "ژ":
				case "و":
				case "(":
				case ")":
				case "آ":
				case "ء":
				case "،":	
				case "«":	
				case "»":
				case ":":
				case "\n":			
					return true;
				default:
					return false;
			}
		}
		
		private static function removeNoUse(str)
		{
			return str.split("ّ").join("").split("ُ").join("").split("ِ").join("").split("َ").join("").split("¬").join("");
		}
		private static function reverse(str)
		{
			 var sTmp = "";
			 for (var i = 0; i< str.length ; i++) 
			 {
				 sTmp = str.charAt(i) + sTmp;
			 }
		
			 return sTmp;
		}
		
		private static function convertEnter(str)
		{
			if (str == undefined)
				return str;
			str = str.split("<br>").join("\n").split("\r").join("\n");
			
			if (str.split("\n").length<2)
				return str;
			var strArray =str.split("\n");
			var strRet="";
			for (var index=1;index<=strArray.length;index++)
			{
				strRet= strRet+strArray[strArray.length-index];
				if (index<strArray.length)
					strRet= strRet+ "\n";
			}
			
			return strRet;
		}
	}
}
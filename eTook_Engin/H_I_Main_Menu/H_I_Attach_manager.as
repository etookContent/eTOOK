package eTook_Engin.H_I_Main_Menu {
	import flash.display.MovieClip;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.utils.getDefinitionByName;
	import eTook_Engin.H_I_Utility.H_I_ConvertFA;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import com.greensock.TweenMax;
	
	public class H_I_Attach_manager extends MovieClip{
		private var line:Number=0
		private var tw:TweenMax
		public function H_I_Attach_manager() 
		{
			start_();
		}
		public function start_()
		{
			parse();
		}
		public function dispose()
		{
			removeEvent()
		}
		private function addEvent(str:String,path)
		{
			this.getChildByName(str).addEventListener(MouseEvent.CLICK,MC);
			this.getChildByName(str).addEventListener(MouseEvent.ROLL_OVER,ROV);
			this.getChildByName(str).addEventListener(MouseEvent.ROLL_OUT,ROU);
			this.getChildByName(str).addEventListener(MouseEvent.MOUSE_OUT,ROU);
			MovieClip(this.getChildByName(str)).path = H_I_Value.plus_path+ path;
		}
		private function ROV(e:MouseEvent)
		{
			kill();
			tw = TweenMax.to(e.currentTarget,0.3,{scaleX:1.02,scaleY:1.02})
		}
		private function ROU(e:MouseEvent)
		{
			kill();
			tw = TweenMax.to(e.currentTarget,0.3,{scaleX:1,scaleY:1})
		}
		private function removeEvent()
		{
			var index_:Number=0;
			while(this.numChildren)
			{
				this.getChildByName("attach"+index_).removeEventListener(MouseEvent.CLICK,MC);
				this.removeChildAt(0);
				index_+=1
			}
		}
		private function MC(e:MouseEvent)
		{
			navigateToURL(new URLRequest(e.currentTarget.path))
		}
		private function parse()
		{
			var xml:XML = new XML(H_I_Value.attachment_Array[H_I_Value.Index-1])
			for(var i=0;i<xml[0].*.length();i++)
			{
				addObject(i,findFormat(String(xml[0].file[i].@src)),String(xml[0].file[i].@src),String(xml[0].file[i].@title))
			}
		}
		private function addObject(index:Number,format:String,path:String,title:String)
		{
			var icon_attach_mc:Class = getDefinitionByName("icon_attach") as Class
			var mc:MovieClip = new icon_attach_mc()
			mc.name = "attach"+index;
			mc.gotoAndStop(format);
			this.addChild(mc);
			addEvent(String("attach"+index),path)
			mc.title.autoSize = TextFieldAutoSize.LEFT
			mc.title.text = H_I_ConvertFA.convertFA(title);
			var x_H_:Number = 20
			if(this.getChildByName("attach"+String(index-1))!=null)
			{
				x_H_=this.getChildByName("attach"+String(index-1)).width+this.getChildByName("attach"+String(index-1)).x+10;
			}
			if(x_H_+mc.height>500)
			{
				line+=1;
				x_H_=20;
			}
			mc.x=x_H_;
			mc.y =(line*mc.height)+(line*10)
			 
		}
		private function findFormat(str:String):String
		{
			var str_:String= str.substr(str.lastIndexOf(".")+1)
			return str_;
		}
		private function kill()
		{
			if(tw)
				tw.kill();
		}
	}
}
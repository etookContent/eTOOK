package eTook_Engin.H_I_Main_Menu {
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import eTook_Engin.H_I_Loadear.H_I_LoaderManager;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import eTook_Engin.H_I_Value.H_I_Value;
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import eTook_Engin.H_I_Utility.H_I_ConvertFA;
	import com.greensock.TweenMax;
	
	public class H_I_ImageManager extends MovieClip {
		private var img:Array
		private var currentIndex:Number = 0;
		private var tw:TweenMax;
		private var b:Bitmap
		private var defaultX:Number;
		private var space:Number = -2
		private var speed:Number = 20
		public function H_I_ImageManager() {
			start_()
			
		}
		public function start_()
		{
			//trace(H_I_Value.gallery_Array)
			
			imageLoad()
			
		}
		public function dispoose()
		{
			removeEvent()
			removeChild_();
			if(b!=null)
				b.bitmapData.dispose();
			for(var i=0;i<img.length;i++)
			{
				img[i].bitmapData.dispose()
				MovieClip(thumb.getChildAt(i)).removeEventListener(MouseEvent.CLICK,MC_THUM)
				MovieClip(thumb.getChildAt(i)).removeEventListener(MouseEvent.ROLL_OVER,ROVER)
				MovieClip(thumb.getChildAt(i)).removeEventListener(MouseEvent.ROLL_OUT,ROUT)
			}
			MovieClip(parent).play();
		}
		private function addEvent()
		{
			
		}
		private function removeEvent()
		{
			this.removeEventListener(Event.ENTER_FRAME,EF)
		}
		private function imageLoad()
		{
			img = new Array();
			for(var i=0;i<H_I_Value.gallery_Array[H_I_Value.Index-1][0].*.length();i++)
			{
				var str:String = H_I_Value.plus_path+H_I_Value.gallery_Array[H_I_Value.Index-1][0].photo[i].@src;
				H_I_LoaderManager.loader(str+i.toString(),str,CF,PF,IO,null)
			}
			
			defaultX = thumb.x
		}
		private function CF(e:Event)
		{
			
			img[currentIndex] = new Bitmap(e.target.content.bitmapData)
			//trace(currentIndex+"     "+img[currentIndex])
			var cl:Class = getDefinitionByName("thum_mc_lib") as Class;
			var mc:MovieClip = new cl();
			mc.name = "mc"+currentIndex
			mc.addChild(img[currentIndex])
			mc.me.text = H_I_ConvertFA.convertFA(H_I_Value.gallery_Array[H_I_Value.Index-1][0].photo[currentIndex].@title)
			mc.me.visible = false;
			mc.swapChildren(mc.getChildAt(0),mc.getChildAt(1));
			img[currentIndex].x=0
			img[currentIndex].y=0
			mc.width = 93.45;
			mc.height = 62.40;
			
			thumb.addChild(mc)
			
			mc.y=0;
			mc.x=currentIndex*mc.width-currentIndex*space;
			mc.addEventListener(MouseEvent.CLICK,MC_THUM)
			mc.addEventListener(MouseEvent.ROLL_OVER,ROVER)
			mc.addEventListener(MouseEvent.ROLL_OUT,ROUT)
			this.addEventListener(Event.ENTER_FRAME,EF)
			if(currentIndex==0)
			{
				clicked(0)
			}
			currentIndex+=1
		}
		private function EF(e:Event)
		{
			if(mouseY>455&&mouseY<500)
			{
				var x_:Number
				if(mouseX>410)
				{
					kill();
					x_ = thumb.x-speed
					if(x_>= (thumb.width/2)*-1)
						TweenMax.to(thumb,0.3,{x:x_});
					else
						x_ = (thumb.width/2)
					trace("sub")
				}else if(mouseX<320)
				{
					kill();
					
					x_ = thumb.x+speed
					if(x_<= defaultX)
						TweenMax.to(thumb,0.3,{x:x_});
					else
						x_ = thumb.x
					trace("add")
				}
			}
		}
		private function kill()
		{
			if(tw)
				tw.kill();
		}
		private function ROVER(e:MouseEvent)
		{
			e.currentTarget.me.visible = true;
		}
		private function ROUT(e:MouseEvent)
		{
			e.currentTarget.me.visible = false;
		}
		private function PF(e:ProgressEvent)
		{
			
		}
		private function IO(e:IOErrorEvent)
		{
			
		}
		private function MC_THUM(e:MouseEvent)
		{
			clicked(Number(e.currentTarget.name.substr(2)))
		}
		private function removeChild_()
		{
			if(b!=null)
			{
				bitmap_view.removeChild(b)
			}
		}
		private function clicked(num:Number)
		{
			removeChild_();
			b = new Bitmap(img[num].bitmapData)
			bitmap_view.addChild(b)
		}
	}
}
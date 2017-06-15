package eTook_Engin.freeactionscript
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.TweenMax;
	import eTook_Engin.H_I_Value.H_I_Value;
	import eTook_Engin.H_I_Event.h_i_Event_eTook;
	
	public class Scrollbar extends Sprite
	{

		private var _content:MovieClip;
		private var _contentMask:MovieClip;
		private var _slider:MovieClip;
		private var _track:MovieClip;
		private var _scrollPercent:Number= 0;
		private var isDown:Boolean = false;
		private var _scrollSpeed:Number = .5;
		private var _scrollWheelSpeed:int = 10;
		private var _root:Stage;
		private var MCON_MC:MovieClip;
		private var initi:Boolean = false;
		public function init(stg:Stage,$content:MovieClip, $contentMask:MovieClip, $track:MovieClip, $slider:MovieClip, $scrollSpeed:Number = .5):void 
		{
			//trace(stg:Stage,$content+"    "+$contentMask+"    "+$track+"    "+$slider+"    "+$scrollSpeed)
		//	trace("H_I_Value.STAGE   "+H_I_Value.STAGE)
			H_I_Value.STAGE.addEventListener(h_i_Event_eTook.VISIBLE_SCROLL,check_visible);
			_content = $content;
			_contentMask = $contentMask;
			_slider = $slider;
			_track = $track;
			_scrollSpeed = $scrollSpeed;
			_content.mask = _contentMask;
			if(stg)
				_root =stg 
			else
				_root = H_I_Value.STAGE
				
			enable();
			_scrollPercent =  100 / (_track.height - _slider.height)  * ( _slider.y - _track.y);
			MCON_MC = $content
			onMouseDownHandler(null);
		}
		public function INITIALIZE()
		{
			onMouseDownHandler(null);
		}
		public function check_visible(e:Event)
		{
			if(_content.height<=_contentMask.height)
			{
				_root.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				_slider.visible = false;
				_track.visible = false;
			}else
			{
				_root.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				_root.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				_slider.visible = true;
				_track.visible = true;
			}
		}
		public function enable():void 
		{
			_slider.buttonMode = true;
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			if(_slider.visible)
				_root.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
			_root.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			verifyHeight();
		}
		

		public function disable():void 
		{
			_slider.buttonMode = false;
			_slider.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			_root.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
			_root.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function onMouseWheelHandler($event:MouseEvent):void
		{
			
			var scrollDistance:int = $event.delta;
			var minY:int = _track.y;
			var maxY:int = _track.height + _track.y - _slider.height;
			if ((scrollDistance > 0 && _slider.y <= maxY) ||
				(scrollDistance < 0 && _slider.y >= minY))
			{
				_slider.y = _slider.y - (scrollDistance * _scrollWheelSpeed);
				
				if (_slider.y < minY)
				{
					_slider.y = minY;
				}
				else if (_slider.y > maxY)
				{
					_slider.y = maxY;
				}
				
				updateContentPosition();
			}
		}
		

		private function onMouseDownHandler($event:MouseEvent):void
		{
			isDown = true;
			var newRect:Rectangle = new Rectangle(_track.x, _track.y,
												  0, _track.height - _slider.height);
			if(initi)
			{
				_slider.startDrag(false, newRect);
			}
			_root.addEventListener(Event.ENTER_FRAME, updateContentPosition);
		}
		

		private function onMouseUpHandler($event:MouseEvent):void
		{
			if(isDown)
			{
				_slider.stopDrag();
				
				if (_root != null)
				{
					_root.removeEventListener(Event.ENTER_FRAME, updateContentPosition);
				}
			}
			isDown = false;
		}
		

		private function updateContentPosition($event:Event = null):void
		{
			
			var MCdarsad:Number = MCON_MC.height/100;
			var MTdarsad:Number = _track.height/100;
			if(!initi)
			{
				_root.removeEventListener(Event.ENTER_FRAME, updateContentPosition)
			}
			_scrollPercent =  100 / (_track.height - _slider.height)  * ( _slider.y - _track.y);
			var newContentY:Number = _contentMask.y + (_contentMask.height - (_content.height+20)) / 100 * _scrollPercent;
			TweenMax.to(_content, _scrollSpeed, {y:newContentY, ease:Cubic.easeOut,onComplete:Comp});
			
			
		}
		public function Comp()
		{
			if(!initi)
				_root.removeEventListener(Event.ENTER_FRAME, updateContentPosition)
			initi = true
		}

		public function updateSliderPosition():void
		{
			var contentPercent:Number = Math.abs((_content.y - _contentMask.y) / (_content.height - _contentMask.height) * 100);
			var newDraggerY:int = (contentPercent / 100 * (_track.height - _slider.height)) + _track.y;
			_slider.y = newDraggerY;
		}
		

		public function verifyHeight():void
		{
			
		}
		
		public function MCD(e:MouseEvent)
		{
			if(e.currentTarget.name=="upScrollControl")
			{
				MovieClip(_slider.parent).mybuttens.prevPage()
			}else if(e.currentTarget.name =="downScrollControl")
			{
				MovieClip(_slider.parent).mybuttens.nextPage()
			}
		}
		public function destroy():void
		{
			if (_root.hasEventListener(Event.ENTER_FRAME))
			{
				_slider.stopDrag();
				_root.removeEventListener(Event.ENTER_FRAME, updateContentPosition)
			}
			
			disable();
		}

	}
}
package components.layouts
{
	
	import mx.core.ILayoutElement;
	
	import spark.layouts.BasicLayout;

	
	public class KanbanLayout extends BasicLayout {
		
		private var _verticalGap:Number = 6;
		private var _horizontalGap:Number = 3;
		private var paddingTop:Number = 15;
		private var paddingRight:Number = 10;
		
		private var updateCount:uint = 0;
		private var overlapping:Boolean = false;
		
		public function KanbanLayout() {
			super();
		}
	
		public function get horizontalGap():Number
		{
			return _horizontalGap;
		}

		public function set horizontalGap(value:Number):void
		{
			_horizontalGap = value;
		}

		public function get verticalGap():Number
		{
			return _verticalGap;
		}

		public function set verticalGap(value:Number):void
		{
			_verticalGap = value;
		}
		
		public override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			var count:Number = target.numElements;
			var _vGap:Number = verticalGap;
			
			var tH:Number = paddingTop;
			for(var j:int = 0; j < count; j++) {
				var layoutElem:ILayoutElement = target.getElementAt(j);
				layoutElem.setLayoutBoundsSize(NaN,NaN);
				tH += layoutElem.getLayoutBoundsHeight();
		
				if(j < (count - 1)) {
					tH += verticalGap;
				}
					
			}
		
			if(count > 0) {
				
				var xLeft:Number;
				var xRight:Number;
				
				xLeft = 0;
				xRight = 0;
				
				if(tH > unscaledHeight) {
					//make it vertically overlaping
					overlapping = true;
					//_vGap = -elHeight/2 + verticalGap;
				} else {
					overlapping = false;
				}
				
				var layoutElement:ILayoutElement;
				
				var xPos:Number = 0;
				var yPos:Number = paddingTop;
				
				var _cHeight:Number;
				
				for(var i:int = 0; i < count; i++) {
					
					layoutElement = target.getElementAt(i);
					var elWidth:Number = layoutElement.getLayoutBoundsWidth();
					var elHeight:Number = layoutElement.getLayoutBoundsHeight();
					
					if(i % 2 == 0) {
						xPos = xLeft;
					} else {
						xPos = unscaledWidth-layoutElement.getLayoutBoundsWidth() - paddingRight;
					}
					
					//_cHeight = yPos + elHeight;
					_cHeight = yPos + layoutElement.getLayoutBoundsHeight();
					
					layoutElement.setLayoutBoundsPosition(xPos, yPos);
					
					if(overlapping)
						_vGap = -elHeight/2 + verticalGap;
					else
						_vGap = verticalGap;
					
					yPos += elHeight + _vGap;
				}
				
			
				var cWidth:Number = Math.ceil(xRight + elWidth);
				
				
								
				
				//produces an infinite recursion loop and hangs the application
				//target.setContentSize(cWidth, _cHeight);
				
				//set width to target.contentWidth to stop the infinite recursion with the scrollbar
				target.setContentSize(target.contentWidth, _cHeight);
			}
		}
		
		/*public override function measure():void {
			
			return;
			
			var _vGap:Number;
			var elWidth:Number = typicalLayoutElement.getLayoutBoundsWidth();
			var elHeight:Number = typicalLayoutElement.getLayoutBoundsHeight();
			
			if(overlapping)
				_vGap = -elHeight/2 + verticalGap;
			else
				_vGap = verticalGap;
			
			var count:uint = target.numElements;
			
			var mHeight:Number = paddingTop;
			
			for (var i:uint = 0; i < count; i++) {
				var el:ILayoutElement = target.getElementAt(i);
				mHeight += el.getLayoutBoundsHeight();
				
				if(i < count -1)
					mHeight += _vGap;
			}
			
			
			target.measuredWidth = Math.ceil(elWidth);
			target.measuredHeight = Math.ceil(mHeight);
			target.measuredMinWidth = Math.ceil(elWidth);
			target.measuredMinHeight = Math.ceil(mHeight);
			
			
		}*/
		
	}
}
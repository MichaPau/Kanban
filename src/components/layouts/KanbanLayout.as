package components.layouts
{
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import mx.core.ILayoutElement;
	
	import spark.layouts.BasicLayout;
	
	import michaPau.utils.MathUtils;
	
	
	public class KanbanLayout extends BasicLayout {
		
		private var _verticalGap:Number = 6;
		private var _horizontalGap:Number = 3;
		private var _maxRotation:Number = 5;
		private var paddingTop:Number = 15;
		private var paddingRight:Number = 10;
		private var rotationDict:Dictionary = new Dictionary();
		
		private var updateCount:uint = 0;
		private var overlapping:Boolean = false;
		
		public function KanbanLayout() {
			super();
		}
		
		public function get maxRotation():Number
		{
			return _maxRotation;
		}

		public function set maxRotation(value:Number):void
		{
			_maxRotation = value;
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
			
			//trace("KanbanLayout::updateDisplayList "+(++updateCount))
			var count:Number = target.numElements;
			var _vGap:Number = verticalGap;
			
			if(count > 0) {
				var elWidth:Number = typicalLayoutElement.getLayoutBoundsWidth();
				var elHeight:Number = typicalLayoutElement.getLayoutBoundsHeight();
				
				var totalHeight:Number = count*elHeight + verticalGap*(count - 1);
				
				var xLeft:Number;
				var xRight:Number;
				
				xLeft = 0;
				//xRight = unscaledWidth - elWidth;
				//xRight = target.width - elWidth;
				xRight = 0;
				
				if(totalHeight > unscaledHeight) {
					//make it vertically overlaping
					overlapping = true;
					_vGap = -elHeight/2 + verticalGap;
				} else {
					overlapping = false;
				}
				
				var layoutElement:ILayoutElement;
				
				var xPos:Number = 0;
				var yPos:Number = paddingTop;
				
				var _cHeight:Number;
				for(var i:int = 0; i < count; i++) {
					
					layoutElement = target.getElementAt(i);
					layoutElement.setLayoutBoundsSize(NaN,NaN);
					
					if(i % 2 == 0) {
						xPos = xLeft;
					} else {
						xPos = unscaledWidth-layoutElement.getLayoutBoundsWidth() - paddingRight;
					}
					
					_cHeight = yPos + elHeight;
					
					layoutElement.setLayoutBoundsPosition(xPos, yPos);
					
					yPos += elHeight + _vGap;
				}
				
			
				var cWidth:Number = Math.ceil(xRight + elWidth);
				
				
				//try to call it only when the content size has changed - but produces the same result
				//target.contentWidth != cWidth || target.contentHeight != _cHeight
				/*if(updateCount > 1000) {
					trace("contentSize changed");
					trace("unscaledWidth :"+unscaledWidth);
					trace("unscaledHeight:"+unscaledHeight);
					trace("cWidth        :"+cWidth);
					trace("cHeight       :"+_cHeight);
					
				}*/
				
				
				//produces an infinte recursion loop and hangs the application
				//target.setContentSize(cWidth, _cHeight);
				target.setContentSize(target.contentWidth, _cHeight);
			}
		}
		
		public override function measure():void {
			
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
			
			
		}
		/*public function updateDisplayList2(unscaledWidth:Number, unscaledHeight:Number):void {
			
			if(target.numElements > 0) {
				var count:int = target.numElements;
				
				var xPos:Number, xPos2:Number;
				var yPos:Number = paddingTop;
				var maxWidth:Number = 0;
				var maxHeight:Number = 0;
				
				var elWidth:Number = typicalLayoutElement.getLayoutBoundsWidth();
				var elHeight:Number = typicalLayoutElement.getLayoutBoundsHeight();
				
				
				var totalHeight:Number = count*elHeight + verticalGap*(count - 1);
				var columnCount:uint = 1;
				
				if(totalHeight < unscaledHeight) {
					xPos = unscaledWidth/2 - elWidth/2;
				} else {
					if(unscaledWidth >= elWidth*2 + horizontalGap) {
						xPos = unscaledWidth - (elWidth*2 + horizontalGap)/2;
					} else {
						xPos = 0;
						xPos2 = unscaledWidth - elWidth;
					}
					
					columnCount = 2;
				}
					
				var layoutElement:ILayoutElement;
				var columns:uint = 1;
				
				for(var i:int = 0; i < count; i++) {
					
					layoutElement = target.getElementAt(i);
					
					layoutElement.setLayoutBoundsSize(NaN,NaN);
					
					var x:Number;
					var yStep:Number;
					
					if(columnCount != 1) {
						yStep = elHeight/2 + verticalGap;
						if(i % 2 == 0) {
							x = xPos;
						} else {
							x = xPos2;
						}
					} else {
						x = xPos;
						yStep = verticalGap + elHeight;
					}
					
					var y:Number = yPos;
					
					layoutElement.setLayoutBoundsPosition(x,y);
					
					yPos += yStep;
					
					maxWidth  = Math.max(maxWidth, x + layoutElement.getLayoutBoundsWidth());
					maxHeight = Math.max(maxHeight, y + layoutElement.getLayoutBoundsHeight());
				}
				
				
			}
			
			
		}*/
		
		/*public override function measure():void {
			trace("KanbanLayout::measure ");
			
			var layoutTarget:GroupBase = target;
			
			trace(layoutTarget.measuredHeight);
			trace(layoutTarget.height);
			trace(layoutTarget.measuredHeight);
			trace(layoutTarget.explicitHeight);
			
			var count:int = layoutTarget.numElements;
			var lastElement:ILayoutElement = layoutTarget.getElementAt(count -1);
			var elWidth:Number = lastElement.getPreferredBoundsWidth();
			var elHeight:Number = lastElement.getPreferredBoundsHeight();
			var elX:Number = lastElement.getLayoutBoundsX();
			var elY:Number = lastElement.getLayoutBoundsY();
			var w:Number = Math.ceil(elX + elWidth);
			var h:Number = Math.ceil(elY + elHeight);
			
			layoutTarget.measuredWidth = w;
			layoutTarget.measuredHeight = h;
			layoutTarget.measuredMinWidth = w;
			layoutTarget.measuredMinHeight = h;
			
			trace("measuredWidth:"+w);
			trace("measuredHeight"+h);
			
			
		}*/
		/*private function transformElement(element:ILayoutElement, _x:Number, _y:Number, _index:uint):void {
			
			var centerX:Number = element.getLayoutBoundsWidth()/2;
			var centerY:Number = element.getLayoutBoundsHeight()/2;
			var pivot:Vector3D = new Vector3D(centerX, centerY, 1);
			var translation:Vector3D = new Vector3D(_x + centerX, _y + centerY, 0);
			var rotation:Vector3D = new Vector3D(rotationDict[_index], 0, 0);
			
			element.transformAround(pivot, null ,null , translation, null, rotation, null, false);
		}*/
		/*private function transformElement(element:ILayoutElement, degrees:Number, _x:Number, _y:Number):void {
			var m:Matrix = new Matrix();
		
			var centerX:Number = element.getLayoutBoundsWidth() / 2;
			var centerY:Number = element.getLayoutBoundsHeight() /2;
			
			var q:Number  = degrees * Math.PI / 180;
			m.translate(-1 * centerX, -1 * centerY);
			m.rotate(q);
			
			m.translate(centerX + _x, centerY + _y);
			element.setLayoutMatrix(m, false);
		}
		
		public override function elementAdded(index:int):void {
			super.elementAdded(index);
			rotationDict[index] = MathUtils.randomRange(-maxRotation, maxRotation);
		}
		public override function elementRemoved(index:int):void {
			super.elementRemoved(index);
			delete rotationDict[index];
		}*/
	}
}
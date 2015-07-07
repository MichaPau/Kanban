package components.layouts
{
	import flash.geom.Rectangle;
	
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	
	import spark.components.supportClasses.ButtonBarHorizontalLayout;
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.DropLocation;
	
	import framework.appConfig.Constants;
	
	public class DragAndDropButtonBarLayout extends ButtonBarHorizontalLayout
	{
		public var dropIndicatorMode:String;
		
		public function DragAndDropButtonBarLayout() {
			super();
		}
		
		override protected function calculateDropIndex(x:Number, y:Number):int
		{
			switch(dropIndicatorMode) {
				case Constants.DRAG_MODE_BUTTON:
					return calculateDropIndexForButton(x, y);
					break;
				case Constants.DRAG_MODE_ITEM:
					return calculateDropIndexForItem(x, y);
					break;
				default:
					return calculateDropIndexForButton(x, y);
			}
		}
		protected function calculateDropIndexForButton(x:Number, y:Number):int
		{
			// Iterate over the visible elements
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			
			// If there are no items, insert at index 0
			if (count == 0)
				return 0;
			
			// Go through the visible elements
			var minDistance:Number = Number.MAX_VALUE;
			var bestIndex:int = -1;
			var start:int = 0;
			var end:int = count;
			
			for (var i:int = start; i <= end; i++)
			{
				var elementBounds:Rectangle = this.getElementBounds(i);
				if (!elementBounds)
					continue;
				
				if (elementBounds.left <= x && x <= elementBounds.right)
				{
					var centerX:Number = elementBounds.x + elementBounds.width / 2;
					return (x < centerX) ? i : i + 1;
				}
				
				var curDistance:Number = Math.min(Math.abs(x - elementBounds.left),
					Math.abs(x - elementBounds.right));
				if (curDistance < minDistance)
				{
					minDistance = curDistance;
					bestIndex = (x < elementBounds.left) ? i : i + 1;
				}
			}
			
			// If there are no visible elements, either pick to drop at the beginning or at the end
			if (bestIndex == -1)
				bestIndex = getElementBounds(0).x < x ? count : 0;
			
			return bestIndex;
		}
		protected function calculateDropIndexForItem(x:Number, y:Number):int
		{
			// Iterate over the visible elements
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			
			// If there are no items, insert at index 0
			if (count == 0)
				return 0;
			
			// Go through the visible elements
			var minDistance:Number = Number.MAX_VALUE;
			var bestIndex:int = -1;
			var start:int = 0;
			var end:int = count;
			
			for (var i:int = start; i <= end; i++)
			{
				var elementBounds:Rectangle = this.getElementBounds(i);
				if (!elementBounds)
					continue;
				
				if (elementBounds.left <= x && x <= elementBounds.right)
				{
					var centerX:Number = elementBounds.x + elementBounds.width / 2;
					return i;
				}
				
				var curDistance:Number = Math.min(Math.abs(x - elementBounds.left),
					Math.abs(x - elementBounds.right));
				if (curDistance < minDistance)
				{
					minDistance = curDistance;
					bestIndex = i;
				}
			}
			
			// If there are no visible elements, either pick to drop at the beginning or at the end
			if (bestIndex == -1)
				bestIndex = getElementBounds(0).x < x ? count - 1 : 0;
			
			return bestIndex;
		}
		protected override function calculateDropIndicatorBounds(dropLocation:DropLocation):Rectangle {
			switch(dropIndicatorMode) {
				case Constants.DRAG_MODE_BUTTON:
					return calculateDropIndicatorBoundsForButton(dropLocation);
					break;
				case Constants.DRAG_MODE_ITEM:
					return calculateDropIndicatorBoundsForItem(dropLocation);
					break;
				default:
					return calculateDropIndicatorBoundsForButton(dropLocation);
			}
		}
		
		protected function calculateDropIndicatorBoundsForButton(dropLocation:DropLocation):Rectangle {
			//trace("DragAndDropButtonLayout::calculateDropIndicatorBounds");
			var dropIndex:int = dropLocation.dropIndex;
			var count:int = target.numElements;
			var gap:Number = this.gap;
			
			// Special case, if we insert at the end, and the gap is negative, consider it to be zero
			if (gap < 0 && dropIndex == count)
				gap = 0;
			
			var emptySpace:Number = (0 < gap ) ? gap : 0; 
			var emptySpaceLeft:Number = 0;
			if (target.numElements > 0)
			{
				emptySpaceLeft = (dropIndex < count) ? getElementBounds(dropIndex).left - emptySpace : 
					getElementBounds(dropIndex - 1).right + gap - emptySpace;
			}
			
			// Calculate the size of the bounds, take minium and maximum into account
			var width:Number = emptySpace;
			var height:Number = Math.max(target.height, target.contentHeight);
			if (dropIndicator is IVisualElement)
			{
				var element:IVisualElement = IVisualElement(dropIndicator);
				width = Math.max(Math.min(width, element.getMaxBoundsWidth(false)), element.getMinBoundsWidth(false));
			}
			
			var x:Number = emptySpaceLeft + Math.round((emptySpace - width)/2);
			// Allow 1 pixel overlap with container border
			x = Math.max(-Math.ceil(width / 2), Math.min(target.contentWidth - Math.ceil(width/2), x));
			
			var y:Number = 0;
			return new Rectangle(x, y, width, height);
		}
		protected function calculateDropIndicatorBoundsForItem(dropLocation:DropLocation):Rectangle {
			//trace("DragAndDropButtonLayout::calculateDropIndicatorBounds");
			var dropIndex:int = dropLocation.dropIndex;
			var count:int = target.numElements;
			var gap:Number = this.gap;
			
			// Special case, if we insert at the end, and the gap is negative, consider it to be zero
			if (gap < 0 && dropIndex == count)
				gap = 0;
			
			var emptySpace:Number = (0 < gap ) ? gap : 0; 
			var emptySpaceLeft:Number = 0;
			if (target.numElements > 0)
			{
				/*emptySpaceLeft = (dropIndex < count) ? getElementBounds(dropIndex).left - emptySpace : 
					getElementBounds(dropIndex - 1).right + gap - emptySpace;*/
				emptySpaceLeft = (dropIndex < count) ? getElementBounds(dropIndex).left - emptySpace : 
					getElementBounds(dropIndex - 1).right + gap - emptySpace;
			}
			
			// Calculate the size of the bounds, take minium and maximum into account
			var width:Number = emptySpace;
			//var height:Number = Math.max(target.height, target.contentHeight);
			var height:Number = 5;
			if (dropIndicator is IVisualElement)
			{
				var element:IVisualElement = IVisualElement(dropIndicator);
				width = (dropIndex < count) ? getElementBounds(dropIndex).width : getElementBounds(dropIndex - 1).width;
			}
			
			var x:Number = emptySpaceLeft;
			// Allow 1 pixel overlap with container border
			x = Math.max(-Math.ceil(width / 2), Math.min(target.contentWidth - Math.ceil(width/2), x));
			
			var y:Number = -2;
			return new Rectangle(x, y, width, height);
		}
		public override function showDropIndicator(dropLocation:DropLocation):void
		{
			if (!dropIndicator)
				return;
			
			// Make the drop indicator invisible, we'll make it visible 
			// only if successfully sized and positioned
			dropIndicator.visible = false;
			
			var bounds:Rectangle = calculateDropIndicatorBounds(dropLocation);
			if (!bounds)
				return;
			
			if (dropIndicator is ILayoutElement)
			{
				var element:ILayoutElement = ILayoutElement(dropIndicator);
				element.setLayoutBoundsSize(bounds.width, bounds.height);
				element.setLayoutBoundsPosition(bounds.x, bounds.y);
				
				
			}
			else
			{
				dropIndicator.width = bounds.width;
				dropIndicator.height = bounds.height;
				dropIndicator.x = bounds.x;
				dropIndicator.y = bounds.y;
				
				
			}
			
			dropIndicator.visible = true;
		}
	}
}
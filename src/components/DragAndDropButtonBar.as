package components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.DragSource;
	import mx.core.EventPriority;
	import mx.core.IFactory;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.ButtonBar;
	import spark.components.ButtonBarButton;
	import spark.components.IItemRenderer;
	import spark.events.RendererExistenceEvent;
	import spark.layouts.supportClasses.DropLocation;
	
	import components.layouts.DragAndDropButtonBarLayout;
	
	import framework.appConfig.Constants;
	import framework.events.ButtonPositionChangedEvent;
	import framework.events.UpdateTaskEvent;
	import framework.models.vo.BoardVO;
	import framework.models.vo.TaskVO;
	
	import framework.events.ButtonPositionChangedEvent;
	
	
	[Event(name="positionChanged", type="framework.events.ButtonPositionChangedEvent")]
	[Event(name="UpdateTaskEvent_UpdateTaskBoardId", type="framework.events.UpdateTaskEvent")]
	public class DragAndDropButtonBar extends ButtonBar {
		
		[SkinPart(required="false", type="flash.display.DisplayObject")]
		public var dropIndicator:IFactory;
		
		/*[SkinPart(required="false", type="flash.display.DisplayObject")]
		public var dropIndicatorButton:IFactory;
		
		[SkinPart(required="false", type="flash.display.DisplayObject")]
		public var dropIndicatorItem:IFactory;*/
		
		
		private var _dragEnabled:Boolean = false;
		
		[Inspectable(defaultValue="false")]
		
		
		public function get dragEnabled():Boolean {
			return _dragEnabled;
		}
		
		
		public function set dragEnabled(value:Boolean):void{
			if (value == _dragEnabled)
				return;
			_dragEnabled = value;
			
			if (_dragEnabled) {
				addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_DROP, dragDropHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false, EventPriority.DEFAULT_HANDLER);
				
			} else {
				removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false);
				removeEventListener(DragEvent.DRAG_DROP, dragDropHandler, false);
				removeEventListener(DragEvent.DRAG_OVER, dragOverHandler, false);
				removeEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false);
			}
		}
		
		private var newSlidePos:Number;
		
		protected function dragDropHandler(ev:DragEvent):void {
			if (ev.isDefaultPrevented())
				return;
			
			// Hide the drop indicator
			layout.hideDropIndicator();
			destroyDropIndicator();
			
			// Hide focus
			drawFocus(false);
			//drawFocusAnyway = false;
			
			// Get the dropLocation
			var dropLocation:DropLocation = dataGroup.layout.calculateDropLocation(ev);
			if (!dropLocation)
				return;
			
			// Find the dropIndex
			var dropIndex:int = dropLocation.dropIndex;
			
			// Make sure the manager has the appropriate action
			DragManager.showFeedback(DragManager.MOVE);
			
			var dragSource:DragSource = ev.dragSource;
			var item:Object = dragSource.dataForFormat("item") as Object;
			var dragObj:Vector.<Object> = ev.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>;
			
			
			if(item) {
				var removeIndex:uint = dataProvider.getItemIndex(item);
				
				if(dropIndex != removeIndex) {
					
					var lastPos:Boolean = false;
					if(dropIndex >= dataProvider.length) {
						dropIndex = dataProvider.length - 1;
						lastPos = true;
					}
					var pItem:BoardVO = dataProvider.getItemAt(dropIndex) as BoardVO
					var position:int = pItem.position;
					if(lastPos)
						position += 1;
					//trace("new position:"+position);
					//trace("item:"+(pItem as BoardVO).title);
					
					/*dataProvider.removeItemAt(removeIndex);
					
					if(removeIndex < dropIndex)
						dropIndex--;
					
					dataProvider.addItemAt(item, dropIndex);*/
					
					dispatchEvent(new ButtonPositionChangedEvent(
						ButtonPositionChangedEvent.POSITION_CHANGED, position, item));
				}
					
			}
			if(dragObj) {
				var dragTask:TaskVO = dragObj[0] as TaskVO;
				if(dropIndex <= dataProvider.length - 1) {
					var dropItem:BoardVO = dataProvider.getItemAt(dropIndex) as BoardVO;
					var paramDict:Dictionary = new Dictionary();
					paramDict["boardId"] = dropItem.id;
					dispatchEvent(new UpdateTaskEvent(
						UpdateTaskEvent.UPDATE_TASK_BOARD_ID, dragTask.id, paramDict));
				}
				
			}
			
		}
		
		protected function dragEnterHandler(ev:DragEvent):void {
			//Accept the drag only if the user is dragging data
			if (ev.isDefaultPrevented())
				return;
			
			if(ev.dragSource.formats[0] == "item") {
				(dataGroup.layout as DragAndDropButtonBarLayout).dropIndicatorMode = Constants.DRAG_MODE_BUTTON;
			} else {
				(dataGroup.layout as DragAndDropButtonBarLayout).dropIndicatorMode = Constants.DRAG_MODE_ITEM;
			}
			var dropLocation:DropLocation = dataGroup.layout.calculateDropLocation(ev);
			
			
			
			if (dropLocation) {
				DragManager.acceptDragDrop(this);
				
				// Create the dropIndicator instance. The layout will take care of
				// parenting, sizing, positioning and validating the dropIndicator.
				//var dIndInst:DisplayObject = createDropIndicator();
				
				
				
				createDropIndicator();
				// Show focus
				//drawFocusAnyway = true;
				drawFocus(true);
				
				// Notify manager we can drop
				DragManager.showFeedback(DragManager.MOVE);
				
				
				layout.showDropIndicator(dropLocation);
			}
			else
			{
				DragManager.showFeedback(DragManager.NONE);
			}
		}
		
		protected function dragOverHandler(ev:DragEvent):void {
			if (ev.isDefaultPrevented())
				return;
			
			if(ev.dragSource.formats[0] == "item") {
				(dataGroup.layout as DragAndDropButtonBarLayout).dropIndicatorMode = Constants.DRAG_MODE_BUTTON;
			} else {
				(dataGroup.layout as DragAndDropButtonBarLayout).dropIndicatorMode = Constants.DRAG_MODE_ITEM;
			}
			var dropLocation:DropLocation = layout.calculateDropLocation(ev);
			
			
			if (dropLocation) {
				// Show focus
				drawFocus(true);
				
				// Notify manager we can drop
				DragManager.showFeedback(DragManager.MOVE);
				
				
				layout.showDropIndicator(dropLocation);
			} else {
				// Hide if previously showing
				layout.hideDropIndicator();
				
				// Hide focus
				drawFocus(false);
				
				// Notify manager we can't drop
				DragManager.showFeedback(DragManager.NONE);
			}
		}
		protected function dragExitHandler(ev:DragEvent):void {
			if (ev.isDefaultPrevented())
				return;
			
			// Hide if previously showing
			layout.hideDropIndicator();
			
			// Hide focus
			drawFocus(false);
			
			// Destroy the dropIndicator instance
			destroyDropIndicator();
		}
		public function createDropIndicator():DisplayObject {
			// Do we have a drop indicator already?
			if (layout.dropIndicator)
				return layout.dropIndicator;
			
			var dropIndicatorInstance:DisplayObject;
			if (dropIndicator)
			{
				/*switch(_dragMode) {
					case Constants.DRAG_MODE_BUTTON:
						dropIndicatorInstance = DisplayObject(createDynamicPartInstance("dropIndicatorButton"));
						break;
					case Constants.DRAG_MODE_ITEM:
						dropIndicatorInstance = DisplayObject(createDynamicPartInstance("dropIndicatorItem"));
						break;
				}*/
				dropIndicatorInstance = DisplayObject(createDynamicPartInstance("dropIndicator"));
			}
			else
			{
				var dropIndicatorClass:Class = Class(getStyle("dropIndicatorSkin"));
				if (dropIndicatorClass)
					dropIndicatorInstance = new dropIndicatorClass();
			}
			if (dropIndicatorInstance is IVisualElement)
				IVisualElement(dropIndicatorInstance).owner = this;
			
			// Set it in the layout
			layout.dropIndicator = dropIndicatorInstance;
			return dropIndicatorInstance;
		}
		
		public function destroyDropIndicator():DisplayObject {
			var dropIndicatorInstance:DisplayObject = layout.dropIndicator;
			if (!dropIndicatorInstance)
				return null;
			
			// Release the reference from the layout
			layout.dropIndicator = null;
			
			// Release it if it's a dynamic skin part
			var count:int = numDynamicParts("dropIndicator");
			for (var i:int = 0; i < count; i++)
			{
				if (dropIndicatorInstance == getDynamicPartAt("dropIndicator", i))
				{
					// This was a dynamic part, remove it now:
					removeDynamicPartInstance("dropIndicator", dropIndicatorInstance);
					break;
				}
			}
			return dropIndicatorInstance;
		}
		protected override function dataGroup_rendererAddHandler(event:RendererExistenceEvent):void {
			super.dataGroup_rendererAddHandler(event);
			var renderer:IVisualElement = event.renderer;
			
			if (!renderer)
				return;
			
			renderer.addEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
		}
		protected override function dataGroup_rendererRemoveHandler(event:RendererExistenceEvent):void {
			super.dataGroup_rendererRemoveHandler(event);
			
			var renderer:Object = event.renderer;
			
			if (!renderer)
				return;
			
			renderer.removeEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
		}
		
		protected function item_mouseDownHandler(ev:MouseEvent):void {
			ev.currentTarget.addEventListener(MouseEvent.MOUSE_MOVE, item_mouseMoveHandler, false, 0, true);
		}
		
		protected function item_mouseMoveHandler(ev:MouseEvent):void {
			
			ev.currentTarget.removeEventListener(MouseEvent.MOUSE_MOVE, item_mouseMoveHandler, false);
			
			// Get the drag initiator component from the event object.
			var dragInitiator:ButtonBarButton = ButtonBarButton(ev.currentTarget);
			
			var newIndex:int
			
			if (ev.currentTarget is IItemRenderer)
				newIndex = IItemRenderer(ev.currentTarget).itemIndex;
			else
				newIndex = dataGroup.getElementIndex(ev.currentTarget as IVisualElement);
			
			this.setSelectedIndex(newIndex);
			
			var dragItem:Object = dataProvider.getItemAt(newIndex);
			trace("dragItem:"+dragItem);
			
			// Create a DragSource object.
			var ds:DragSource = new DragSource();
			
			// Add the data to the object.
			ds.addData(dragItem, 'item');
			
			// Call the DragManager doDrag() method to start the drag.
			DragManager.doDrag(dragInitiator, ds, ev);
		}
		
	}
}
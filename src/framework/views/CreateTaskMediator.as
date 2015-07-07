package framework.views
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import framework.events.CreateTaskEvent;
	import framework.events.UpdateTaskEvent;
	import framework.views.events.CategoryDataEvent;
	import framework.views.ui.CreateTaskView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;
	
	public class CreateTaskMediator extends Mediator {
		
		[Inject] public var view:CreateTaskView;
		[Inject] public var viewManager:IViewManager;
		
		public override function initialize():void {
			//trace("CreateTaskMedaitor::initialize");
			this.addViewListener(CreateTaskEvent.CREATE_TASK, dispatch);
			this.addViewListener(UpdateTaskEvent.UPDATE_TASK, dispatch);
			this.addViewListener(CloseEvent.CLOSE, onClosePopup);
			
			this.addContextListener(CategoryDataEvent.CATEGORIES_DATA_RETURN, onCategoriesData);
			
			dispatch(new CategoryDataEvent(CategoryDataEvent.GET_CATEGORIES_DATA));
		}
		
		protected function onCategoriesData(ev:CategoryDataEvent):void {
			view.setCategories(ev.data);
		}
		
		protected function onClosePopup(ev:CloseEvent):void {
			viewManager.removeContainer(ev.target as DisplayObjectContainer);
			PopUpManager.removePopUp(ev.target as IFlexDisplayObject);
		}
		public override function destroy():void {
			trace("CreateTaskMedaitor::destroy");
		}
 	}
}
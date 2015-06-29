package framework.views
{
	import framework.events.BoardDataLoadedEvent;
	import framework.events.BoardEvent;
	import framework.models.BoardModel;
	import framework.views.ui.BoardView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class BoardViewMediator extends Mediator {
		
		[Inject] public var view:BoardView;
		[Inject] public var boardModel:BoardModel;
		//[Inject] public var viewManager:IViewManager;
		
		public override function initialize():void {
			//this.addContextListener(BoardDataLoadedEvent.CATEGORIES_LOADED, onCategoriesLoadedHandler);
			this.addContextListener(BoardDataLoadedEvent.CONTAINERS_LOADED, onContainersLoadedHandler);
			this.addContextListener(BoardDataLoadedEvent.TASKS_LOADED, onTasksLoadedHandler);
			
			
			//this.addViewListener(EditCreateTaskEvent.SHOW_TASK_PANEL, dispatch);
			//view.viewManager = this.viewManager;
		}
		
		/*protected function onCategoriesLoadedHandler(ev:BoardDataLoadedEvent):void {
			view.generateLegend(ev.result);
		}*/
		protected function onContainersLoadedHandler(ev:BoardDataLoadedEvent):void {
			view.generateContainers(ev.result, boardModel.FINISHED_TASKS_VIEW_MODE);
		}
		protected function onTasksLoadedHandler(ev:BoardDataLoadedEvent):void {
			view.generateTasks(ev.result);
		}
	}
}
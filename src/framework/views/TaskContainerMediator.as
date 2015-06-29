package framework.views
{
	import framework.events.CreateContainerEvent;
	import framework.events.DeleteContainerEvent;
	import framework.events.DeleteTaskEvent;
	import framework.events.SharedObjectEvent;
	import framework.events.UpdateContainerEvent;
	import framework.events.UpdateTaskEvent;
	import framework.views.events.EditCreateTaskEvent;
	import framework.views.ui.TaskContainerView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class TaskContainerMediator extends Mediator {
		
		[Inject] public var view:TaskContainerView;
		//[Inject] public var viewManager:IViewManager;
		
		public override function initialize():void {
			//trace("TaskContainerMediator::initialize");
			this.addViewListener(UpdateTaskEvent.UPDATE_TASK, dispatch);
			this.addViewListener(DeleteTaskEvent.DELETE_TASK, dispatch);
			this.addViewListener(EditCreateTaskEvent.SHOW_TASK_PANEL, dispatch);
			this.addViewListener(CreateContainerEvent.CREATE, dispatch);
			this.addViewListener(DeleteContainerEvent.DELETE, dispatch);
			this.addViewListener(UpdateContainerEvent.UPDATE, dispatch);
			this.addViewListener(SharedObjectEvent.SAVE, dispatch);
			//view.viewManager = viewManager;
		}
	}
}
package framework.controllers
{
	import framework.events.DeleteTaskEvent;
	import framework.models.BoardModel;
	import framework.services.ISQLTaskService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class DeleteTaskCommand extends Command {
		
		[Inject] public var service:ISQLTaskService;
		[Inject] public var event:DeleteTaskEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			boardModel.removeTask(event.taskId);
			service.deleteTask(event.taskId);
		}
	}
}
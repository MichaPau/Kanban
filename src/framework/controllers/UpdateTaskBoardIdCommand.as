package framework.controllers
{
	import framework.events.UpdateTaskEvent;
	import framework.services.ISQLTaskService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class UpdateTaskBoardIdCommand extends Command {
		[Inject] public var event:UpdateTaskEvent;
		[Inject] public var service:ISQLTaskService;
		
		public override function execute():void {
			service.updateTaskBoardId(event.taskId, event.paramDict["boardId"]);
		}
	}
}
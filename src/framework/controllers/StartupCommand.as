package framework.controllers
{
	import flash.net.SharedObject;
	
	import framework.appConfig.Constants;
	import framework.models.BoardModel;
	import framework.models.vo.SharedObjectVO;
	import framework.services.ISQLService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class StartupCommand extends Command {
		
		[Inject] public var service:ISQLService;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			//trace("StartupCommand::execute");
			var sO:SharedObject = SharedObject.getLocal("KanbanApp");
			if(sO.data[SharedObjectVO.LAST_SELECTED_BOARD_ID]) {
				boardModel.requestBoardId = sO.data[SharedObjectVO.LAST_SELECTED_BOARD_ID];
			} else {
				trace("no bardID in SO");
			}
			if(sO.data[SharedObjectVO.FINISHED_TASK_VIEW_MODE]) {
				boardModel.FINISHED_TASKS_VIEW_MODE = sO.data[SharedObjectVO.FINISHED_TASK_VIEW_MODE];
			} else {
				boardModel.FINISHED_TASKS_VIEW_MODE = Constants.FINISHED_TASKS_POSTIT_MODE;
			}
			service.loadBoards();
		}
	}
}
package framework.controllers
{
	import framework.events.BoardEvent;
	import framework.models.BoardModel;
	import framework.models.vo.BoardVO;
	import framework.services.ISQLService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class DeleteBoardCommand extends Command {
		
		[Inject] public var service:ISQLService;
		[Inject] public var event:BoardEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			
			
			service.deleteBoard(event.boardId);
		}
	}
}
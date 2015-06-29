package framework.controllers
{
	import framework.events.CreateUpdateBoardEvent;
	import framework.models.BoardModel;
	import framework.services.ISQLService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class UpdateBoardCommand extends Command {
		
		[Inject] public var service:ISQLService;
		[Inject] public var event:CreateUpdateBoardEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			service.updateBoard(event.boardVO);
		}
	}
}
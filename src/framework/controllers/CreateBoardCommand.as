package framework.controllers
{
	import flash.events.IEventDispatcher;
	
	import framework.events.CreateUpdateBoardEvent;
	import framework.events.StatusBarMessageEvent;
	import framework.models.BoardModel;
	import framework.services.helper.DatabaseCreator;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.IInjector;
	
	public class CreateBoardCommand extends Command {
		
		//[Inject] public var dbCreator:DatabaseCreator;
		[Inject] public var event:CreateUpdateBoardEvent;
		[Inject] public var injector:IInjector;
		[Inject] public var boardModel:BoardModel;
		[Inject] public var eventDispatcher:IEventDispatcher;
		
		public override function execute():void {
			
			if(boardModel.boards.length < boardModel.MAX_BOARDS_ALLOWED) {
				injector.map(DatabaseCreator);
				var creator:DatabaseCreator = injector.getInstance(DatabaseCreator);
				var newPos:uint =  boardModel.getNewBoardPosition();
				//trace("CreateBoardCommand::execute new board pos:"+newPos)
				creator.createNewBoard(event.boardVO.title, newPos, event.catFromBoardId);
			} else {
				eventDispatcher.dispatchEvent(new StatusBarMessageEvent(StatusBarMessageEvent.SHOW_MESSAGE, 
					"Only max. " + boardModel.MAX_BOARDS_ALLOWED + " boards allowed"));
			}
		}
	}
}
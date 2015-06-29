package
{
	
	import flash.events.Event;
	
	import framework.events.BoardDataLoadedEvent;
	import framework.events.BoardEvent;
	import framework.events.StatusBarMessageEvent;
	import framework.events.UpdateBoardResultEvent;
	import framework.models.BoardModel;
	import framework.models.vo.BoardVO;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	
	public class KanbanMediator extends Mediator {
		
		[Inject] public var app:Kanban
		[Inject] public var mediatorMap:IMediatorMap;
		[Inject] public var boardModel:BoardModel;
		
		public override function initialize():void {
			trace("KanbanMediator::initialize");
			mediatorMap.mediate(app.nativeMenu);
			
			this.addContextListener(StatusBarMessageEvent.SHOW_MESSAGE, onStatusBarMessage);
			this.addContextListener(BoardEvent.BOARD_LOADED, showBoard);
			this.addContextListener(UpdateBoardResultEvent.RESULT, showBoard);
			
		}
		
		protected function showBoard(ev:Event):void {
			
			var sBoard:BoardVO = boardModel.getSelectedBoard();
			
			if(sBoard) {
				app.title = sBoard.title;
				app.boardBackground.color = sBoard.backgroundColor;
			} else {
				app.title = "Kanban";
				app.boardBackground.color = 0x0087BD;
			}
			
		}
		protected function onStatusBarMessage(ev:StatusBarMessageEvent):void {
			app.showStatusMessage(ev.message);
		}
	}
}
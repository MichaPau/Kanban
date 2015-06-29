package framework.views
{
	
	import framework.events.BoardDataLoadedEvent;
	import framework.events.BoardEvent;
	import framework.events.CreateUpdateBoardEvent;
	import framework.events.UpdateBoardResultEvent;
	import framework.views.ui.BoardTabView;
	
	import michaPau.events.ButtonPositionChangedEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class BoardTabMediator extends Mediator {
		
		[Inject] public var view:BoardTabView;
		
		public override function initialize():void {
			this.addContextListener(BoardDataLoadedEvent.BOARDS_LOADED, onBoardsLoadedHandler);
			this.addContextListener(UpdateBoardResultEvent.RESULT, onUpdateBoardHandler);
			this.addViewListener(BoardEvent.GET_BOARD_DATA, dispatch);
			this.addViewListener(CreateUpdateBoardEvent.CREATE, dispatch);
			this.addViewListener(CreateUpdateBoardEvent.UPDATE, dispatch);
			this.addViewListener(BoardEvent.DELETE, dispatch);
			this.addViewListener(ButtonPositionChangedEvent.POSITION_CHANGED, dispatch)
		}
		
		protected function onBoardsLoadedHandler(ev:BoardDataLoadedEvent):void {
			trace("BoardsTabMediator::onBoardsLoadedHandler");
			
			view.createButtonBar(ev.result, ev.selectBoardId);
		}
		
		protected function onUpdateBoardHandler(ev:UpdateBoardResultEvent):void {
			view.updateBoard(ev.boardVO);
		}
	}
}
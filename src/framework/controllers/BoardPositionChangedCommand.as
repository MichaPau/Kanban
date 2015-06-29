package framework.controllers
{
	import framework.models.BoardModel;
	import framework.models.vo.BoardVO;
	import framework.models.vo.ContainerVO;
	
	import michaPau.events.ButtonPositionChangedEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class BoardPositionChangedCommand extends Command {
		
		[Inject] public var event:ButtonPositionChangedEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			trace("BoardPositionChangedEvent::execute");
			
			/*var movedBoard:ContainerVO = event.itemData as BoardVO;
			if(event.newIndex == 0)
				movedBoard.position = 1;
			else 
				movedBoard.position = (boardModel.boards.getItemAt(event.newIndex - 1) as BoardVO).position + 1;
			
			var updateList:Array = new Array();
			updateList.push(movedBoard);
			
		
			for each(var item:BoardVO in boardModel.boards) {
				if(item.position >= movedBoard.position) {
					var updateBoard:BoardVO = new BoardVO();
					updateBoard.id = item.id;
					updateBoard.position = item.position + 1;
					updateList.push(updateBoard);
				}
			}*/
		}
	}
}
package framework.controllers
{
	import flash.data.SQLResult;
	
	import mx.collections.ArrayCollection;
	
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	
	import framework.events.BoardEvent;
	import framework.models.BoardModel;
	import framework.services.ISQLService;
	
	
	public class LoadBoardContainersCommand extends AsyncCommand {
		
		[Inject] public var service:ISQLService;
		[Inject] public var event:BoardEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			//trace("LoadBoardContainersCommand::execute");
			service.loadContainers(event.boardId, onContainersResultHandler);
		}
		
		protected function onContainersResultHandler(ev:SQLResult):void {
			var resultCollection:ArrayCollection = new ArrayCollection(ev.data);
			boardModel.containers = resultCollection;
			dispatchComplete(true);
		}
	}
}
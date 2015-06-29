package framework.controllers
{
	import flash.data.SQLResult;
	
	import mx.collections.ArrayCollection;
	
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	
	import framework.events.BoardEvent;
	import framework.models.BoardModel;
	import framework.services.ISQLService;
	
	public class LoadBoardCategoriesCommand extends AsyncCommand {
		
		[Inject] public var service:ISQLService;
		[Inject] public var event:BoardEvent;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			//trace("LoadBoardCategoriesCommand::execute -> "+event.boardId);
			service.loadCategories(event.boardId, onCategoriesResultHandler);
		}
		
		protected function onCategoriesResultHandler(ev:SQLResult):void {
			var resultCollection:ArrayCollection = new ArrayCollection(ev.data);
			boardModel.categories = resultCollection;
			dispatchComplete(true);
		}
	}
}
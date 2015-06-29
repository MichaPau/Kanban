package framework.controllers
{
	import mx.collections.ArrayCollection;
	
	import framework.events.UpdateCategoryEvent;
	import framework.models.BoardModel;
	import framework.models.vo.TaskVO;
	import framework.services.ISQLService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class UpdateCategoryCommand extends Command {
		
		[Inject] public var event:UpdateCategoryEvent;
		[Inject] public var service:ISQLService;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
			service.updateCategory(event.categoryId, event.columnName, event.columnValue);
			
			if(event.columnName == "color") {
				var tasks:ArrayCollection = boardModel.tasks;
				
				for each(var item:TaskVO in tasks) {
					if(item.categoryId == event.categoryId) {
						item.color = event.columnValue as uint;
					}
				}
			}
		}
	}
}
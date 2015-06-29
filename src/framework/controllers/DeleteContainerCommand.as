package framework.controllers
{
	import framework.events.DeleteContainerEvent;
	import framework.models.BoardModel;
	import framework.models.vo.ContainerVO;
	import framework.models.vo.TaskVO;
	import framework.services.ISQLContainerService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class DeleteContainerCommand extends Command {
		
		[Inject] public var event:DeleteContainerEvent;
		[Inject] public var service:ISQLContainerService;
		[Inject] public var boardModel:BoardModel;
		
		public override function execute():void {
		
			//tasks to move to backLog
			var taskList:Array = new Array;
			
			//containers which needs position update
			var cList:Array = new Array();
			
			for each(var item:ContainerVO in boardModel.containers) {
				if(item.position > event.containerVO.position) {
					var updateContainer:ContainerVO = new ContainerVO();
					updateContainer.id = item.id;
					updateContainer.position = item.position - 1;
					cList.push(updateContainer);
				}
			}
			
			var backLogId:uint = boardModel.getBacklogId();
			
			for each(var taskItem:TaskVO in boardModel.tasks) {
				if(taskItem.containerId == event.containerVO.id) {
					taskList.push(taskItem);
				}
			}
			
			
			service.deleteContainer(event.containerVO.id, cList, taskList);
		}
	}
}
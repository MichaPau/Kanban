package framework.controllers
{
	import framework.events.CreateContainerEvent;
	import framework.models.BoardModel;
	import framework.models.vo.ContainerVO;
	import framework.services.ISQLContainerService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CreateContainerCommand extends Command {
		
		[Inject] public var event:CreateContainerEvent;
		[Inject] public var boardModel:BoardModel;
		[Inject] public var service:ISQLContainerService;
		
		public override function execute():void {
			
			var newContainer:ContainerVO = event.container;
			
			var cList:Array = new Array();
			
			for each(var item:ContainerVO in boardModel.containers) {
				if(item.position >= newContainer.position) {
					var updateContainer:ContainerVO = new ContainerVO();
					updateContainer.id = item.id;
					updateContainer.position = item.position + 1;
					cList.push(updateContainer);
				}
			}
			
			service.createContainer(boardModel.selectedBoardId, newContainer, cList);
		}
	}
}
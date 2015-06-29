package framework.controllers
{
	import framework.events.UpdateContainerEvent;
	import framework.services.ISQLContainerService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class UpdateContainerCommand extends Command {
		
		[Inject] public var event:UpdateContainerEvent;
		[Inject] public var service:ISQLContainerService;
		
		public override function execute():void {
			service.updateContainer(event.paramDict, event.containerId);
		}
	}
}
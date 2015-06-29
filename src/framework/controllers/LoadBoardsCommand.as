package framework.controllers
{
	import framework.services.ISQLService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LoadBoardsCommand extends Command {
		
		[Inject] public var service:ISQLService;
		
		public override function execute():void {
			//trace("LoadBoardsCommand:execute");
			service.loadBoards();
		}
	}
}
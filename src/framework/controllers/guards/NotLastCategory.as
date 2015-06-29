package framework.controllers.guards
{
	import flash.events.IEventDispatcher;
	
	import framework.events.StatusBarMessageEvent;
	import framework.models.BoardModel;
	
	import robotlegs.bender.framework.api.IGuard;
	
	public class NotLastCategory implements IGuard {
		
		[Inject] public var boardModel:BoardModel;
		[Inject] public var eventDispatcher:IEventDispatcher;
		
		public function approve():Boolean {
			
			if(boardModel.categories.length > 1)
				return true;
			else {
				eventDispatcher.dispatchEvent(new StatusBarMessageEvent(StatusBarMessageEvent.SHOW_MESSAGE, "The last category can not be deleted."));
				return false;
			}
			//
		}
	}
}
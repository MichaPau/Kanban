package framework.events
{
	import flash.events.Event;
	
	import framework.models.vo.ContainerVO;
	
	public class DeleteContainerEvent extends Event
	{
		public static const DELETE:String = "DeleteContainerEvent_delete";
		
		public var containerVO:ContainerVO;
		
		public function DeleteContainerEvent(type:String, cVO:ContainerVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			containerVO = cVO;
		}
		
		public override function clone():Event {
			return new DeleteContainerEvent(type, containerVO);
		}
	}
}
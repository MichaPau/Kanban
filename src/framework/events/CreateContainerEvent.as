package framework.events
{
	import flash.events.Event;
	
	import framework.models.vo.ContainerVO;
	
	public class CreateContainerEvent extends Event {
		
		public static const CREATE:String = "CreateContainerEvent_create";;
		
		public var container:ContainerVO;
		
		public function CreateContainerEvent(type:String, _container:ContainerVO = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			container = _container;
		}
		
		public override function clone():Event {
			return new CreateContainerEvent(type, container);
		}
	}
}
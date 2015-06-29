package framework.events
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class UpdateContainerEvent extends Event
	{
		public static const UPDATE:String = "UpdateContainerEvent_update";
		
		public var containerId:uint;
		public var paramDict:Dictionary;
		
		public function UpdateContainerEvent(type:String, _containerId:uint = 0, _paramDict:Dictionary = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			containerId = _containerId;
			paramDict = _paramDict;
		}
		
		public override function clone():Event {
			return new UpdateContainerEvent(type, containerId, paramDict);
		}
	}
}
package framework.events
{
	import flash.events.Event;
	
	import framework.models.vo.TaskVO;
	
	public class CreateTaskEvent extends Event {
		
		public static const CREATE_TASK:String = "CreateTaskEvent_createtask";
		public var task:TaskVO;
		
		public function CreateTaskEvent(type:String, _task:TaskVO = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			task = _task;
		}
		
		public override function clone():Event {
			return new CreateTaskEvent(type, task);
		}
	}
}
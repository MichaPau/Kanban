package framework.views.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import framework.models.vo.TaskVO;
	
	public class EditCreateTaskEvent extends Event {
		
		public static const SHOW_TASK_PANEL:String = "EditCreateTaskEvent_showTaskPanel";
		
		public var editType:String;
		public var task:TaskVO;
		public var globalPoint:Point;
		public var rotation:Number;
		
		public function EditCreateTaskEvent(type:String, _editType:String = "", _task:TaskVO = null, _point:Point = null, _rotation:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			editType = _editType;
			task = _task;
			globalPoint = _point;
			rotation = _rotation;
		}
		
		public override function clone():Event {
			return new EditCreateTaskEvent(type, editType, task, globalPoint, rotation); 
		}
		
		
	}
}
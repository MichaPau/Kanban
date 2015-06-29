package framework.models.vo
{
	[Bindable]
	public class TaskVO {
		
		public var id:uint;
		public var title:String;
		public var containerId:uint;
		public var categoryId:uint;
		public var creationTime:String;
		public var text:String;
		public var boardId:uint;
		public var selectionTime:String;
		public var finishedTime:String;
		public var color:uint;
		
		public function TaskVO(_id:uint = 0, _title:String = "", _containerId:uint = 0, _creationTime:String = "", _text:String = "", _boardId:uint = 0, _selectionTime:String = "", _finishedTime:String = "", _color:uint = 0) {
		
			id = _id;
			title = _title;
			containerId = _containerId;
			creationTime = _creationTime;
			text = _text;
			boardId = _boardId;
			selectionTime = _selectionTime;
			finishedTime = _finishedTime;
			color = _color;
			
		}
	}
}
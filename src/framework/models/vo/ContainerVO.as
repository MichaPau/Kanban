package framework.models.vo
{
	[Bindable]
	public class ContainerVO {
		
		public var id:uint;
		public var title:String;
		public var boardId:uint;
		public var maxItems:uint;
		public var parentId:uint;
		public var position:uint;
		public var type:String;
		
		public function ContainerVO(_id:uint = 0, _title:String = "", _boardId:uint = 0, _maxItems:uint = 0, _parentId:uint = 0, _position:uint = 0, _type:String = "") {
			id = _id;
			title = _title;
			boardId = _boardId;
			maxItems = _maxItems;
			parentId = _parentId;
			position = _position;
			type = _type;
		}
	}
}
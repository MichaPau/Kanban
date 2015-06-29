package framework.models.vo
{
	public class SharedObjectVO
	{
		public static const LAST_SELECTED_BOARD_ID:String = "lastSelectedBoardId";
		public static const FINISHED_TASK_VIEW_MODE:String = "finishedTaskViewMode";
		
		public var id:String;
		public var value:*;
		public var flushFlag:Boolean;
		
		public function SharedObjectVO(_id:String = "", _value:* = null, _flag:Boolean = false) {
			id = _id;
			value = _value;
			flushFlag = _flag;
		}
	}
}
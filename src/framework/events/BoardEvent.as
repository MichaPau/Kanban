package framework.events
{
	import flash.events.Event;
	
	public class BoardEvent extends Event {
		
		public static const GET_BOARD_DATA:String = "BoardEvent_getBoardData";
		public static const BOARD_LOADED:String = "BoardEvent_boardLoaded";
		public static const BOARD_DISSABLED:String = "BoardEvent_boardDissabled";
		public static const DELETE:String = "BoardEvent_delete";
		
		private var _boardId:uint;
		
		public function BoardEvent(type:String, _id:uint = 0, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_boardId = _id;
		}
		
		public function get boardId():uint {
			return _boardId;
		}

		public function set boardId(value:uint):void {
			_boardId = value;
		}

		public override function clone():Event {
			return new BoardEvent(type, _boardId);
		}
	}
}
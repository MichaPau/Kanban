package framework.events
{
	import flash.events.Event;
	
	public class ButtonPositionChangedEvent extends Event
	{
		public var newIndex:int = -1;
		public var itemData:Object;
		
		public static const POSITION_CHANGED:String = "positionChanged";
		
		public function ButtonPositionChangedEvent(type:String, _newPos:int = -1, _data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			newIndex = _newPos;
			itemData = _data;
		}
		
		public override function clone():Event {
			return new ButtonPositionChangedEvent(type, newIndex, itemData);
		}
	}
}
package framework.events
{
	import flash.events.Event;
	
	public class SharedObjectEvent extends Event {
		
		public static const SAVE:String = "SharedObjectEvent_save";
		public var key:String;
		public var value:*;
		public var flushFlag:Boolean;
		
		public function SharedObjectEvent(type:String, _key:String, _value:*, _flushFlag:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			key = _key;
			value = _value;
		}
		
		public override function clone():Event {
			return new SharedObjectEvent(type, key, value);
		}
	}
}
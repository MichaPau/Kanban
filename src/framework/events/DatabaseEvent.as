package framework.events
{
	import flash.events.Event;
	
	public class DatabaseEvent extends Event
	{
		public static const DATABASE_READY:String = "DatabaseEvent_databaseReady";
		public static const DATABASE_RELOAD:String = "DatabaseEvent_databaseReload";
		
		
		public function DatabaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new DatabaseEvent(type);
		}
	}
}
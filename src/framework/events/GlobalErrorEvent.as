package framework.events
{
	import flash.events.Event;
	
	public class GlobalErrorEvent extends Event
	{
		public static const GLOBAL_ERROR:String = "GlobalError_globalError";
		
		public var details:String;
		public var extraInfo:String;
		
		public function GlobalErrorEvent(type:String, _details:String = "", _extraInfo:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			details = _details;
			extraInfo = _extraInfo;
		}
		
		public override function clone():Event {
			return new GlobalErrorEvent(type, details, extraInfo);
		}
	}
}
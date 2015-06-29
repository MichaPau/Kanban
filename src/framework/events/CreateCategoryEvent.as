package framework.events
{
	import flash.events.Event;
	
	public class CreateCategoryEvent extends Event {
		
		public static const CREATE_CATEGORY:String = "CreateCategoryEvent_createCategory";
		
		public var color:uint;
		public var title:String;
		
		public function CreateCategoryEvent(type:String, _color:uint, _title:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			color = _color;
			title = _title;
		}
		
		public override function clone():Event {
			return new CreateCategoryEvent(type, color, title);
		}
	}
}
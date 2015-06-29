package framework.events
{
	import flash.events.Event;
	
	public class DeleteCategoryEvent extends Event
	{
		
		public static const DELETE:String = "DeleteCategoryEvent_delete";
		
		public var categoryId:uint;
		
		public function DeleteCategoryEvent(type:String, _id:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			categoryId = _id;
		}
		
		public override function clone():Event {
			return new DeleteCategoryEvent(type, categoryId);
		}
	}
}
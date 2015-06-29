package framework.views
{
	import mx.controls.FlexNativeMenu;
	import mx.events.FlexNativeMenuEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class NativeMenuMediator extends Mediator {
		
		[Inject] public var menu:FlexNativeMenu;
		
		public override function initialize():void {
			this.addViewListener(FlexNativeMenuEvent.ITEM_CLICK, onMenuClick);
		}
		
		protected function onMenuClick(ev:FlexNativeMenuEvent):void {
			trace("NativeMenuMediator::onMenuClick");
		}
	}
}
package framework.views
{
	import framework.views.ui.TestView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class TestViewMediator extends Mediator {
		
		[Inject] public var view:TestView;
		
		public override function initialize():void {
			
			view.statusLabel.text = "initialized";
		}
	}
}
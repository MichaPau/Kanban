package components
{
	import flash.display.Sprite;
	
	public class HLine extends Sprite
	{
		public function HLine()
		{
			super();
		}
		
		public function draw():void {
			this.graphics.lineStyle(5);
			this.graphics.lineTo(0,this.height);
		}
	}
}
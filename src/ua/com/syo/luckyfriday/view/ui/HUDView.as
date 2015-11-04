package ua.com.syo.luckyfriday.view.ui
{
	import feathers.controls.Label;

	import starling.display.Sprite;

	public class HUDView extends Sprite
	{

		private var timerLabel:Label = new Label();

		public function HUDView():void
		{
			timerLabel = new Label();
			timerLabel.text = "";
			addChild(timerLabel);
			timerLabel. x = 20;
			timerLabel.y = 30;
		}

		public function updateTimeLabel(time:int):void
		{
			timerLabel.text = "time: " + Math.round(time / 1000);
		}

		private static var _instance:HUDView;

		public static function get instance():HUDView
		{
			if (_instance == null) _instance = new HUDView();
			return _instance;
		}
	}
}


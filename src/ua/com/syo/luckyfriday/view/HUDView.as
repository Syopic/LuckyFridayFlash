package ua.com.syo.luckyfriday.view
{
	import feathers.controls.Label;

	import starling.display.Sprite;

	public class HUDView extends Sprite
	{

		public function init():void
		{
			var label:Label = new Label();
			label.text = "Hi There";
			addChild(label).x = 200;
		}

		private static var _instance:HUDView;

		public static function get instance():HUDView
		{
			if (_instance == null) _instance = new HUDView();
			return _instance;
		}
	}
}


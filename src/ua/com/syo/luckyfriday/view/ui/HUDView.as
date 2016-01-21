package ua.com.syo.luckyfriday.view.ui {
	import flash.text.Font;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import ua.com.syo.luckyfriday.data.EmbededAssets;

	public class HUDView extends Sprite {
		private var timerLabel:TextField;

		public static var headerFont:Font;

		// icons
		private var timeIcon:Image;
		private var hullIcon:Image;
		private var energyIcon:Image;
		private var containerIcon:Image;

		public function HUDView():void {

			// Font
			headerFont = new EmbededAssets.UbuntuBoldClass();

			timerLabel = new TextField(210, 50, "12'34\"", headerFont.fontName, 36, 0xFFFFFF);
			addChild(timerLabel);

			// and display it with an Image:
			timeIcon = new Image(EmbededAssets.getTexture("HUDTimeIconC"));
			hullIcon = new Image(EmbededAssets.getTexture("HUDHullIconC"));
			energyIcon = new Image(EmbededAssets.getTexture("HUDEnergyIconC"));
			containerIcon = new Image(EmbededAssets.getTexture("HUDContainerIconC"));

			addChild(timeIcon);
			timeIcon.x = 14;
			timeIcon.y = 12;
			addChild(hullIcon);
			hullIcon.x = 14;
			hullIcon.y = 57;
			addChild(energyIcon);
			energyIcon.x = 18;
			energyIcon.y = 100;
			addChild(containerIcon);
			containerIcon.x = 14;
			containerIcon.y = 143;
		}

		public function updateTimeLabel(time:int):void {
			timerLabel.text = "1000" + Math.round(time / 1000).toString();

		}

		private static var _instance:HUDView;

		public static function get instance():HUDView {
			if (_instance == null) {
				_instance = new HUDView();
			}
			return _instance;
		}
	}
}


package ua.com.syo.luckyfriday.view.meta {

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.view.UIManager;
	

	public class MissionsMeteor extends Sprite {
		private var met:Image;

		public function MissionsMeteor() {
			met = new Image(Texture.fromEmbeddedAsset(Assets.MissionsMetC));
			met.width = Globals.stageWidth - 200;
			met.height = (Globals.stageWidth - 200) / 1.875;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = Globals.stageHeight / 2 - met.height / 2;
			//trace("stageWidth: " + Globals.stageWidth + " Globals.stageWidth: " + stageHeight);
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(met);
		}

		private function arrange():void {
			// TODO Auto Generated method stub
			met.width = Globals.stageWidth - 200;
			met.height = (Globals.stageWidth - 200) / 1.875;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = Globals.stageHeight / 2 - met.height / 2;
		}
	}
}

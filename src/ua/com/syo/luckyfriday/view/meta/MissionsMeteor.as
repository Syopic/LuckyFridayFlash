package ua.com.syo.luckyfriday.view.meta {

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import ua.com.syo.luckyfriday.data.Globals;

	import ua.com.syo.luckyfriday.data.EmbededAssets;

	public class MissionsMeteor extends Sprite {
		private var met:Image;

		public function MissionsMeteor() {
			met = new Image(Texture.fromEmbeddedAsset(EmbededAssets.MissionsMetC));
			met.width = Globals.stageWidth - 200;
			met.height = (Globals.stageWidth - 200) / 1.875;
			met.x = Globals.stageHeight / 2 - met.width / 2;
			met.y = Globals.stageHeight / 2 - met.height / 2;

			addChild(met);
		}
	}
}



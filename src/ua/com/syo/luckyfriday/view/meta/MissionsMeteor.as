package ua.com.syo.luckyfriday.view.meta {

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.storage.mission.MissionStorage;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.model.storage.mission.Location;

	public class MissionsMeteor extends Sprite {
		private var met:Image;
		public var resizeY:Number;
		public var psitionX:Number;
		private var l:Location;


		public function MissionsMeteor(locationId:String) {
			var locationTexture:Texture = MissionStorage.getLocationTexture(locationId);
			l = MissionStorage.getLocationById(locationId);
			met = new Image(locationTexture);

			resizeY = (Globals.stageHeight - 200) / l.locationHeight;
			met.scaleX = resizeY;
			met.scaleY = resizeY;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = 100;
			psitionX = met.x;
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(met);
		}

		private function arrange():void {
			resizeY = (Globals.stageHeight - 200) / l.locationHeight;
			met.scaleX = resizeY;
			met.scaleY = resizeY;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = 100;
			psitionX = met.x;
			trace("resize - " + resizeY + "%");
			trace("");
		}

	}
}



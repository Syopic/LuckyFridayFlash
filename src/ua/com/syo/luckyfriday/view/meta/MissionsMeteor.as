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
		public var resize:Number;
		private var locatId:String;

		public function MissionsMeteor(locationId:String) {
			var locationTexture:Texture = MissionStorage.getLocationTexture(locationId);
			locatId = locationId;
			met = new Image(locationTexture);
			met.width = Globals.stageWidth - 200;
			met.height = (Globals.stageWidth - 200) / 1.875;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = Globals.stageHeight / 2 - met.height / 2;
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(met);
		}

		private function arrange():void {
			var l:Location = MissionStorage.getLocationById(locatId);
			met.width = Globals.stageWidth - 200;
			met.height = (Globals.stageWidth - 200) / 1.875;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = Globals.stageHeight / 2 - met.height / 2;
			resize = ( met.width /l.locationWidth ) * 100;
			trace ("resize - "+resize+"%");
			trace("");
		}

	}
}



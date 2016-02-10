package ua.com.syo.luckyfriday.view.meta {

	import flash.filesystem.File;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.controller.events.AssetsLoadingEvent;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.Model;
	import ua.com.syo.luckyfriday.model.mission.CurrentLevelStorage;
	import ua.com.syo.luckyfriday.model.mission.Location;
	import ua.com.syo.luckyfriday.model.mission.MissionStorage;
	import ua.com.syo.luckyfriday.view.UIManager;

	/**
	 * Class MissionsMeteor create and resize view meteorite for MissionsState view
	 * @author Alex
	 */
	public class MissionsMeteor extends Sprite {
		private var met:Image;
		public var resizeY:Number;
		public var psitionX:Number;
		private var location:Location;


		/**
		* Constructor
	  	* @param locationId
		*/
		public function MissionsMeteor(locationId:String) {

			location = MissionStorage.getLocationById(locationId);

			Model.instance.assetManager.enqueue(File.applicationDirectory.resolvePath("gamedata/locations/location" + locationId + "/locationFg.png"));
			Model.instance.assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					init();
				}
			});

		}

		private function init():void {
			var locationTexture:Texture = Model.instance.assetManager.getTexture("locationFg");
			met = new Image(locationTexture);

			resizeY = (Globals.stageHeight - 200) / 1024;
			met.scaleX = resizeY;
			met.scaleY = resizeY;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = 100;
			psitionX = met.x;
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(met);
		}

		/**
		 * Function arrange change scale when changes stage width
		 */
		private function arrange():void {
			resizeY = (Globals.stageHeight - 200) / 1024;
			met.scaleX = resizeY;
			met.scaleY = resizeY;
			met.x = Globals.stageWidth / 2 - met.width / 2;
			met.y = 100;
			psitionX = met.x;
		}

	}
}



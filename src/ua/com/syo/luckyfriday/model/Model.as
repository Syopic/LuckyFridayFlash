package ua.com.syo.luckyfriday.model {
	import flash.events.EventDispatcher;
	import flash.filesystem.File;

	import starling.utils.AssetManager;

	import ua.com.syo.luckyfriday.controller.events.AssetsLoadingEvent;
	import ua.com.syo.luckyfriday.model.mission.CurrentLevelStorage;
	import ua.com.syo.luckyfriday.model.mission.Mission;
	import ua.com.syo.luckyfriday.model.mission.MissionStorage;
	import ua.com.syo.luckyfriday.model.profile.ProfileStorage;

	public class Model extends EventDispatcher {
		private var _assetManager:AssetManager;

		public function init():void {
			_assetManager = new AssetManager();
			loadProfileAssets();
			loadLocationsAssets();
		}

		public function loadLocationsAssets():void {
			_assetManager.enqueue(File.applicationDirectory.resolvePath("gamedata/locations/locations.json"));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					MissionStorage.setLocations(assetManager.getObject("locations") as Array);
					loadMissionsAssets(assetManager.getObject("locations") as Array);
				}
			});
		}

		// load all missions
		public function loadMissionsAssets(locations:Array):void {
			for (var i:int = 0; i < locations.length; i++) 
				_assetManager.enqueueWithName(File.applicationDirectory.resolvePath("gamedata/locations/location" + locations[i].id + "/missions.json"), "missions" + locations[i].id);
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					for (var i:int = 0; i < locations.length; i++) 
					{
						MissionStorage.setMissions(assetManager.getObject("missions" + locations[i].id) as Array, locations[i].id);
					}
				}
			});
		}

		public function loadLevelAssets(currentMissionId:String):void {
			var mission:Mission = MissionStorage.getMissionById(currentMissionId);
			_assetManager.enqueue(File.applicationDirectory.resolvePath("gamedata/locations/location" + mission.locationId + "/mission" + mission.id));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					CurrentLevelStorage.setLevelData(_assetManager.getTexture("fg"), _assetManager.getTexture("bg"), _assetManager.getObject("level"));
					dispatchEvent(new AssetsLoadingEvent(AssetsLoadingEvent.LEVEL_LOADED));
				}
			});
		}

		public function loadProfileAssets():void {
			_assetManager.enqueue(File.applicationDirectory.resolvePath("gamedata/profile/"));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					ProfileStorage.profTexture = _assetManager.getTexture("avatar");
					ProfileStorage.setProfile(_assetManager.getObject("profile"));
					ProfileStorage.setTop(_assetManager.getObject("top") as Array);
					ProfileStorage.setAchieves(_assetManager.getObject("achieves") as Array);
					dispatchEvent(new AssetsLoadingEvent(AssetsLoadingEvent.PROFILE_LOADED));
				}
			});
		}

		public function get assetManager():AssetManager {
			return _assetManager;
		}

		/**
		 * Singleton
		 */
		private static var _instance:Model;

		public static function get instance():Model {
			if (_instance == null) {
				_instance = new Model();
			}
			return _instance;
		}
	}
}



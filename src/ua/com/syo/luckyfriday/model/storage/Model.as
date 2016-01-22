package ua.com.syo.luckyfriday.model.storage
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;

	import starling.utils.AssetManager;

	import ua.com.syo.luckyfriday.controller.events.AssetsLoadingEvent;
	import ua.com.syo.luckyfriday.model.storage.level.CurrentLevelData;
	import ua.com.syo.luckyfriday.model.storage.mission.MissionStorage;
	import ua.com.syo.luckyfriday.model.storage.profile.ProfileStorage;

	public class Model extends EventDispatcher
	{
		private var _assetManager:AssetManager;
		public function init():void
		{
			_assetManager = new AssetManager();
		}

		public function loadLevelsAssets(currentLevelId:String):void
		{
			_assetManager.enqueue(File.applicationDirectory.resolvePath("levels/level" + currentLevelId));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					CurrentLevelData.setLevelData(_assetManager.getTexture("fg"), _assetManager.getTexture("bg"), _assetManager.getObject("levelData"));
					dispatchEvent(new AssetsLoadingEvent(AssetsLoadingEvent.LEVEL_LOADED));
				}
			});
		}

		public function loadProfileAssets():void
		{
			_assetManager.enqueue(File.applicationDirectory.resolvePath("profile"));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					ProfileStorage.profTexture = _assetManager.getTexture("che");
					ProfileStorage.ParseProfileFromJSON(_assetManager.getObject("profile"));
					dispatchEvent(new AssetsLoadingEvent(AssetsLoadingEvent.PROFILE_LOADED));
				}
			});
		}

		public function loadMissionAssets():void
		{
			_assetManager.enqueue(File.applicationDirectory.resolvePath("missions"));
			_assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					MissionStorage.ParseLocationMisiionFromJSON(assetManager.getObject("mission"));
					dispatchEvent(new AssetsLoadingEvent(AssetsLoadingEvent.MISSION_LOADED));
				}
			});
		}

		public function get assetManager():AssetManager
		{
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


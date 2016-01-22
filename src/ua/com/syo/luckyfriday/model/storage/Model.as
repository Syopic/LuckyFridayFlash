package ua.com.syo.luckyfriday.model.storage
{
	import flash.filesystem.File;

	import starling.utils.AssetManager;

	public class Model
	{

		private var assetManager:AssetManager;
		public function init():void
		{
			assetManager = new AssetManager();

			var appDir:File = File.applicationDirectory;

			assetManager.enqueue(appDir.resolvePath("missions"));
			assetManager.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					loadComplete();
				}
			});
		}

		protected function loadComplete():void {
			var obj:Object = assetManager.getObject("mission");
			trace("!!!!!!!!!!!!!!!assets loadComplete");
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


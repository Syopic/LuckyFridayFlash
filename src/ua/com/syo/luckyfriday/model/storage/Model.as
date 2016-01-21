package ua.com.syo.luckyfriday.model.storage
{
	import flash.events.Event;

	import ua.com.syo.core.assets.Asset;
	import ua.com.syo.core.assets.AssetsLoader;
	import ua.com.syo.core.assets.events.AssetEvent;

	public class Model
	{
		public function init():void
		{
			var lm:AssetsLoader = new AssetsLoader("test");
			lm.addEventListener(AssetEvent.ALL_ASSETS_LOADED, assetsLoadedHandler);
			lm.pushAsset(new Asset("logo", "../assets/img/Logo.png", Asset.SPRITE_TYPE));
			lm.startLoading();
		}

		protected function assetsLoadedHandler(event:AssetEvent):void
		{
			trace(event.loaderLabel + " all loaded!");
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


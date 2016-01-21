/**
 * AssetsLoader.as			load all external assets
 * @author					Krivosheya Sergey
 * @link    				http://www.syo.com.ua/
 * @link    				mailto: syopic@gmail.com
 */
package ua.com.syo.core.assets {
	import flash.events.EventDispatcher;

	import ua.com.syo.core.assets.events.AssetEvent;

	public class AssetsLoader extends EventDispatcher {

		private var assets:Vector.<Asset> = new Vector.<Asset>;
		private var assetsCounter:Number;
		public var packageLabel:String;

		/**
		 * constructor
		 */
		public function AssetsLoader(pLabel:String = "defaultName") {
			packageLabel = pLabel;
		}

		/**
		 * add new asset in array
		 * @param asset
		 */
		public function pushAsset(asset:Asset):void {
			assets.push(asset);
		}

		/**
		 * start loading
		 */
		public function startLoading():void {
			assetsCounter = assets.length;
			if (assetsCounter == 0) {
				var aEvent:AssetEvent = new AssetEvent(AssetEvent.ALL_ASSETS_LOADED, true);
				aEvent.loaderLabel = packageLabel;
				dispatchEvent(aEvent);
			}
			for (var i:Number = 0; i < assetsCounter; i++) {
				//Logger.INFO("startLoading asset " + assets[i].id);
				assets[i].addEventListener(AssetEvent.ASSET_LOADED, oneAssetLoadedHandler);
				assets[i].load();
			}
		}

		private function oneAssetLoadedHandler(event:AssetEvent):void {
			event.asset.removeEventListener(AssetEvent.ASSET_LOADED, oneAssetLoadedHandler);
			AssetsStorage.addAsset(event.asset);
			assetsCounter--;

			// if package loaded
			if (assetsCounter == 0) {
				if (packageLabel != "defaultName") {
					trace(" ---- Package assets: '" + packageLabel + "' loaded");
				}
				var aEvent:AssetEvent = new AssetEvent(AssetEvent.ALL_ASSETS_LOADED, true);
				aEvent.loaderLabel = packageLabel;
				dispatchEvent(aEvent);
			}
		}
	}
}



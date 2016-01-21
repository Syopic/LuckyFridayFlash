/**
 * Asset.as					visual asset class
 * @author					Krivosheya Sergey
 * @link    				http://www.syo.com.ua/
 * @link    				mailto: syopic@gmail.com
 */
package ua.com.syo.core.assets {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import ua.com.syo.core.assets.events.AssetEvent;

	public class Asset extends EventDispatcher {

		public static const SPRITE_TYPE:String = "sprite";
		public static const XML_TYPE:String = "xml";
		public static const JSON_TYPE:String = "json";

		public var id:String;
		public var url:String;
		public var className:Class;
		public var container:Loader;
		public var xmlContainer:URLLoader;
		public var type:String;
		public var isLoaded:Boolean = false;

		/**
		 * constructor
		 * @param url 	path to filename
		 * @param type	type on stage
		 * @param id	id in map data
		 */
		public function Asset(id:String, url:String, type:String = "sprite") {
			this.url = url;
			this.id = id;
			this.type = type;
		}

		/**
		 * load graphics/xml into each Asset copy
		 */
		public function load(useAppDomain:Boolean = true):void {
			if (type == "xml") {
				xmlContainer = new URLLoader();
				xmlContainer.dataFormat = URLLoaderDataFormat.TEXT;
				xmlContainer.addEventListener(Event.COMPLETE, assetLoadedHandler);
				xmlContainer.addEventListener(IOErrorEvent.IO_ERROR, assetLoadErrorHandler);
				xmlContainer.load(new URLRequest(url));
			} else {
				var loaderContext:LoaderContext;
				loaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);
				//loaderContext.
				//ApplicationDomain.currentDomain.getDefinition();

				container = new Loader();
				var urlReq:URLRequest = new URLRequest(url);
				container.contentLoaderInfo.addEventListener(Event.COMPLETE, assetLoadedHandler);
				container.contentLoaderInfo.addEventListener(Event.INIT, assetLoadingInitHandler);
				container.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, assetLoadErrorHandler);
				container.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, assetLoadErrorHandler);
				try {
					loaderContext.allowCodeImport = true;
				} catch (err:Error) {
					trace("allowCodeImport error: " + err.toString());
				}
				container.load(urlReq, loaderContext);
			}
		}

		private function assetLoadingInitHandler(e:Event):void {
			var ae:AssetEvent = new AssetEvent(AssetEvent.ASSET_INIT);
			ae.asset = this;
			dispatchEvent(ae);
		}

		private function assetLoadedHandler(e:Event):void {
			try {
				trace("Asset type:"+type+" id:"+id+" url:" + url + " loaded!");
				isLoaded = true;
				if (type == "xml") {
					xmlContainer.removeEventListener(Event.COMPLETE, assetLoadedHandler);
					xmlContainer.removeEventListener(IOErrorEvent.IO_ERROR, assetLoadErrorHandler);
				} else {
					container.contentLoaderInfo.removeEventListener(Event.COMPLETE, assetLoadedHandler);
					container.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, assetLoadErrorHandler);
					if (container.content && url.indexOf(".swf") >= 0) {
						(container.content as MovieClip).gotoAndStop(1);
						trace("(container.content as MovieClip).gotoAndStop(1);");
					}
				}

				var ae:AssetEvent = new AssetEvent(AssetEvent.ASSET_LOADED);
				ae.asset = this;
				dispatchEvent(ae);
			} catch (e:Error) {
				trace(e.toString());
			}
		}

		private function assetLoadErrorHandler(e:IOErrorEvent):void {
			trace("Asset with url: " + url + " not loaded!");

			var ae:AssetEvent = new AssetEvent(AssetEvent.ASSET_LOADED);
			ae.asset = this;
			dispatchEvent(ae);
		}

		/**
		 * inload/delete from memory assets
		 */
		public function unload():void {
			if (type == "xml") {
				xmlContainer.data = null;
			} else {
				container.addEventListener(Event.UNLOAD, unLoadHandler);
				container.unload();
			}
		}

		private function unLoadHandler(event:Event):void {
			//Logger.DEBUG("Asset " + url + " unloaded!");
			container = null;
			isLoaded = false;
		}
	}
}



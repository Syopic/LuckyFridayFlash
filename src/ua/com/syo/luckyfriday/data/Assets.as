package ua.com.syo.luckyfriday.data {

	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	import starling.textures.Texture;


	public class Assets
	{
		[Embed(source="/../assets/img/back2.png")]
		public static const BackgroundC:Class;

		[Embed(source="/../assets/img/cave2.png")]
		public static const CaveC:Class;

		[Embed(source="/../assets/img/vignette.png")]
		public static const VignetteC:Class;

		[Embed(source="/../assets/img/ship.png")]
		public static const ShipC:Class;

		[Embed(source="/../assets/img/platform.png")]
		public static const PlatformC:Class;

		[Embed(source = '/../assets/json/cave.json', mimeType = 'application/octet-stream')]
		private static const LevelJSON:Class;

		private static var gameTextures:Dictionary = new Dictionary();

		private static var levelJSON:Object;

		public static function getTexture(name:String):Texture {
			if (gameTextures[name] == undefined) {
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}

		public static function get levelData():Object {
			if (levelJSON == null)
				levelJSON = JSON.parse(new LevelJSON());;
			return levelJSON;
		}
	}
}


package {

	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	public class Assets
	{
		[Embed(source="/../assets/img/back.png")]
		public static const BackgroundC:Class;

		[Embed(source="/../assets/img/cave.png")]
		public static const CaveC:Class;

		[Embed(source="/../assets/img/vignette.png")]
		public static const VignetteC:Class;

		[Embed(source="/../assets/img/ship.png")]
		public static const ShipC:Class;

		[Embed(source="/../assets/img/platform.png")]
		public static const PlatformC:Class;

		private static var gameTextures:Dictionary = new Dictionary();

		public static function getTexture(name:String):Texture {
			if (gameTextures[name] == undefined) {
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}


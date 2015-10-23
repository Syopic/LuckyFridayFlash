package ua.com.syo.luckyfriday.data {
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	public class Assets
	{
		/**
		 * Level assets
		 */
		[Embed(source="/../assets/levels/level1/bg.png")]
		public static const BackgroundC:Class;

		[Embed(source="/../assets/levels/level1/fg.png")]
		public static const CaveC:Class;

		[Embed(source = '/../assets/levels/level1/levelData.json', mimeType = 'application/octet-stream')]
		private static const LevelJSON:Class;

		/**
		 * Ship hero assets
		 */
		[Embed(source="/../assets/img/ship.png")]
		public static const ShipC:Class;

		[Embed(source="/../assets/img/platform.png")]
		public static const PlatformC:Class;

		[Embed(source="/../assets/img/engine.png")]
		public static const EngineC:Class;

		/**
		 * Particles
		 */

		[Embed(source = "/../assets/particles/engineParticle.pex", mimeType = "application/octet-stream")]
		public static const EngineParticleConfig:Class;

		[Embed(source = "/../assets/particles/thrusterParticle.pex", mimeType = "application/octet-stream")]
		public static const ThrusterParticleConfig:Class;

		// particle textures
		[Embed(source = "/../assets/particles/texture.png")]
		public static const FireParticle:Class;

		[Embed(source = "/../assets/particles/small_particle.png")]
		public static const SmallParticle:Class;

		/**
		 * Sounds
		 */

		[Embed(source = "/../assets/sounds/space.mp3")]
		public static const LoopSoundC:Class;

		[Embed(source = "/../assets/sounds/engine.mp3")]
		public static const EngineSoundC:Class;

		[Embed(source = "/../assets/sounds/connect.mp3")]
		public static const ConnectSoundC:Class;

		[Embed(source = "/../assets/sounds/disconnect.mp3")]
		public static const DisconnectSoundC:Class;


		/**
		 * ------------------
		 * 		Helpers
		 * ------------------
		 */

		/**
		 * Cashing textures
		 */
		private static var gameTextures:Dictionary = new Dictionary();
		public static function getTexture(name:String):Texture {
			if (gameTextures[name] == undefined) {
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}

		/**
		 * Cashing JSON object
		 */
		private static var levelJSON:Object;
		public static function get levelObjects():Object {
			if (levelJSON == null)
				levelJSON = JSON.parse(new Assets.LevelJSON());;
			return levelJSON;
		}


	}
}


package ua.com.syo.luckyfriday.data {
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

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
		 * Logo assets
		 */
	
		[Embed(source="/../assets/img/Logo.png")]
		public static const LogoC:Class;
		
		
		[Embed(source="/../assets/img/LogoBtn.png")]
		public static const LogobtnC:Class;
		
		[Embed(source="/../assets/img/LogoBtnOver.png")]
		public static const ButtonOverC:Class;
		
		[Embed(source="/../assets/img/LogoBtnDown.png")]
		public static const ButtonDownC:Class;
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
		 * Icons
		 */

		[Embed(source="/../assets/img/icons/gear-outline.png")]
		public static const GearIconC:Class;

		[Embed(source="/../assets/img/icons/settings.png")]
		public static const SettingsIconC:Class;

		[Embed(source="/../assets/img/icons/power.png")]
		public static const PowerIconC:Class;

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

		[Embed(source = "/../assets/sounds/music/theme1.mp3")]
		public static const ThemeSoundC:Class;

		[Embed(source = "/../assets/sounds/env/space.mp3")]
		public static const EnvSoundC:Class;

		[Embed(source = "/../assets/sounds/sfx/engine.mp3")]
		public static const EngineSoundC:Class;

		[Embed(source = "/../assets/sounds/sfx/connect.mp3")]
		public static const ConnectSoundC:Class;

		[Embed(source = "/../assets/sounds/sfx/disconnect.mp3")]
		public static const DisconnectSoundC:Class;


		/**
		 * Atlases
		 */

		[Embed(source = "/../assets/anim/shipAnim.png")]
		private static var ShipAnimC:Class;

		[Embed(source = "/../assets/anim/shipAnim.xml", mimeType = "application/octet-stream")]
		private static var ShipAnimXMLC:Class;


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
		 * Cashing atlases
		 */
		private static var shipTextureAtlas:TextureAtlas;
		public static function getShipHeroAtlas():TextureAtlas
		{
			if (shipTextureAtlas == null)
			{
				var texture:Texture = getTexture("ShipAnimC");
				var xml:XML = XML(new ShipAnimXMLC());
				shipTextureAtlas = new TextureAtlas(texture, xml);
			}
			return shipTextureAtlas;
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


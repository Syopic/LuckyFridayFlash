package ua.com.syo.luckyfriday.data {
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EmbededAssets {
		/**
		 * Logo assets
		 */

		[Embed(source = "/../assets/img/Logo.png")]
		public static const LogoC:Class;


		[Embed(source = "/../assets/img/LogoBtn.png")]
		public static const LogobtnC:Class;

		[Embed(source = "/../assets/img/LogoBtnDisabled.png")]
		public static const ButtonDisabledC:Class;

		[Embed(source = "/../assets/img/LogoBtnDown.png")]
		public static const ButtonDownC:Class;

		/**
		 *  MissionsView
		*/

		[Embed(source = "/../assets/img/gui/missionsview/space_bg.jpg")]
		public static const SpacebgC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/mission.png")]
		public static const MissionsC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/mission_down.png")]
		public static const MissionsDownC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/mission_lokc.png")]
		public static const MissionsLockC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/rate.png")]
		public static const RateC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/rate_half.png")]
		public static const RateHalfC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/rate_empty.png")]
		public static const RateEmptyC:Class;

		[Embed(source = "/../assets/img/gui/missionsview/radiation.png")]
		public static const RadiationC:Class;
		
		[Embed(source = "/../assets/img/gui/missionsview/radiation_loc.png")]
		public static const RadiationLocC:Class;

		/**
		 * Default avatar
		 */
		[Embed(source = "/../assets/img/avatar.jpg")]
		public static const AvatarC:Class;
		/**
		 * Game Over assets
		 */
		[Embed(source = "/../assets/img/gui/gameover/go1.png")]
		public static const GameOver1C:Class;
		[Embed(source = "/../assets/img/gui/gameover/go2.png")]
		public static const GameOver2C:Class;
		[Embed(source = "/../assets/img/gui/gameover/go3.png")]
		public static const GameOver3C:Class;
		[Embed(source = "/../assets/img/gui/gameover/go4.png")]
		public static const GameOver4C:Class;

		/**
		 * Ship hero assets
		 */
		[Embed(source = "/../assets/img/ship.png")]
		public static const ShipC:Class;

		[Embed(source = "/../assets/img/platform.png")]
		public static const PlatformC:Class;

		[Embed(source = "/../assets/img/engine.png")]
		public static const EngineC:Class;

		/**
		 * Icons
		 */

		[Embed(source = "/../assets/img/icons/gear-outline.png")]
		public static const GearIconC:Class;

		[Embed(source = "/../assets/img/icons/settings.png")]
		public static const SettingsIconC:Class;

		[Embed(source = "/../assets/img/icons/power.png")]
		public static const PowerIconC:Class;

		/**
		 * HUD
		 */

		[Embed(source = "/../assets/img/icons/hud/time.png")]
		public static const HUDTimeIconC:Class;

		[Embed(source = "/../assets/img/icons/hud/hull.png")]
		public static const HUDHullIconC:Class;

		[Embed(source = "/../assets/img/icons/hud/energy.png")]
		public static const HUDEnergyIconC:Class;

		[Embed(source = "/../assets/img/icons/hud/container.png")]
		public static const HUDContainerIconC:Class;

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

		[Embed(source = "/../assets/sounds/music/theme2.mp3")]
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
		 * Embed font
		*/
		/*regilar font*/
		[Embed(source = "/../assets/fonts/segoepr.ttf", fontName = "segoepr", fontWeight = "normal", mimeType = "application/x-font", embedAsCFF = "false")]
		public static var segoeprC:Class;
		/*Bold font*/
		[Embed(source = "/../assets/fonts/segoeprb.ttf", fontName = "segoepr", fontWeight = "bold", mimeType = "application/x-font", embedAsCFF = "false")]
		public static var segoeprbC:Class;
		public static var font:Font = new segoeprC();

		[Embed(source = "/../assets/fonts/UbuntuMono-B.ttf", fontName = "UbuntuBold", mimeType = "application/x-font", fontWeight = "Bold", fontStyle = "Bold", advancedAntiAliasing = "true", embedAsCFF = "false")]
		public static const UbuntuBoldClass:Class;
		public static var fontUbuntu:Font = new UbuntuBoldClass();


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
				var bitmap:Bitmap = new EmbededAssets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}


		/**
		 * Cashing atlases
		 */
		private static var shipTextureAtlas:TextureAtlas;

		public static function getShipHeroAtlas():TextureAtlas {
			if (shipTextureAtlas == null) {
				var texture:Texture = getTexture("ShipAnimC");
				var xml:XML = XML(new ShipAnimXMLC());
				shipTextureAtlas = new TextureAtlas(texture, xml);
			}
			return shipTextureAtlas;
		}





	}
}


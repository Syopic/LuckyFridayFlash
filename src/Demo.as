package {
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.particles.ColorArgb;
	import starling.extensions.particles.PDParticleSystem;
	import starling.extensions.particles.ParticleSystem;
	import starling.textures.Texture;

	public class Demo extends Sprite {
		// particle designer configurations


		[Embed(source = "/../assets/particles/particle.pex", mimeType = "application/octet-stream")]
		private static const FireConfig:Class;

		// particle textures
		[Embed(source = "/../assets/particles/texture.png")]
		private static const FireParticle:Class;

		[Embed(source = "/../assets/particles/small_particle.png")]
		private static const SmallParticle:Class;

		// member variables

		public var mParticleSystem:PDParticleSystem;

		public var e1PS:PDParticleSystem;
		public var e2PS:PDParticleSystem;
		public var e3PS:PDParticleSystem;
		public var e4PS:PDParticleSystem;

		public function Demo() {
			var fireConfig:XML = XML(new FireConfig());
			var fireTexture:Texture = Texture.fromEmbeddedAsset(FireParticle);

			var smallTexture:Texture = Texture.fromEmbeddedAsset(SmallParticle);


			mParticleSystem = new PDParticleSystem(fireConfig, fireTexture);
			e1PS = new PDParticleSystem(fireConfig, smallTexture);
			e2PS = new PDParticleSystem(fireConfig, smallTexture);
			e3PS = new PDParticleSystem(fireConfig, smallTexture);
			e4PS = new PDParticleSystem(fireConfig, smallTexture);

			//e1PS.startColor = ColorArgb.fromRgb(0xff0000);
			//e1PS.maxRadius = e2PS.maxRadius = e3PS.maxRadius = e4PS.maxRadius = 1;

			// add event handlers for touch and keyboard

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function inittParticleSystem():void {

			//mParticleSystem.start();
			addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);

			addChild(e1PS);
			Starling.juggler.add(e1PS);

			addChild(e2PS);
			Starling.juggler.add(e2PS);

			addChild(e3PS);
			Starling.juggler.add(e3PS);

			addChild(e4PS);
			Starling.juggler.add(e4PS);
		}

		private function onAddedToStage(event:Event):void {
			inittParticleSystem();
		}

	}
}


package
{
	import flash.ui.Keyboard;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.particles.PDParticleSystem;
	import starling.extensions.particles.ParticleSystem;
	import starling.textures.Texture;

	public class Demo extends Sprite
	{
		// particle designer configurations


		[Embed(source="/../assets/particles/particle.pex", mimeType="application/octet-stream")]
		private static const FireConfig:Class;

		// particle textures
		[Embed(source="/../assets/particles/texture.png")]
		private static const FireParticle:Class;

		// member variables

		private var mParticleSystems:Vector.<PDParticleSystem>;
		public var mParticleSystem:PDParticleSystem;

		public function Demo()
		{
			ParticleSystem
				var fireConfig:XML = XML(new FireConfig());
			var fireTexture:Texture = Texture.fromEmbeddedAsset(FireParticle);


			mParticleSystems = new <PDParticleSystem>[
				new PDParticleSystem(fireConfig, fireTexture),
				];

			// add event handlers for touch and keyboard

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function startNextParticleSystem():void
		{
			if (mParticleSystem)
			{
				mParticleSystem.stop();
				mParticleSystem.removeFromParent();
				Starling.juggler.remove(mParticleSystem);
			}

			mParticleSystem = mParticleSystems.shift();
			mParticleSystems.push(mParticleSystem);

			//mParticleSystem.emitterX = 320;
			//mParticleSystem.emitterY = 240;
			mParticleSystem.start();

			addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
		}

		private function onAddedToStage(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);

			startNextParticleSystem();
		}

		private function onRemovedFromStage(event:Event):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onKey(event:Event, keyCode:uint):void
		{
			if (keyCode == Keyboard.SPACE)
				startNextParticleSystem();
		}

		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
			}
		}
	}
}


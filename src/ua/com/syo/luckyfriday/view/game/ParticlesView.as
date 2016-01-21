package ua.com.syo.luckyfriday.view.game {
	import flash.geom.Point;

	import nape.geom.Vec2;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.EmbededAssets;

	public class ParticlesView extends Sprite {

		public var mainEnginePS:PDParticleSystem;

		private var thrusterPS:Vector.<PDParticleSystem> = new Vector.<PDParticleSystem>(4); 

		public function ParticlesView() {
			var trailConfig:XML = XML(new EmbededAssets.EngineParticleConfig());
			var thrusterConfig:XML = XML(new EmbededAssets.ThrusterParticleConfig());
			var trailTexture:Texture = Texture.fromEmbeddedAsset(EmbededAssets.FireParticle);

			var thrusterTexture:Texture = Texture.fromEmbeddedAsset(EmbededAssets.SmallParticle);

			mainEnginePS = new PDParticleSystem(trailConfig, trailTexture);
			for (var i:int = 0; i < 4; i++) 
			{
				thrusterPS[i] = new PDParticleSystem(thrusterConfig, thrusterTexture);
			}

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function setThrusterPSParams(index:int, p:Point, speed:Number, emitAngle:Number):void {
			thrusterPS[index].emitterX = p.x;
			thrusterPS[index].emitterY = p.y;
			thrusterPS[index].speed = speed;
			thrusterPS[index].emitAngle = emitAngle;
		}

		public function setThrusterPSActive(index:int, isActive:Boolean = false):void {
			if (isActive) 
				thrusterPS[index].start();
			else
				thrusterPS[index].stop();
		}

		private function onAddedToStage(event:Event):void {
			initParticleSystem();
		}

		private function initParticleSystem():void {

			addChild(mainEnginePS);
			Starling.juggler.add(mainEnginePS);

			for (var i:int = 0; i < 4; i++) 
			{
				addChild(thrusterPS[i] );
				Starling.juggler.add(thrusterPS[i] );
			}
		}

		private static var _instance:ParticlesView;

		public static function get instance():ParticlesView
		{
			if (_instance == null) _instance = new ParticlesView();
			return _instance;
		}

	}
}


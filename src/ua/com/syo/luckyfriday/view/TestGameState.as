package ua.com.syo.luckyfriday.view {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import mx.core.mx_internal;

	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.physics.nape.Nape;
	import citrus.view.ACitrusCamera;
	import citrus.view.starlingview.StarlingCamera;

	import justpinegames.Logi.Console;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.BodyType;
	import nape.util.ShapeDebug;

	import starling.core.Starling;
	import starling.display.Image;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.LevelData;
	import ua.com.syo.luckyfriday.model.Globals;

	/**
	 *
	 * @author Syo
	 */
	public class TestGameState extends StarlingState {

		private var shipHero:ShipHero;
		private var terrainView:TerrainView;
		private var debug:ShapeDebug;
		private var napeWorld:Nape;

		private var isDebug:Boolean = false;
		private var camera:StarlingCamera;
		private var mcDebug:flash.display.MovieClip;

		private var caveSprite:CitrusSprite;

		private var particles:Demo;
		private var flame:CitrusSprite;

		public function TestGameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			// init nape
			napeWorld = new Nape("nape", {gravity: new Vec2(0, Globals.gravity)});
			add(napeWorld);
			//napeWorld.visible = true;
			initDebugLayer();

			// add background
			add(new CitrusSprite("backgroud", {parallax:0.01, view: new Image(Assets.getTexture("BackgroundC"))}));
			//addChild(new Demo());
			particles = new Demo();

			flame = new CitrusSprite("flame", {view:particles});
			add(flame);
			caveSprite = new CitrusSprite("cave", {view: new Image(Assets.getTexture("CaveC"))});
			add(caveSprite);

			LevelData.addShapes(this, LevelData.CAVE_SHAPES, BodyType.STATIC);
			LevelData.addShapes(this, LevelData.PLATFORM_SHAPES, BodyType.STATIC);
			LevelData.addShapes(this, LevelData.ROCK_SHAPES, BodyType.DYNAMIC);

			// add ship hero
			shipHero = new ShipHero("ship");
			add(shipHero);
			shipHero.body.position.setxy(500, 300);



			camera = view.camera as StarlingCamera;
			camera.setUp(shipHero, new Rectangle(0, 0, 3840, 1080), new Point(.5, .5));
			camera.allowZoom = true;
			camera.allowRotation = true;
			camera.parallaxMode = ACitrusCamera.BOUNDS_MODE_AABB;
			//camera.zoom(0.7);
			//camera.setRotation(Math.PI / 2);



			initKeyboardActions();

			napeWorld.space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY,
				function OnCollision(e:InteractionCallback):void {
				//log("Body type: " + e.int2.castBody.type.toString() + " Collision Normal: " + e.int2.castBody.arbiters.at(0).collisionArbiter.normal.toString());
				}

				));
		}


		/**
		 * Init debug layer
		 */
		private function initDebugLayer():void {
			debug = new ShapeDebug(3840, 1080);
			debug.drawBodies = true;
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;
			//debug.drawShapeDetail = true;

			mcDebug = new flash.display.MovieClip();
			mcDebug.addChild(debug.display);
			Starling.current.nativeOverlay.addChild(mcDebug);
		}

		private function moveEmiter():void
		{
			//flame.x = shipHero.body.position.x;
			//flame.y = shipHero.body.position.y;

			//update particle trail
			var offset:Vec2 = new Vec2(100, 0);
			offset.angle = shipHero.body.rotation;
			particles.mParticleSystem.emitterX = shipHero.body.position.x-offset.x*shipHero.direction;
			particles.mParticleSystem.emitterY = shipHero.body.position.y-offset.y*shipHero.direction;
			particles.mParticleSystem.speed = 100*shipHero.direction;
			particles.mParticleSystem.emitAngle = -(Math.PI -shipHero.body.rotation);
		}


		/**
		 * Get the keyboard, and add actions
		 */
		private function initKeyboardActions():void {
			var kb:Keyboard = _ce.input.keyboard;
			kb.addKeyAction("console", Keyboard.TAB);
		}


		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_ce.input.hasDone("console")) {
				var console:Console = Console.getMainConsoleInstance();
				console.isShown = !console.isShown;
			}

			if (_ce.input.isDoing("forward") && shipHero.direction == 1 || _ce.input.isDoing("backward") && shipHero.direction == -1) {
				particles.mParticleSystem.start();
			} else {
				particles.mParticleSystem.stop();
			}

			shipHero.update(timeDelta);
			moveEmiter();

			if (Globals.isDebugMode) {
				debug.clear();
				debug.draw(napeWorld.space);
				debug.flush();
				mcDebug.x = -camera.camPos.x + 512;
				mcDebug.y = -camera.camPos.y + 300;
			}
		}
	}
}


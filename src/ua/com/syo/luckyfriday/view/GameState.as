package ua.com.syo.luckyfriday.view {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.physics.nape.Nape;
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
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.LevelData;
	import ua.com.syo.luckyfriday.model.Globals;

	/**
	 *
	 * @author Syo
	 */
	public class GameState extends StarlingState {

		private var shipHero:ShipHero;
		private var debug:ShapeDebug;
		private var napeWorld:Nape;

		private var isDebug:Boolean = false;
		public var mainCamera:StarlingCamera;
		private var mcDebug:flash.display.MovieClip;

		private var caveSprite:CitrusSprite;

		public var particles:ParticlesView;
		private var flame:CitrusSprite;

		public function GameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			// init nape
			napeWorld = new Nape("nape", {gravity: new Vec2(0, Globals.gravity)});
			add(napeWorld);
			if (Globals.isDebugMode) 
				initDebugLayer();

			// add background
			add(new CitrusSprite("backgroud", {parallax:0.01, view: new Image(Texture.fromEmbeddedAsset(Assets.BackgroundC))}));
			//addChild(new Demo());
			caveSprite = new CitrusSprite("cave", {view: new Image(Texture.fromEmbeddedAsset(Assets.CaveC))});
			add(caveSprite);

			LevelData.getObjectsByType(this, LevelData.CAVE_SHAPES, BodyType.STATIC);
			//LevelData.getObjectsByType(this, LevelData.PLATFORM_SHAPES, BodyType.STATIC);
			//LevelData.getObjectsByType(this, LevelData.ROCK_SHAPES, BodyType.DYNAMIC);

			// add ship hero
			shipHero = new ShipHero("ship");
			particles = new ParticlesView();
			flame = new CitrusSprite("flame", {view:particles});
			add(flame);
			//shipHero.particles = particles;
			add(shipHero);
			shipHero.body.position.setxy(500, 300);



			mainCamera = view.camera as StarlingCamera;
			mainCamera.setUp(shipHero, new Rectangle(0, 0, 3840, 1080), new Point(.5, .5));
			//mainCamera.allowZoom = true;
			//mainCamera.allowRotation = true;
			//mainCamera.parallaxMode = ACitrusCamera.BOUNDS_MODE_AABB;
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

			shipHero.update(timeDelta);

			if (Globals.isDebugMode) {
				debug.clear();
				debug.draw(napeWorld.space);
				debug.flush();
				mcDebug.x = -mainCamera.camPos.x + 512;
				mcDebug.y = -mainCamera.camPos.y + 300;
			}
			//flame.x = -mainCamera.camPos.x;
			//flame.y = -mainCamera.camPos.y;
		}

		private static var _instance:GameState;

		public static function get instance():GameState
		{
			if (_instance == null) _instance = new GameState();
			return _instance;
		}
	}
}


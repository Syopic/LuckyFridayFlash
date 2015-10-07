package ua.com.syo.luckyfriday.view {
	import flash.display.MovieClip;

	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.nape.Nape;

	import justpinegames.Logi.Console;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;
	import nape.shape.Shape;
	import nape.util.ShapeDebug;

	import starling.core.Starling;
	import starling.display.Image;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.model.Globals;
	import ua.com.syo.luckyfriday.utils.BodyParser;

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

		[Embed(source = '/../assets/json/cave.json', mimeType = 'application/octet-stream')]
		private static const LevelJSON:Class;

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
			parseJsonBodies();

			// add background
			add(new CitrusSprite("backgroud", {view: new Image(Assets.getTexture("BackgroundC"))}));
			add(new CitrusSprite("cave", {view: new Image(Assets.getTexture("CaveC"))}));

			// platform
			//add(new Platform("platformBot", {x: 490, y: 400, width: 150, height: 10}));

			//add(new Platform("platformBot2", {x: 650, y: 595, width: 150, height: 10}));

			// terrain from image
			//terrainView = new TerrainView(napeWorld.space);

			// add ship hero
			shipHero = new ShipHero("ship");
			add(shipHero);
			shipHero.body.position.setxy(300, 380);

			parseJsonDrawings()
			// add ship hero



			initKeyboardActions();

			napeWorld.space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY,

				function OnCollision(e:InteractionCallback):void {
					log("Body type: " + e.int2.castBody.type.toString() + " Collision Normal: " + e.int2.castBody.arbiters.at(0).collisionArbiter.normal.toString());
				}

				));
		}

		/**
		 * Load geometry from JSON
		 */
		private function parseJsonBodies():void {
			var json:String = new LevelJSON();

			//var space:Space = loadSpaceFromRUBE(JSON.parse(json), 1, 1);
			var bodies:Vector.<Body> = BodyParser.parse(JSON.parse(json));

			for (var i:int = 0; i < bodies.length; i++) {
				var body:Body = bodies[i];
				napeWorld.space.bodies.push(body);

			}
		}

		/**
		 * Load geometry from JSON
		 */
		private function parseJsonDrawings():void {
			var json:String = new LevelJSON();

			//var space:Space = loadSpaceFromRUBE(JSON.parse(json), 1, 1);
			var drawings:Vector.<DrawingPhysicsObject> = BodyParser.parseDrawing(JSON.parse(json), this);

		/*for (var i:int = 0; i < drawings.length; i++) {
			//var dr:DrawingPhysicsObject = drawings[i];
			add(drawings[i]);
		}*/
		}

		/**
		 * Init debug layer
		 */
		private function initDebugLayer():void {
			debug = new ShapeDebug(1024, 600);
			debug.drawBodies = true;
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;
			//debug.drawShapeDetail = true;

			var mcDebug:flash.display.MovieClip = new flash.display.MovieClip();
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

			debug.clear();
			//debug.draw(napeWorld.space);
			debug.flush();

		}
	}
}


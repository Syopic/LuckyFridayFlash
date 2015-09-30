package ua.com.syo.luckyfriday.view {
	import flash.display.MovieClip;

	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;

	import justpinegames.Logi.Console;

	import nape.geom.Vec2;
	import nape.shape.Polygon;
	import nape.util.ShapeDebug;

	import starling.core.Starling;
	import starling.display.Image;

	import ua.com.syo.luckyfriday.data.Assets;
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

		[Embed(source = '/../assets/json/level_test.json', mimeType='application/octet-stream')]
		private static const LevelJSON:Class;

		/**
		 *
		 */
		public function TestGameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			// init nape
			napeWorld = new Nape("nape", {gravity: new Vec2(0, Globals.gravity)});
			add(napeWorld);

			/*var json:String = new LevelJSON();

			var space2:Space = loadSpaceFromRUBE(JSON.parse(json), 5, 1);

			log(space2.bodies.length);
			for (var i:int = 0; i < space2.bodies.length; i++)
			{
				napeWorld.space.bodies.push(space2.bodies.at(i));
			}*/


			debug = new ShapeDebug(1024,600);
			debug.drawBodies = true;
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;


			// add background
			add(new CitrusSprite("backgroud", {view: new Image(Assets.getTexture("BackgroundC"))}));
			add(new CitrusSprite("cave", {view: new Image(Assets.getTexture("CaveC"))}));

			// platform
			add(new Platform("platformBot", {x: 490, y: 400, width: 150, height: 10}));

			add(new Platform("platformBot2", {x: 650, y: 595, width: 150, height: 10}));

			terrainView = new TerrainView(napeWorld.space);

			// add ship hero
			shipHero = new ShipHero("ship");
			add(shipHero);
			shipHero.body.position.setxy(400, 300);

			debug.draw(napeWorld.space);
			var MovieClipDebug:flash.display.MovieClip = new flash.display.MovieClip();
			MovieClipDebug.addChild(debug.display);
			Starling.current.nativeOverlay.addChild(MovieClipDebug);

			initKeyboardActions();
		}


		/**
		 * Get the keyboard, and add actions
		 */
		private function initKeyboardActions():void
		{
			var kb:Keyboard = _ce.input.keyboard;
			kb.addKeyAction("console", Keyboard.TAB);
			kb.addKeyAction("debug", Keyboard.SPACE);
		}


		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_ce.input.hasDone("console")) {
				var console:Console = Console.getMainConsoleInstance();
				console.isShown = !console.isShown;
			}

			if (_ce.input.hasDone("debug")) {
				// switch debug mode
			}

			shipHero.update(timeDelta);

			debug.clear();
			debug.draw(napeWorld.space);
			debug.flush();

		}
	}
}


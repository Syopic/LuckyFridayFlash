package ua.com.syo.luckyfriday.view {
	import flash.utils.getTimer;

	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.vehicle.nape.Nugget;
	import citrus.physics.nape.Nape;

	import justpinegames.Logi.Console;

	import nape.geom.Vec2;

	import starling.display.Image;

	import ua.com.syo.luckyfriday.data.Assets;

	public class TestGameState extends StarlingState {

		private var shipHero:ShipHero;

		public function TestGameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			// init nape
			var nape:Nape = new Nape("nape", {gravity: new Vec2(0, 0.1)});
			nape.visible = true;
			add(nape);

			// add background
			add(new CitrusSprite("backgroud", {view: new Image(Assets.getTexture("BackgroundC"))}));
			add(new CitrusSprite("cave", {view: new Image(Assets.getTexture("CaveC"))}));

			// platform
			add(new Platform("platformBot", {x: 490, y: 400, width: 150, height: 10}));

			// add ship hero
			shipHero = new ShipHero("ship");
			add(shipHero);
			shipHero.body.position.setxy(400, 300);

			/*var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(50, (h - 50), (w - 100), 1)));
			floor.space = nape.space;*/

			/*var ship:Body = new Body(BodyType.DYNAMIC);
			ship.shapes.add(new Polygon(Polygon.rect(50, (h - 50), (w - 100), 1)));
			//ship.userData.ga
			ship.space = nape.space;*/



			/*for (var i:int = 0; i < 16; i++) {
				var box:Body = new Body(BodyType.DYNAMIC);
				box.shapes.add(new Polygon(Polygon.box(16, 32)));
				box.position.setxy((w / 2) + MathUtils.randomInt(0, 20), ((h - 50) - 32 * (i + 0.5)));
				box.space = nape.space;
				box.dragImpulse(floor);
			}*/





			// get the keyboard, and add actions.
			var kb:Keyboard = _ce.input.keyboard;

			kb.addKeyAction("right", Keyboard.RIGHT);
			kb.addKeyAction("left", Keyboard.LEFT);
			kb.addKeyAction("up", Keyboard.UP);
			kb.addKeyAction("down", Keyboard.DOWN);

			kb.addKeyAction("a", Keyboard.A);
			kb.addKeyAction("d", Keyboard.D);
			kb.addKeyAction("console", Keyboard.TAB);
		}


		private var dt:Number = 0;
		private var prevButton:String;

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			//user input
			if (_ce.input.isDoing("a")) {
				shipHero.rotate(-1);

			}

			if (_ce.input.isDoing("d")) {
				shipHero.rotate(1);
			}

			if (_ce.input.isDoing("right")) {

				shipHero.moveRight();
			}

			if (_ce.input.isDoing("left")) {
				shipHero.moveLeft();
			}

			if (_ce.input.hasDone("right")) {
				if (prevButton == "right" && (getTimer() - dt) < 300) {
					shipHero.animation = "rrotater";
				} else
				{
					dt = getTimer();
					prevButton = "right";
				}
			}

			if (_ce.input.hasDone("left")) {
				if (prevButton == "left" && (getTimer() - dt) < 300) {
					shipHero.animation = "rotate";
				} else {
					dt = getTimer();
					prevButton = "left";
				}
			}



			if (_ce.input.isDoing("up")) {
				shipHero.moveUp();
			}

			if (_ce.input.isDoing("down")) {
				shipHero.moveDown();
			}

			if (_ce.input.hasDone("console")) {
				var console:Console = Console.getMainConsoleInstance();
				console.isShown = !console.isShown;
			}

			shipHero.oldX = shipHero.body.position.x;

		}

	}
}


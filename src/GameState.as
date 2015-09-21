package {
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathUtils;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import starling.display.Image;

	public class GameState extends StarlingState {

		private var physicObject:NapePhysicsObject;

		public function GameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			//scaleX = scaleY = 2;

			var nape:Nape = new Nape("nape", {gravity:new Vec2(0, 2)});
			nape.visible = true;
			add(nape);

			add(new CitrusSprite("backgroud", {parallaxX:0.02, parallaxY:0, view:new Image(Assets.getTexture("BackgroundC"))}));
			add(new CitrusSprite("cave", {parallaxX:0.01, parallaxY:0, view:new Image(Assets.getTexture("CaveC"))}));

			add(new Platform("platformBot", { x:490, y:400, width:150, height:10 } ));

			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(50, (h - 50), (w - 100), 1)));
			floor.space = nape.space;

			var ship:Body = new Body(BodyType.DYNAMIC);
			ship.shapes.add(new Polygon(Polygon.rect(50, (h - 50), (w - 100), 1)));
			//ship.userData.ga
			ship.space = nape.space;


			var image:Image = new Image(Assets.getTexture("ShipC"));
			physicObject = new NapePhysicsObject("physicobject", { x:500, y:300, width:160, height:60, view:image} );
			add(physicObject);


			for (var i:int = 0; i < 16; i++) {
				var box:Body = new Body(BodyType.DYNAMIC);
				box.shapes.add(new Polygon(Polygon.box(16, 32)));
				box.position.setxy((w / 2) + MathUtils.randomInt(0, 20), ((h - 50) - 32 * (i + 0.5)));
				box.space = nape.space;
				box.dragImpulse(floor);
			}


			// get the keyboard, and add actions.
			var kb:Keyboard = _ce.input.keyboard;

			//R randomizes cloud positions
			kb.addKeyAction("right", Keyboard.RIGHT);
			kb.addKeyAction("left", Keyboard.LEFT);
			kb.addKeyAction("up", Keyboard.UP);
			kb.addKeyAction("down", Keyboard.DOWN);

			kb.addKeyAction("a", Keyboard.A);
			kb.addKeyAction("d", Keyboard.D);
			kb.addKeyAction("s", Keyboard.S);
		}

		private var da:Number = 0;

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);

			//user input

			if (_ce.input.isDoing("a"))
			{
				//physicObject.body.velocity.x += 1;
				//physicObject.body.rotation += 0.002;
				//var impulse:Vec2 = Vec2.weak(0, 1);
				//impulse.length = 10;
				physicObject.body.applyAngularImpulse(-50);
					//physicObject.body.applyImpulse(impulse, new Vec2(10, 0));
			}


			if (_ce.input.isDoing("d"))
			{
				//physicObject.body.velocity.x -= 1;
				//physicObject.body.rotation -= 0.002;
				physicObject.body.applyAngularImpulse(50);
			}

			if (_ce.input.isDoing("right"))
			{
				var impulse:Vec2 = new Vec2(1, 0);
				impulse.length = 1;
				impulse.angle = physicObject.body.rotation;
				physicObject.body.applyImpulse(impulse, physicObject.body.position);


			}

			if (_ce.input.isDoing("left"))
			{
				var impulse1:Vec2 = new Vec2(-1, 0);
				impulse1.length = 1;
				impulse1.angle = physicObject.body.rotation;
				physicObject.body.applyImpulse(impulse1.reflect(impulse1), physicObject.body.position);
			}

			if (_ce.input.isDoing("up"))
			{
				var impulse2:Vec2 = new Vec2(0, 1);
				impulse2.length = 1;
				impulse2.angle = physicObject.body.rotation;
				physicObject.body.applyImpulse(impulse2.reflect(impulse2).perp(), physicObject.body.position);
			}

			if (_ce.input.isDoing("down"))
			{
				var impulse3:Vec2 = new Vec2(0, 1);
				impulse3.length = 1;
				impulse3.angle = physicObject.body.rotation;
				physicObject.body.applyImpulse(impulse3.perp(), physicObject.body.position);
			}

			if (_ce.input.isDoing("s"))
			{
				//physicObject.
			}



		}

		private function radians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}


	}
}


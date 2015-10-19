package ua.com.syo.luckyfriday.view {
	import flash.utils.getTimer;

	import citrus.input.controllers.Keyboard;
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;
	import nape.phys.Material;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.model.Globals;


	public class ShipHero extends NapePhysicsObject {

		[Embed(source = "/../assets/anim/shipAnim.png")]
		private var ShipAnimC:Class;

		[Embed(source = "/../assets/anim/shipAnim.xml", mimeType = "application/octet-stream")]
		private var ShipAnimXMLC:Class;

		private var impulse:Vec2 = new Vec2(0, 0);

		private var oldX:Number = 0;
		private var dt:Number = 0;
		private var prevButton:String;
		private var engines:Sprite;
		private var engine1:Image;
		private var engine2:Image;
		private var engine3:Image;
		private var engine4:Image;

		public var direction:int = 1;

		public function ShipHero(name:String, params:Object = null) {
			var ta:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ShipAnimC()), XML(new ShipAnimXMLC()));
			var shipSeq:AnimationSequence = new AnimationSequence(ta, ["idleright", "idleleft", "kren", "rotate", "rrotater"], "idleright", 30);
			//var img:Image = new Image(Assets.getTexture("ShipC"));
			initEngines();
			engines = new Sprite();
			engines.addChild(engine1);
			engines.addChild(engine2);
			engines.addChild(engine3);
			engines.addChild(engine4);
			shipSeq.addChild(engines);
			shipSeq.pivotX += 2;
			shipSeq.pivotY -= 8;
			super(name, {view: shipSeq});

			_material = new Material(0.8, 1.0, 1.4, 1.5, 0.01);

			this.initKeyboardActions();
		}

		private function initEngines():void {
			engine1 = new Image(Assets.getTexture("EngineC"));
			engine2 = new Image(Assets.getTexture("EngineC"));
			engine3 = new Image(Assets.getTexture("EngineC"));
			engine4 = new Image(Assets.getTexture("EngineC"));

			engine1.pivotX = engine2.pivotX = engine3.pivotX = engine4.pivotX = 4;
			engine1.pivotY = engine2.pivotY = engine3.pivotY = engine4.pivotY = 26;


			engine1.x = 20;
			engine1.y = 20;

			engine2.x = 180;
			engine2.y = 15;

			engine3.x = 20;
			engine3.y = 70;

			engine4.x = 180;
			engine4.y = 45;

			engine1.rotation = 0;
			engine2.rotation = 0;
			engine3.rotation = Math.PI;
			engine4.rotation = Math.PI;
		}


		private var e1Angle:Number = 0;
		private var e2Angle:Number = 0;
		private var e3Angle:Number = Math.PI;
		private var e4Angle:Number = Math.PI;

		private function updateEngines():void {
			engine1.rotation += (e1Angle - engine1.rotation) / 20;
			engine2.rotation += (e2Angle - engine2.rotation) / 20;
			engine3.rotation -= (engine3.rotation - e3Angle) / 20;
			engine4.rotation -= (engine4.rotation - e4Angle) / 20;

			direction == -1 ? engines.x = 210 : engines.x = 0;
			engines.scaleX = direction;

		}


		override protected function createShape():void {

			points = Globals.getShipGeom();
			super.createShape();
		}

		private function flip(dir = 1):void {
			var oldPosition:Vec2 = body.position;
			var oldRotation:Number = body.rotation;
			var oldVelocity:Vec2 = body.velocity;
			if (testFlip(dir)) {
				body.shapes.clear();
				if (dir == 1) {
					points = Globals.getShipGeom();
					animation = "rrotater";
				} else {
					animation = "rotate";
					points = Globals.getShipGeom(true);
				}
				super.createShape();
				direction = dir;
			} else {
				//log("RETURN OLD");
				body.position = oldPosition;
				body.rotation = oldRotation;
				body.velocity = oldVelocity;
			}
			//engines.scaleX = -direction;
		}

		private function testFlip(dir):Boolean {
			var result:Boolean = true;
			body.shapes.clear();
			if (dir == 1) {
				points = Globals.getShipGeom();
			} else {
				points = Globals.getShipGeom(true);
			}

			super.createShape();
			//body.space.step(1 / 300.0);

			//log("ARBITERS: " + body.arbiters.length);
			if (body.arbiters.length > 0) {
				result = false;
				body.shapes.clear();
				dir = -dir;
				if (dir == 1) {
					points = Globals.getShipGeom();
				} else {
					points = Globals.getShipGeom(true);
				}

				super.createShape();

			}
			return result;
		}


		public function initKeyboardActions():void {
			var kb:Keyboard = _ce.input.keyboard;

			kb.addKeyAction("forward", Keyboard.RIGHT);
			kb.addKeyAction("backward", Keyboard.LEFT);
			kb.addKeyAction("up", Keyboard.W);
			kb.addKeyAction("down", Keyboard.S);

			kb.addKeyAction("rotateCW", Keyboard.A);
			kb.addKeyAction("rotateCCW", Keyboard.D);
		}

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			//
			e1Angle = -Math.PI / 4;
			e2Angle = Math.PI / 4;
			e3Angle = -Math.PI / 4 - Math.PI/2;
			e4Angle = Math.PI / 4 + Math.PI/2;

			engine1.visible = engine2.visible = engine3.visible = engine4.visible = false;

			//user input
			if (_ce.input.isDoing("rotateCW")) {
				body.applyAngularImpulse(-Globals.rotateImpulse);

				if (direction > 0)
				{
					e1Angle = 0;
					e4Angle = Math.PI;

					engine1.visible = true;
					engine4.visible = true;
				} else
				{
					e2Angle = 0;
					e3Angle = -Math.PI;

					engine2.visible = true;
					engine3.visible = true;
				}
			}

			if (_ce.input.isDoing("rotateCCW")) {
				body.applyAngularImpulse(Globals.rotateImpulse);

				if (direction > 0)
				{
					e2Angle = 0;
					e3Angle = -Math.PI;

					engine2.visible = true;
					engine3.visible = true;
				} else
				{
					e1Angle = 0;
					e4Angle = Math.PI;

					engine1.visible = true;
					engine4.visible = true;
				}
			}


			if (_ce.input.isDoing("forward")) {
				impulse = new Vec2(1, 0);
				impulse.length = (direction == 1 ? Globals.moveForwardImpulse : Globals.moveBackwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse, body.position);

				if (direction > 0)
				{
					e1Angle = -Math.PI / 2;
					e3Angle = -Math.PI / 2;

					engine1.visible = true;
					engine3.visible = true;
				}
				else
				{
					e2Angle = Math.PI / 2;
					e4Angle = Math.PI / 2;

					engine2.visible = true;
					engine4.visible = true;
				}
			}

			if (_ce.input.isDoing("backward")) {
				impulse = new Vec2(-1, 0);
				impulse.length = (direction == -1 ? Globals.moveBackwardImpulse : Globals.moveForwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse), body.position);

				if (direction > 0)
				{
					e2Angle = Math.PI / 2;
					e4Angle = Math.PI / 2;

					engine2.visible = true;
					engine4.visible = true;
				}
				else
				{
					e1Angle = -Math.PI / 2;
					e3Angle = -Math.PI / 2;

					engine1.visible = true;
					engine3.visible = true;
				}


			}

			if (_ce.input.isDoing("up")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveUpImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse).perp(), body.position);

				e3Angle = -Math.PI;
				e4Angle = Math.PI;

				engine3.visible = true;
				engine4.visible = true;

				if (_ce.input.isDoing("forward"))
				{
					e3Angle = -Math.PI / 4 - Math.PI/2;

				}

				if (_ce.input.isDoing("backward"))
				{
					e4Angle = Math.PI / 4 + Math.PI/2;
				}
			}

			if (_ce.input.isDoing("down")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveDownImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.perp(), body.position);

				e1Angle = 0;
				e2Angle = 0;

				engine1.visible = true;
				engine2.visible = true;

				if (_ce.input.isDoing("forward"))
				{
					e1Angle = -Math.PI / 4;

				}

				if (_ce.input.isDoing("backward"))
				{
					e2Angle = Math.PI / 4;
				}
			}

			if (_ce.input.hasDone("right")) {
				// double tap
				if (prevButton == "right" && (getTimer() - dt) < Globals.doubleTapDelay) {
					flip(1);
				} else {
					dt = getTimer();
					prevButton = "right";
				}
			}

			if (_ce.input.hasDone("left")) {
				// double tap
				if (prevButton == "left" && (getTimer() - dt) < Globals.doubleTapDelay) {
					flip(-1);
				} else {
					dt = getTimer();
					prevButton = "left";
				}
			}
			oldX = body.position.x;
			updateEngines();
		}
	}
}


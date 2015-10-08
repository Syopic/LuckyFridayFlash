package ua.com.syo.luckyfriday.view {
	import flash.utils.getTimer;

	import citrus.input.controllers.Keyboard;
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;
	import nape.phys.Material;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.model.Globals;


	public class ShipHero extends NapePhysicsObject {

		[Embed(source = "/../assets/anim/shipAnim.png")]
		private var ShipAnimC:Class;

		[Embed(source = "/../assets/anim/shipAnim.xml", mimeType = "application/octet-stream")]
		private var ShipAnimXMLC:Class;

		private var impulse:Vec2 =new Vec2(0, 0);

		private var oldX:Number = 0;
		private var dt:Number = 0;
		private var prevButton:String;

		private var direction:uint = 1;


		public function ShipHero(name:String, params:Object = null) {
			var ta:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ShipAnimC()), XML(new ShipAnimXMLC()));
			var shipSeq:AnimationSequence = new AnimationSequence(ta, ["idleright", "idleleft", "kren", "rotate", "rrotater"], "idleright", 30);
			super(name, {view: shipSeq});

			_material = new Material(0.8,1.0,1.4,1.5,0.01); 

			this.initKeyboardActions();
		}

		override protected function createShape():void
		{

			points = Globals.createShipGeom();
			super.createShape();
		}

		private function flip(dir):void
		{
			var oldPosition:Vec2 = body.position;
			var oldRotation:Number = body.rotation;
			var oldVelocity:Vec2 = body.velocity;
			if (testFlip(dir)) {
				body.shapes.clear();
				if (dir == 1)
				{
					points = Globals.createShipGeom();
					animation = "rrotater";
				} else
				{
					animation = "rotate";
					points = Globals.createShipGeom(true);
				}
				super.createShape();
				direction = dir;
			} else {
				//log("RETURN OLD");
				body.position = oldPosition;
				body.rotation = oldRotation;
				body.velocity = oldVelocity;
			}
		}

		private function testFlip(dir):Boolean
		{
			var result:Boolean = true;
			body.shapes.clear();
			if (dir == 1)
			{
				points = Globals.createShipGeom();
			} else
			{
				points = Globals.createShipGeom(true);
			}

			super.createShape();
			//body.space.step(1 / 300.0);

			//log("ARBITERS: " + body.arbiters.length);
			if (body.arbiters.length > 0) {
				result = false;
				body.shapes.clear();
				dir = -dir;
				if (dir == 1)
				{
					points = Globals.createShipGeom();
				} else
				{
					points = Globals.createShipGeom(true);
				}

				super.createShape();

			}
			return result;
		}


		public function initKeyboardActions():void
		{
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
			//user input
			if (_ce.input.isDoing("rotateCW")) {
				body.applyAngularImpulse(-Globals.rotateImpulse);
			}

			if (_ce.input.isDoing("rotateCCW")) {
				body.applyAngularImpulse(Globals.rotateImpulse);
			}


			if (_ce.input.isDoing("forward")) {
				impulse = new Vec2(1, 0);
				impulse.length = (direction == 1 ? Globals.moveForwardImpulse : Globals.moveBackwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse, body.position);
			}

			if (_ce.input.isDoing("backward")) {
				impulse = new Vec2(-1, 0);
				impulse.length = (direction == -1 ? Globals.moveBackwardImpulse : Globals.moveForwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse), body.position);
			}

			if (_ce.input.isDoing("up")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveUpImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse).perp(), body.position);
			}

			if (_ce.input.isDoing("down")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveDownImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.perp(), body.position);
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
		}
	}
}


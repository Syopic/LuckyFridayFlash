package ua.com.syo.luckyfriday.view {
	import flash.display.Shape;
	import flash.utils.getTimer;

	import citrus.input.controllers.Keyboard;
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.model.Globals;


	public class ShipHero extends NapePhysicsObject {

		[Embed(source = "/../assets/anim/shipAnim.png")]
		private var ShipAnimC:Class;

		[Embed(source = "/../assets/anim/shipAnim.xml", mimeType = "application/octet-stream")]
		private var ShipAnimXMLC:Class;

		public var impulse:Vec2 =new Vec2(0, 0);

		private var oldX:Number = 0;
		private var dt:Number = 0;
		private var prevButton:String;
		private var isInited:Boolean = false;

		public function ShipHero(name:String, params:Object = null) {
			var ta:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ShipAnimC()), XML(new ShipAnimXMLC()));
			var shipSeq:AnimationSequence = new AnimationSequence(ta, ["idleright", "idleleft", "kren", "rotate", "rrotater"], "idleright", 20);
			//var shape:Shape = new Shape(Globals.createShipGeom());
			super(name, {body:new Polygon(Globals.createShipGeom()), view: shipSeq});

			//body.shapes.add(new Polygon(Polygon.box(152 ,25)));
			//_material = new Material(0.8,1.0,1.4,1.5,0.01); 
			//StarlingArt.setLoopAnimations(["kren"]);
			this.initKeyboardActions();
		}

		public function initKeyboardActions():void
		{
			var kb:Keyboard = _ce.input.keyboard;

			kb.addKeyAction("right", Keyboard.RIGHT);
			kb.addKeyAction("left", Keyboard.LEFT);
			kb.addKeyAction("up", Keyboard.W);
			kb.addKeyAction("down", Keyboard.S);

			kb.addKeyAction("rotateCW", Keyboard.A);
			kb.addKeyAction("rotateCCW", Keyboard.D);
		}

		override public function initialize(poolObjectParam:Object = null):void {
			super.initialize(poolObjectParam);
			//body.shapes.add(new Polygon(Globals.createShipGeom()));
		}


		override public function update(timeDelta:Number):void {
			if (!isInited)
			{
				body.shapes.add(new Polygon(Globals.createShipGeom()));
				isInited = true;
			}
			//user input
			if (_ce.input.isDoing("rotateCW")) {
				body.applyAngularImpulse(-Globals.rotateImpulse);
			}

			if (_ce.input.isDoing("rotateCCW")) {
				body.applyAngularImpulse(Globals.rotateImpulse);
			}


			if (_ce.input.isDoing("right")) {
				impulse = new Vec2(1, 0);
				impulse.length = Globals.moveRightImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse, body.position);
			}

			if (_ce.input.isDoing("left")) {
				impulse = new Vec2(-1, 0);
				impulse.length = Globals.moveLeftImpulse;
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
					animation = "rrotater";
				} else {
					dt = getTimer();
					prevButton = "right";
				}
			}

			if (_ce.input.hasDone("left")) {
				// double tap
				if (prevButton == "left" && (getTimer() - dt) < Globals.doubleTapDelay) {
					animation = "rotate";
				} else {
					dt = getTimer();
					prevButton = "left";
				}
			}
			oldX = body.position.x;
		}
	}
}


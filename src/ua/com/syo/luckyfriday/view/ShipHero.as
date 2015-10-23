package ua.com.syo.luckyfriday.view {
	import flash.geom.Point;
	import flash.utils.getTimer;

	import citrus.input.controllers.Keyboard;
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;

	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.data.LevelData;
	import ua.com.syo.luckyfriday.model.Globals;
	import ua.com.syo.luckyfriday.view.ship.ThrusterView;


	public class ShipHero extends NapePhysicsObject {

		[Embed(source = "/../assets/anim/shipAnim.png")]
		private var ShipAnimC:Class;

		[Embed(source = "/../assets/anim/shipAnim.xml", mimeType = "application/octet-stream")]
		private var ShipAnimXMLC:Class;

		/**
		 * Views
		 */

		private var thrustersView:Sprite;
		private var animSeq:AnimationSequence;

		private var thrusters:Vector.<ThrusterView> = new Vector.<ThrusterView>(4);
		private var thrustersPosition:Array = new Array(new Point(20, 22), new Point(185, 15), new Point(20, 69), new Point(185, 37));
		private var thrusterRotation:Array = new Array(-Math.PI / 4, Math.PI / 4, -Math.PI / 4 - Math.PI / 2, Math.PI / 4 + Math.PI / 2);

		private var impulse:Vec2 = new Vec2(0, 0);

		private var dt:Number = 0;
		private var prevButton:String;

		public var direction:int = 1;

		public var isAnimationRunning:Boolean = false;

		public function ShipHero(name:String, params:Object = null) {
			thrustersView = new Sprite();

			initAnimations();
			initThrusters();

			super(name, {view: animSeq});
			initKeyboardActions();
		}

		private function initAnimations():void {
			var ta:TextureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(ShipAnimC), XML(new ShipAnimXMLC()));
			animSeq = new AnimationSequence(ta, ["idleright", "idleleft", "kren", "rotate", "rrotater"], "idleright", 140);
			animSeq.addChild(thrustersView);
			animSeq.onAnimationComplete.add(onAnimationOver);
		}

		protected function onAnimationOver(name:String):void
		{
			isAnimationRunning = false;
		}

		private function initThrusters():void {

			for (var i:int = 0; i < 4; i++) 
			{
				var thruster:ThrusterView = new ThrusterView(i, thrusterRotation[i]);
				thrusters[i] = thruster;
				thruster.x = thrustersPosition[i].x;
				thruster.y = thrustersPosition[i].y;
				thrustersView.addChild(thrusters[i]);
			}
			thrustersView.x = 105;
			thrustersView.pivotX = 105;
		}

		private function moveEmiter():void {

			var offset:Vec2;
			offset = new Vec2(100, 0);
			offset.rotate(body.rotation);
			GameState.instance.particles.mainEnginePS.emitterX = body.position.x - offset.x * direction;
			GameState.instance.particles.mainEnginePS.emitterY = body.position.y - offset.y * direction;
			GameState.instance.particles.mainEnginePS.speed = 200 * direction;
			GameState.instance.particles.mainEnginePS.emitAngle = -(Math.PI - body.rotation);

			var p:Point = new Point();
			for (var i:int = 0; i < 4; i++) 
			{
				if (thrusters[i].isActive)
				{
					offset = new Vec2(105-thrustersPosition[i].x, 45-thrustersPosition[i].y);
					offset.rotate(body.rotation* direction);
					p.x = body.position.x - offset.x * direction;
					p.y = body.position.y - offset.y;
					GameState.instance.particles.setThrusterPSParams(i, p, 300  * direction, body.rotation + (thrusters[i].angle - Math.PI/2) * direction );
				}
			}
		}



		override protected function createShape():void {

			points = LevelData.getShipGeom();
			super.createShape();
		}

		private function flip(dir = 1):void {
			var oldPosition:Vec2 = body.position;
			var oldRotation:Number = body.rotation;
			var oldVelocity:Vec2 = body.velocity;
			if (testFlip(dir)) {
				body.shapes.clear();
				if (dir == 1) {
					points = LevelData.getShipGeom();
					animation = "rrotater";
				} else {
					animation = "rotate";
					points = LevelData.getShipGeom(true);
				}
				super.createShape();
				direction = dir;
					//isAnimationRunning = true;
			} else {
				//log("RETURN OLD");
				body.position = oldPosition;
				body.rotation = oldRotation;
				body.velocity = oldVelocity;
			}
			thrustersView.scaleX = direction;
		}

		private function testFlip(dir):Boolean {
			var result:Boolean = true;
			body.shapes.clear();
			if (dir == 1) {
				points = LevelData.getShipGeom();
			} else {
				points = LevelData.getShipGeom(true);
			}

			super.createShape();
			//body.space.step(1 / 300.0);

			//log("ARBITERS: " + body.arbiters.length);
			if (body.arbiters.length > 0) {
				result = false;
				body.shapes.clear();
				dir = -dir;
				if (dir == 1) {
					points = LevelData.getShipGeom();
				} else {
					points = LevelData.getShipGeom(true);
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

			var thrustersVolume:Number = 0;
			for (var i:int = 0; i < 4; i++)
			{
				thrusters[i].isActive = false;
			}
			GameState.instance.particles.mainEnginePS.stop();

			//user input
			if (_ce.input.isDoing("rotateCW")) {
				body.applyAngularImpulse(-Globals.rotateImpulse);

				if (direction > 0) {
					thrusters[0].angle = 0;
					thrusters[3].angle = Math.PI;
				} else {
					thrusters[1].angle = 0;
					thrusters[2].angle = -Math.PI;
				}
			}

			if (_ce.input.isDoing("rotateCCW")) {
				body.applyAngularImpulse(Globals.rotateImpulse);
				if (direction > 0) {
					thrusters[1].angle = 0;
					thrusters[2].angle = -Math.PI;
				} else {
					thrusters[0].angle = 0;
					thrusters[3].angle = Math.PI;
				}
			}

			if (_ce.input.isDoing("forward")) {
				impulse = new Vec2(1, 0);
				impulse.length = (direction == 1 ? Globals.moveForwardImpulse : Globals.moveBackwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse, body.position);

				if (direction > 0) {
					thrusters[0].angle = -Math.PI / 2;
					thrusters[2].angle = -Math.PI / 2;
					if (!isAnimationRunning) {
						GameState.instance.particles.mainEnginePS.start();
						thrustersVolume = 0.2;
					}
				} else {
					thrusters[1].angle = Math.PI / 2;
					thrusters[3].angle = Math.PI / 2;
				}

			}


			if (_ce.input.isDoing("backward")) {
				impulse = new Vec2(-1, 0);
				impulse.length = (direction == -1 ? Globals.moveForwardImpulse : Globals.moveBackwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse), body.position);

				if (direction > 0) {
					thrusters[1].angle = Math.PI / 2;
					thrusters[3].angle = Math.PI / 2;

				} else {
					thrusters[0].angle = -Math.PI / 2;
					thrusters[2].angle = -Math.PI / 2;
					if (!isAnimationRunning)
					{
						thrustersVolume = 0.2;
						GameState.instance.particles.mainEnginePS.start();
					}
				}
			}

			if (_ce.input.isDoing("up")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveUpImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse).perp(), body.position);

				if (_ce.input.isDoing("forward"))
					thrusters[2].angle = -Math.PI / 4 - Math.PI / 2;
				else
					thrusters[2].angle = -Math.PI;

				if (_ce.input.isDoing("backward"))
					thrusters[3].angle = Math.PI / 4 + Math.PI / 2;
				else
					thrusters[3].angle = Math.PI;

			}

			if (_ce.input.isDoing("down")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveDownImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.perp(), body.position);


				if (_ce.input.isDoing("forward"))
					thrusters[0].angle = -Math.PI / 4;
				else
					thrusters[0].angle = 0;

				if (_ce.input.isDoing("backward"))
					thrusters[1].angle = Math.PI / 4;
				else
					thrusters[1].angle = 0;
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


			for (i = 0; i < 4; i++) 
			{
				thrusters[i].update();
				GameState.instance.particles.setThrusterPSActive(i, thrusters[i].isActive);

				if (thrusters[i].isActive) thrustersVolume += 0.1;

				if (isAnimationRunning)
					GameState.instance.particles.setThrusterPSActive(i, false);
			}
			if (thrustersVolume > 0) {
				GameState.instance.soundManager.resumeSound("engine");
				GameState.instance.soundManager.setVolume("engine", thrustersVolume);
			}
			else
			{
				GameState.instance.soundManager.pauseSound("engine");
			}


			thrustersView.visible = !isAnimationRunning;
			moveEmiter();
		}
	}
}


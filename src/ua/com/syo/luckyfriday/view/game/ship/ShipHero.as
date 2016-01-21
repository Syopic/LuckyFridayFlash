package ua.com.syo.luckyfriday.view.game.ship {
	import flash.geom.Point;

	import citrus.objects.NapePhysicsObject;
	import citrus.sounds.SoundManager;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;

	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.data.EmbededAssets;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.storage.level.CurrentLevelData;
	import ua.com.syo.luckyfriday.view.states.GameState;


	public class ShipHero extends NapePhysicsObject {

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
		}

		private function initAnimations():void {
			var ta:TextureAtlas = EmbededAssets.getShipHeroAtlas();
			animSeq = new AnimationSequence(ta, [Constants.IDLE_RIGHT_ANIMATION, Constants.IDLE_LEFT_ANIMATION, Constants.KREN_ANIMATION, Constants.ROTATE_ANIMATION, Constants.RROTATER_ANIMATION], Constants.IDLE_RIGHT_ANIMATION, 80);
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

			points = CurrentLevelData.getShipGeom();
			super.createShape();
		}

		private function flip(dir = 1):void {
			var oldPosition:Vec2 = body.position;
			var oldRotation:Number = body.rotation;
			var oldVelocity:Vec2 = body.velocity;
			if (testFlip(dir)) {
				body.shapes.clear();
				if (dir == 1) {
					points = CurrentLevelData.getShipGeom();
					animation = Constants.RROTATER_ANIMATION;
				} else {
					animation = Constants.ROTATE_ANIMATION;
					points = CurrentLevelData.getShipGeom(true);
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
				points = CurrentLevelData.getShipGeom();
			} else {
				points = CurrentLevelData.getShipGeom(true);
			}

			super.createShape();
			//body.space.step(1 / 300.0);

			//log("ARBITERS: " + body.arbiters.length);
			if (body.arbiters.length > 0) {
				result = false;
				body.shapes.clear();
				dir = -dir;
				if (dir == 1) {
					points = CurrentLevelData.getShipGeom();
				} else {
					points = CurrentLevelData.getShipGeom(true);
				}

				super.createShape();

			}
			return result;
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
			if (_ce.input.isDoing(Constants.ROTATECW_ACTION)) {
				body.applyAngularImpulse(-Globals.rotateImpulse);

				if (direction > 0) {
					thrusters[0].angle = 0;
					thrusters[3].angle = Math.PI;
				} else {
					thrusters[1].angle = 0;
					thrusters[2].angle = -Math.PI;
				}
			}

			if (_ce.input.isDoing(Constants.ROTATECCW_ACTION)) {
				body.applyAngularImpulse(Globals.rotateImpulse);
				if (direction > 0) {
					thrusters[1].angle = 0;
					thrusters[2].angle = -Math.PI;
				} else {
					thrusters[0].angle = 0;
					thrusters[3].angle = Math.PI;
				}
			}

			if (_ce.input.isDoing(Constants.FORWARD_ACTION)) {
				impulse = new Vec2(1, 0);
				impulse.length = (direction == 1 ? Globals.moveForwardImpulse : Globals.moveBackwardImpulse);
				impulse.angle = body.rotation;
				body.applyImpulse(impulse, body.position);

				if (direction > 0) {
					thrusters[0].angle = -Math.PI / 2;
					thrusters[2].angle = -Math.PI / 2;
					if (!isAnimationRunning) {
						GameState.instance.particles.mainEnginePS.start();
						thrustersVolume = 0.3;
					}
				} else {
					thrusters[1].angle = Math.PI / 2;
					thrusters[3].angle = Math.PI / 2;
				}
			}

			if (_ce.input.isDoing(Constants.BACKWARD_ACTION)) {
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
						thrustersVolume = 0.3;
						GameState.instance.particles.mainEnginePS.start();
					}
				}
			}

			if (_ce.input.isDoing(Constants.UP_ACTION)) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveUpImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.reflect(impulse).perp(), body.position);

				if (_ce.input.isDoing(Constants.FORWARD_ACTION))
					thrusters[2].angle = -Math.PI / 4 - Math.PI / 2;
				else
					thrusters[2].angle = -Math.PI;

				if (_ce.input.isDoing(Constants.BACKWARD_ACTION))
					thrusters[3].angle = Math.PI / 4 + Math.PI / 2;
				else
					thrusters[3].angle = Math.PI;
			}

			if (_ce.input.isDoing(Constants.DOWN_ACTION)) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveDownImpulse;
				impulse.angle = body.rotation;
				body.applyImpulse(impulse.perp(), body.position);


				if (_ce.input.isDoing(Constants.FORWARD_ACTION))
					thrusters[0].angle = -Math.PI / 4;
				else
					thrusters[0].angle = 0;

				if (_ce.input.isDoing(Constants.BACKWARD_ACTION))
					thrusters[1].angle = Math.PI / 4;
				else
					thrusters[1].angle = 0;
			}

			/*if (_ce.input.hasDone(Constants.RIGHT_ACTION)) {
				// double tap
				if (prevButton == Constants.RIGHT_ACTION && (getTimer() - dt) < Globals.doubleTapDelay) {
					flip(1);
				} else {
					dt = getTimer();
					prevButton = Constants.RIGHT_ACTION;
				}
			}

			if (_ce.input.hasDone(Constants.LEFT_ACTION)) {
				// double tap
				if (prevButton == Constants.LEFT_ACTION && (getTimer() - dt) < Globals.doubleTapDelay) {
					flip(-1);
				} else {
					dt = getTimer();
					prevButton = Constants.LEFT_ACTION;
				}
			}*/

			if (_ce.input.hasDone(Constants.RIGHT_TURN_ACTION)) {
				flip(1);
			}

			if (_ce.input.hasDone(Constants.LEFT_TURN_ACTION)) {
				flip(-1);
			}


			for (i = 0; i < 4; i++) 
			{
				thrusters[i].update();
				GameState.instance.particles.setThrusterPSActive(i, thrusters[i].isActive);

				if (thrusters[i].isActive) thrustersVolume += 0.2;

				if (isAnimationRunning)
					GameState.instance.particles.setThrusterPSActive(i, false);
			}
			if (thrustersVolume > 0) {
				SoundManager.getInstance().resumeSound(Constants.ENGINE_SFX);
				SoundManager.getInstance().setVolume(Constants.ENGINE_SFX, thrustersVolume);
			}
			else
			{
				SoundManager.getInstance().pauseSound(Constants.ENGINE_SFX);
			}


			thrustersView.visible = !isAnimationRunning;
			moveEmiter();
		}
	}
}


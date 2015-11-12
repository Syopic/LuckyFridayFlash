package ua.com.syo.luckyfriday.view.states {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.nape.Nape;
	import citrus.sounds.SoundManager;
	import citrus.view.starlingview.StarlingCamera;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.geom.Vec3;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.util.ShapeDebug;

	import starling.core.Starling;
	import starling.display.Image;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.LevelData;
	import ua.com.syo.luckyfriday.model.Globals;
	import ua.com.syo.luckyfriday.view.game.ShipHero;
	import ua.com.syo.luckyfriday.view.ui.HUDView;
	import ua.com.syo.luckyfriday.view.game.DrawingPhysicsObject;
	import ua.com.syo.luckyfriday.view.game.ParticlesView;
	import ua.com.syo.luckyfriday.view.UIManager;

	/**
	 *
	 * @author Syo
	 */
	public class GameState extends StarlingState {

		public var shipHero:ShipHero;
		private var debug:ShapeDebug;
		private var napeWorld:Nape;

		private var isDebug:Boolean = false;
		public var mainCamera:StarlingCamera;
		private var mcDebug:flash.display.MovieClip;

		private var bgSprite:CitrusSprite;
		private var caveSprite:CitrusSprite;

		public var particles:ParticlesView;
		private var flame:CitrusSprite;
		private var rocks:Vector.<DrawingPhysicsObject>;
		private var hudView:HUDView;

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
			bgSprite = new CitrusSprite("backgroud", {view: new Image(Assets.getTexture("BackgroundC"))});
			add(bgSprite);
			bgSprite.parallaxX = 0.1;
			bgSprite.parallaxY = 0.1;
			//addChild(new Demo());
			caveSprite = new CitrusSprite("cave", {view: new Image(Assets.getTexture("CaveC"))});
			add(caveSprite);

			LevelData.getObjectsByType(this, LevelData.CAVE_SHAPES, BodyType.STATIC);
			LevelData.getObjectsByType(this, LevelData.PLATFORM_SHAPES, BodyType.STATIC);
			rocks = LevelData.getObjectsByType(this, LevelData.ROCK_SHAPES, BodyType.DYNAMIC);

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
			mainCamera.allowZoom = true;

			mainCamera.zoomEasing = 0.001;
			//mainCamera.allowRotation = true;
			//mainCamera.parallaxMode = ACitrusCamera.BOUNDS_MODE_AABB;

			//camera.setRotation(Math.PI / 2);

			napeWorld.space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, OnCollision));
			hudView = new HUDView();
			addChild(hudView);

			SoundManager.getInstance().playSound(Constants.LOOP_MUSIC);
			SoundManager.getInstance().playSound(Constants.LOOP_ENVIRONMENT);
			SoundManager.getInstance().playSound(Constants.ENGINE_SFX);
			SoundManager.getInstance().pauseSound(Constants.ENGINE_SFX);

			//UIManager.instance.showSettings();
		}


		private function OnCollision(e:InteractionCallback):void
		{
			if (shipHero.body == e.int1 as Body || shipHero.body == e.int2 as Body)
			{
				//TODO
				var v3:Vec3 = shipHero.body.normalImpulse();

				cameraShake = Math.min(10, v3.length/1000);
					//soundManager.playSound("disconnect");
			}
		}

		private var pivotJoint:PivotJoint;
		private var t:Timer;

		private function createPivotJoint(body1:Body, body2:Body):void
		{
			var anchorBody_1:Vec2 = new Vec2(body1.localCOM.x, body1.localCOM.y + 55);
			var anchorBody_2:Vec2 = new Vec2(body2.localCOM.x, body2.localCOM.y);
			pivotJoint = new PivotJoint(body1, body2, anchorBody_1, anchorBody_2);
			//pivotJoint.ignore = true;
			pivotJoint.stiff = false;
			pivotJoint.maxError = 50;
			pivotJoint.maxForce = 4000;
			pivotJoint.breakUnderError = true;
			pivotJoint.breakUnderForce = true;
			pivotJoint.space = napeWorld.space;
			pivotJoint.removeOnBreak = true;
			t = new Timer(1000, 1);
			t.addEventListener(TimerEvent.TIMER, deactivateJoint);
			t.start();
		}



		private function deactivateJoint(event:TimerEvent):void
		{
			//pivotJoint.active = !pivotJoint.active;
			pivotJoint.maxError = 1;
			pivotJoint.maxForce = 500;
			pivotJoint.breakUnderError = true;
			pivotJoint.breakUnderForce = true;
			t.removeEventListener(TimerEvent.TIMER, deactivateJoint);
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

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			hudView.updateTimeLabel(getTimer());
			if (_ce.input.hasDone(Constants.CONSOLE_ACTION)) {
				//
			}
			if (_ce.input.hasDone(Constants.MENU_ACTION)) {
				UIManager.instance.changeState(MenuState.newInstance);  
			}

			if (_ce.input.hasDone(Constants.BREAK_ACTION)) {
				if (pivotJoint && pivotJoint.space)
				{
					pivotJoint.space = null;
					SoundManager.getInstance().playSound(Constants.DISCONNECT_SFX);
				}
				else
				{
					for (var i:int = 0; i < rocks.length; i++) 
					{
						if (Vec2.distance(shipHero.body.position, rocks[i].body.position) < 100)
						{
							createPivotJoint(shipHero.body, rocks[i].body);
							SoundManager.getInstance().playSound(Constants.CONNECT_SFX);
							break;
						}

					}
				}
			}

			shipHero.update(timeDelta);

			if (Globals.isDebugMode) {
				debug.clear();
				debug.draw(napeWorld.space);
				debug.flush();
				mcDebug.x = -mainCamera.camPos.x + stage.stageWidth / 2;
				mcDebug.y = -mainCamera.camPos.y + stage.stageHeight / 2;
			}

			if (Math.abs(3840 / 2 - mainCamera.camPos.x) < 300)
			{
				if (!isZoomIn)
				{
					camera.baseZoom = 1.5;
					isZoomIn = true;
				}
			}
			else
			{
				if (isZoomIn)
				{
					camera.baseZoom = 1;
					isZoomIn = false;
				}
			}
			shakeAnimation(null);
			//flame.x = -mainCamera.camPos.x;
			//flame.y = -mainCamera.camPos.y;
		}

		private var isZoomIn:Boolean = false;

		private var cameraShake:Number = 0;
		private function shakeAnimation(event:Event):void
		{
			// Animate quake effect, shaking the camera a little to the sides and up and down.
			if (cameraShake > 0)
			{
				cameraShake -= 0.1;
				// Shake left right randomly.
				this.x = int(Math.random() * cameraShake - cameraShake * 0.5); 
				// Shake up down randomly.
				this.y = int(Math.random() * cameraShake - cameraShake * 0.5); 
			}
			else if (x != 0) 
			{
				// If the shake value is 0, reset the stage back to normal.
				// Reset to initial position.
				this.x = 0;
				this.y = 0;
			}
		}

		private static var _instance:GameState;

		public static function get instance():GameState
		{
			if (_instance == null) _instance = new GameState();
			return _instance;
		}

		public static function get newInstance():GameState
		{
			_instance = new GameState();
			return _instance;
		}
	}
}


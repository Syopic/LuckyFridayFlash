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
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.extensions.lighting.core.LightLayer;
	import starling.extensions.lighting.lights.PointLight;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.storage.level.CurrentLevelData;
	import ua.com.syo.luckyfriday.utils.Utils;
	import ua.com.syo.luckyfriday.view.game.ParticlesView;
	import ua.com.syo.luckyfriday.view.game.draggedobjects.DrawingDO;
	import ua.com.syo.luckyfriday.view.game.ship.ShipHero;
	import ua.com.syo.luckyfriday.view.ui.HUDView;

	/**
	 *
	 * @author Syo
	 */
	public class GameState extends StarlingState {

		private var shipHero:ShipHero;
		private var debug:ShapeDebug;
		private var napeWorld:Nape;

		private var isDebug:Boolean = false;
		private var mainCamera:StarlingCamera;
		private var mcDebug:flash.display.MovieClip;

		private var bgSprite:CitrusSprite;
		private var caveSprite:CitrusSprite;

		public var particles:ParticlesView;
		private var flame:CitrusSprite;
		private var rocks:Vector.<DrawingDO>;
		private var hudView:HUDView;

		private var lightLayer:LightLayer;
		private var shipLight:PointLight;
		private var p1Light:PointLight;
		private var p2Light:PointLight;
		private var light:CitrusSprite;
		private var currentContainer:DrawingDO;

		override public function initialize():void {
			super.initialize();

			// init nape
			napeWorld = new Nape("nape", {gravity: new Vec2(0, Globals.gravity)});
			add(napeWorld);
			if (Globals.isDebugMode) {
				initDebugLayer();
			}

			// add background
			bgSprite = new CitrusSprite("backgroud", {view: new Image(CurrentLevelData.bgTexture)});
			add(bgSprite);
			bgSprite.parallaxX = 0.1;
			bgSprite.parallaxY = 0.1;
			//addChild(new Demo());
			caveSprite = new CitrusSprite("cave", {view: new Image(CurrentLevelData.fgTexture)});
			add(caveSprite);

			CurrentLevelData.generateShapes();

			CurrentLevelData.getObjectsByType(this, DrawingDO.CAVE_SHAPES, BodyType.STATIC);
			CurrentLevelData.getObjectsByType(this, DrawingDO.PLATFORM_SHAPES, BodyType.STATIC);
			rocks = CurrentLevelData.getObjectsByType(this, DrawingDO.ROCK_SHAPES, BodyType.DYNAMIC);


			//initLights();

			// add ship hero
			shipHero = new ShipHero("ship");
			particles = new ParticlesView();
			flame = new CitrusSprite("flame", {view: particles});
			add(flame);
			//shipHero.particles = particles;
			add(shipHero);
			shipHero.body.position.setxy(300, 300);


			//var sa:SpriteArt = shipHero.art as SpriteArt;
			//var mc:DisplayObject = DisplayObject(sa.content);

			//lightLayer.addShadowGeometry(new ShadowGeometry(mc));
			mainCamera = view.camera as StarlingCamera;
			mainCamera.setUp(shipHero, new Rectangle(0, 0, CurrentLevelData.levelWidth, CurrentLevelData.levelHeight), new Point(.5, .5));
			mainCamera.allowZoom = true;

			mainCamera.zoomEasing = 0.001;
			mainCamera.baseZoom = 1;
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

		private function OnCollision(e:InteractionCallback):void {
			if (shipHero.body == e.int1 as Body || shipHero.body == e.int2 as Body) {
				//TODO
				var v3:Vec3 = shipHero.body.normalImpulse();

				cameraShake = Math.min(10, v3.length / 1000);
					//soundManager.playSound("disconnect");
			}
		}

		private var pivotJoint:PivotJoint;
		private var t:Timer;

		private function createPivotJoint(shipBody:Body, container:DrawingDO):void {
			var bBox:Rectangle = Utils.getBoundingBox(container.points);
			var w:Number = bBox.width;
			var h:Number = bBox.height;

			var shipAnchor:Vec2 = new Vec2(shipBody.localCOM.x, shipBody.localCOM.y + 40);
			var nearestAnchor:Vec2;
			var minDistance:Number = 1000;
			for (var i:int = 0; i < container.braces.length; i++) 
			{
				var tAnchor:Vec2 = new Vec2(container.body.localCOM.x + container.braces[i].x, container.body.localCOM.y + container.braces[i].y);
				var tDistance:Number = Vec2.distance(shipBody.localPointToWorld(shipAnchor), container.body.localPointToWorld(tAnchor));
				if (tDistance < minDistance)
				{
					minDistance = tDistance;
					nearestAnchor = tAnchor;
				}
			}

			pivotJoint = new PivotJoint(shipBody, container.body, shipAnchor, nearestAnchor);

			//pivotJoint.ignore = true;
			pivotJoint.stiff = false;
			pivotJoint.maxError = 50;
			pivotJoint.maxForce = 7000;
			pivotJoint.frequency = 1;
			pivotJoint.damping = 1;
			pivotJoint.breakUnderError = true;
			pivotJoint.breakUnderForce = true;
			pivotJoint.space = napeWorld.space;
			pivotJoint.removeOnBreak = true;
			t = new Timer(2000, 1);
			t.addEventListener(TimerEvent.TIMER, deactivateJoint);
			t.start();

			currentContainer = container;
		}



		private function deactivateJoint(event:TimerEvent):void {
			//pivotJoint.active = !pivotJoint.active;
			pivotJoint.maxError = 1;
			pivotJoint.maxForce = 500;
			pivotJoint.breakUnderError = true;
			pivotJoint.breakUnderForce = true;
			t.removeEventListener(TimerEvent.TIMER, deactivateJoint);
		}

		/**
		 * Init lights
		 */
		private var geometry:Vector.<DisplayObject>;
		private var probes:CitrusSprite;

		private function initLights():void {
			lightLayer = new LightLayer(stage.stageWidth, stage.stageHeight, 0x000000, 0);
			//create a white light that will follow the mouse position
			shipLight = new PointLight(0, 0, 1000, 0xffffff, 1);
			//add it to the light layer

			p1Light = new PointLight(200, 800, 100, 0xffffff, 1);
			//addChild(lightLayer);

			lightLayer.addLight(shipLight);
			lightLayer.addLight(p1Light);
			geometry = new <DisplayObject>[];

			var quad:Quad;
			var w:int;
			var h:int;
			//create an arbitrary number of quads to act as shadow geometry
			var probesCont:Sprite = new Sprite();
			for (var i:int; i < 50; i++) {
				w = 10 + Math.round(Math.random() * 10);
				h = 4;

				quad = new Quad(w, h, Math.random() * 0xffffff);
				quad.pivotX = w / 2;
				quad.pivotY = h / 2;
				quad.x = Math.random() * stage.stageWidth;
				quad.y = Math.random() * stage.stageHeight;

				//this takes the bounding box of the quad to create geometry that blocks light
				//the QuadShadowGeometry class also accepts Images
				//if you want to create more complex geometry for a display object, 
				//you can make your own ShadowGeometry subclass, and override the createEdges method
				//lightLayer.addShadowGeometry(new QuadShadowGeometry(quad));

				//add the quad to the stage
				//the quad will cast shadows even if it is not on the display list (I might change this later)
				//to remove shadow geometry assosiated with a display object, call LightLayer.removeGeometryForDisplayObject 			
				probesCont.addChild(quad);

				geometry.push(quad);
			}

			//probes = new CitrusSprite("probes", {view:probesCont});
			//add(probes);
			light = new CitrusSprite("light", {view: lightLayer});
			add(light);
		}


		/**
		 * Init debug layer
		 */
		private function initDebugLayer():void {
			debug = new ShapeDebug(CurrentLevelData.levelWidth, CurrentLevelData.levelHeight);
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

			//mouseLight.x = shipHero.body.position.x + mainCamera.camPos.x;
			//mouseLight.y = shipHero.body.position.y + mainCamera.camPos.y;

			/*p1Light.x = -mainCamera.camPos.x + stage.stageWidth / 2 + 200;
			p1Light.y = -mainCamera.camPos.y + stage.stageHeight / 2 + 600;

			shipLight.x = shipHero.x-mainCamera.camPos.x + stage.stageWidth / 2;
			shipLight.y = shipHero.y-mainCamera.camPos.y + stage.stageHeight / 2;
			*/
			/*if (lightLayer)
			{
				lightLayer.x = shipHero.body.position.x;
				lightLayer.y = shipHero.body.position.y;
			}*/

			hudView.updateTimeLabel(getTimer());
			if (_ce.input.hasDone(Constants.CONSOLE_ACTION)) {
				//
			}
			if (_ce.input.hasDone(Constants.MENU_ACTION)) {
				Controller.instance.changeState(MenuState.newInstance);
			}

			if (_ce.input.hasDone(Constants.BREAK_ACTION)) {
				if (pivotJoint && pivotJoint.space) {
					pivotJoint.space = null;
					SoundManager.getInstance().playSound(Constants.DISCONNECT_SFX);
					if (currentContainer != null)
					{
						currentContainer.body.applyImpulse(currentContainer.body.velocity);
					}
				} else {
					var nearestObject:DrawingDO;
					var minDistance:Number = 1000;
					for (var i:int = 0; i < rocks.length; i++) {
						// TODO
						var shipAnchor:Vec2 = new Vec2(shipHero.body.localCOM.x, shipHero.body.localCOM.y + 40);
						for (var n:int = 0; n < rocks[i].braces.length; n++) 
						{
							var tAnchor:Vec2 = new Vec2(rocks[i].body.localCOM.x + rocks[i].braces[n].x, rocks[i].body.localCOM.y + rocks[i].braces[n].y);
							var tDistance:Number = Vec2.distance(shipHero.body.localPointToWorld(shipAnchor), rocks[i].body.localPointToWorld(tAnchor));
							if (tDistance < minDistance)
							{
								minDistance = tDistance;
								nearestObject = rocks[i];
							}
						}

					}
					if (minDistance < 100 && nearestObject != null) {
						createPivotJoint(shipHero.body, nearestObject);
						SoundManager.getInstance().playSound(Constants.CONNECT_SFX);
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

			if (Math.abs(CurrentLevelData.levelWidth / 2 - mainCamera.camPos.x) < 100) {
				if (!isZoomIn) {
					mainCamera.baseZoom = 1;
					isZoomIn = true;
				}
			} else {
				if (isZoomIn) {
					mainCamera.baseZoom = 1;
					isZoomIn = false;
				}
			}
			shakeAnimation(null);
			//flame.x = -mainCamera.camPos.x;
			//flame.y = -mainCamera.camPos.y;
		}

		private var isZoomIn:Boolean = false;

		private var cameraShake:Number = 0;

		private function shakeAnimation(event:Event):void {
			// Animate quake effect, shaking the camera a little to the sides and up and down.
			if (cameraShake > 0) {
				cameraShake -= 0.1;
				// Shake left right randomly.
				this.x = int(Math.random() * cameraShake - cameraShake * 0.5);
				// Shake up down randomly.
				this.y = int(Math.random() * cameraShake - cameraShake * 0.5);
			} else if (x != 0) {
				// If the shake value is 0, reset the stage back to normal.
				// Reset to initial position.
				this.x = 0;
				this.y = 0;
			}
		}

		private static var _instance:GameState;

		public static function get instance():GameState {
			if (_instance == null) {
				_instance = new GameState();
			}
			return _instance;
		}

		public static function get newInstance():GameState {
			_instance = new GameState();
			return _instance;
		}
	}
}


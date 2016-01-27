package ua.com.syo.luckyfriday.view.states {

	import citrus.core.starling.StarlingState;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.controller.events.MissionPointEvent;
	import ua.com.syo.luckyfriday.data.EmbededAssets;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.storage.mission.Mission;
	import ua.com.syo.luckyfriday.model.storage.mission.MissionStorage;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.meta.MissionsMeteor;
	import ua.com.syo.luckyfriday.view.meta.MissionsPoint;
	import ua.com.syo.luckyfriday.view.meta.AdditionalMissionPoint;
	import flash.display.Shape;

	public class MissionsState extends StarlingState {

		private var backBtn:Button;
		private var container:LayoutGroup;
		private var settingsBtn:Button;
		private var bg:Image;
		private var meteor:MissionsMeteor;
		private var point:MissionsPoint;
		private var additPoint:AdditionalMissionPoint;
		private var containerPoint:Sprite = new Sprite();
		private var myShape:Shape = new Shape();

		override public function initialize():void {
			super.initialize();
			initBg();
			initButtons();
			initMissionPoints()

		}

		private function initBg():void {

			bg = new Image(Texture.fromEmbeddedAsset(EmbededAssets.SpacebgC));
			meteor = new MissionsMeteor("location1");
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(bg);
			addChild(meteor);

		}



		/**
		 * Init buttons
		 */
		private function initButtons():void {
			container = new LayoutGroup();
			container.layout = new AnchorLayout();
			container.autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;
			this.addChild(container);

			// back
			backBtn = new Button();
			backBtn.label = "←";
			backBtn.width = 75;
			backBtn.height = 75;
			backBtn.layoutData = new AnchorLayoutData(20, NaN, NaN, 20);
			backBtn.addEventListener(starling.events.Event.TRIGGERED, buttonClicked);
			container.addChild(backBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			settingsBtn.defaultIcon = new Image(EmbededAssets.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(starling.events.Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);
		}

		/**
		 * Init Mission Point
		 *
		 */
		private function initMissionPoints():void {
			primaryMissionPoints();
		}

		/**
		 * Add in state  Mission
		 */
		private function primaryMissionPoints():void {
			
			//curves();
			var n:String;
			var s:int;
			var enab:Boolean;
			var additionalMissionId:Array = MissionStorage.getMissionIdByType("location1", true);
			if (additionalMissionId.length > 0) {
				for (var ai:int = 0; ai < additionalMissionId.length; ai++) {
					var am:Mission = MissionStorage.getMissionById(additionalMissionId[ai]);
					//var par:Array = am.missionId.split(".", 3);
					//n = par[2];
					trace("Additional Mission " + additionalMissionId[ai] + " in Location + locationId");
					additPoint = new AdditionalMissionPoint(additionalMissionId[ai], am.missionEnable);
					additPoint.name = additionalMissionId[ai];
					additPoint.x = (am.pointX * meteor.resizeY) + meteor.psitionX;
					additPoint.y = (am.pointY * meteor.resizeY) + 100;
					additPoint.addEventListener(MissionPointEvent.MISSION_SELECT, isSelect)
					containerPoint.addChild(additPoint);
				}
			} else {
			}
			var primaryMissionId:Array = MissionStorage.getMissionIdByType("location1", false);
			for (var i:int = 0; i < primaryMissionId.length; i++) {
				var m:Mission = MissionStorage.getMissionById(primaryMissionId[i]);
				var params:Array = m.missionId.split(".", 2);
				n = params[1];
				trace("Mission " + n + " in Location + locationId");
				point = new MissionsPoint(n, m.missionEnable, m.rate);
				point.name = n;
				point.x = (m.pointX * meteor.resizeY) + meteor.psitionX;
				point.y = (m.pointY * meteor.resizeY) + 100;
				point.addEventListener(MissionPointEvent.MISSION_SELECT, isSelect)
				containerPoint.addChild(point);
			}
			addChild(containerPoint);
		}

		/**
		 * Function arrange change scale background and  psition coordinats missions when changes stage width
		 * @param event
		 */
		private function arrange(event:Event):void {

			if (Globals.stageWidth < 1920) {
				bg.width = 1920;
				bg.height = 1024;
			} else {
				bg.width = Globals.stageWidth;
				bg.height = Globals.stageHeight;
			}
			var n:String;
			var primaryMissionId:Array = MissionStorage.getMissionIdByType("location1", false);
			//arange primary point
			for (var i:int = 0; i < primaryMissionId.length; i++) {
				var m:Mission = MissionStorage.getMissionById(primaryMissionId[i]);
				var params:Array = m.missionId.split(".", 2);
				n = params[1];
				point = containerPoint.getChildByName(n) as MissionsPoint;
				point.x = (m.pointX * meteor.resizeY) + meteor.psitionX;
				point.y = (m.pointY * meteor.resizeY) + 100;
			}
			var additionalMissionId:Array = MissionStorage.getMissionIdByType("location1", true);
			if (additionalMissionId.length > 0) {
				for (var ai:int = 0; ai < additionalMissionId.length; ai++) {
					var am:Mission = MissionStorage.getMissionById(additionalMissionId[ai]);
					additPoint = containerPoint.getChildByName(additionalMissionId[ai]) as AdditionalMissionPoint;
					additPoint.x = (am.pointX * meteor.resizeY) + meteor.psitionX;
					additPoint.y = (am.pointY * meteor.resizeY) + 100;
				}
			} else {
			}
		}
		private function curves():void {
		myShape.graphics.beginFill(0xFF0000);
		myShape.graphics.moveTo(100, 100); 
		myShape.graphics.curveTo(175, 125, 200, 200);
		//addChild(myShape);
		}
		/**
		 * Function isSelect - is start selection mission
		 * @param event
		 */
		public function isSelect(event:MissionPointEvent):void {
			Controller.instance.startLoadLevel(event.id);
			trace("triggered! " + event.id);
		}

		/**
		 * Handling button clicked
		 * @param event
		 *
		 */
		private function buttonClicked(event:starling.events.Event):void {
			switch (event.currentTarget as Button) {
				case backBtn:
					Controller.instance.changeState(LocationsState.newInstance);
					break;
				case settingsBtn:
					UIManager.instance.showSettings();
			}
		}


		/**
		 * Singleton
		 */
		private static var _instance:MissionsState;

		public static function get instance():MissionsState {
			if (_instance == null) {
				_instance = new MissionsState();
			}
			return _instance;
		}

		/**
		 * Reinstance for changeState
		 * @return
		 *
		 */
		public static function get newInstance():MissionsState {
			_instance = new MissionsState();
			return _instance;
		}
	}
}


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

	public class MissionsState extends StarlingState {

		private var backBtn:Button;
		private var container:LayoutGroup;
		private var settingsBtn:Button;
		private var bg:Image;
		private var meteor:MissionsMeteor;
		private var point:MissionsPoint;
		private var containerPoint:Sprite = new Sprite();

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
		 * Add in state primary Mission
		 */
		private function primaryMissionPoints():void {
			var n:String;
			var s:int;
			var enab:Boolean;
			//var additionalMissionId:Array =  MissionStorage.getMissionIdByType("location1", true);
			var primaryMissionId:Array = MissionStorage.getMissionIdByType("location1", false);
			//var l:Location  = MissionStorage.getLocationById("location1");
			for (var i:int = 0; i < primaryMissionId.length; i++) {
				var m:Mission = MissionStorage.getMissionById(primaryMissionId[i]);
				var params:Array = m.missionId.split(".", 2);
				n = params[1];
				trace("Mission " + n + " in Location + locationId");
				point = new MissionsPoint(n, m.missionEnable);
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
				trace(Globals.stageWidth)
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
		}



		/**
		 *  Function isSelect - is start selection mission
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


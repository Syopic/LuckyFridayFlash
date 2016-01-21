package ua.com.syo.luckyfriday.view.states {

	import citrus.core.starling.StarlingState;
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.controller.events.LevelEvent;
	import ua.com.syo.luckyfriday.controller.events.MissionPointEvent;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.model.storage.mission.Location;
	import ua.com.syo.luckyfriday.model.storage.mission.Mission;
	import ua.com.syo.luckyfriday.model.storage.mission.MissionStorage;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.meta.ImageButton;
	import ua.com.syo.luckyfriday.view.meta.MissionsMeteor;
	import ua.com.syo.luckyfriday.view.meta.MissionsPoint;

	public class MissionsState extends StarlingState {

		private var backBtn:Button;
		private var mission1Btn:ImageButton;
		private var mission2Btn:ImageButton;
		private var mission3Btn:ImageButton;
		private var mission4Btn:ImageButton;
		private var mission5Btn:ImageButton;
		private var mission6Btn:ImageButton;
		private var container:LayoutGroup;
		private var settingsBtn:Button;
		private var bg:Image;
		private var meteor:MissionsMeteor = new MissionsMeteor;
		private var point:MissionsPoint;
		private var px:Array = [350, 450, 550, 850, 750, 600];
		private var py:Array = [150, 350, 150, 400, 100, 400];

		override public function initialize():void {
			super.initialize();
			initBg();
			initButtons();
			initMissionPoints()

		}

		private function initBg():void {

			
			bg = new Image(Texture.fromEmbeddedAsset(Assets.SpacebgC));
			//bg.width = Globals.stageWidth;
			//bg.height = Globals.stageHeight;
			UIManager.instance.addEventListener(Event.RESIZE, arrange);
			addChild(bg);
			addChild(meteor);

		}

		private function arrange():void {
			if (Globals.stageWidth < 1920) {
				bg.width = 1920;
				bg.height = 1024;
			} else {
				trace(Globals.stageWidth)
				bg.width = Globals.stageWidth;
				bg.height = Globals.stageHeight;
			}
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
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(backBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			settingsBtn.defaultIcon = new Image(Assets.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);
		}

		/**
		 * Init Mission Point
		 */
		private function initMissionPoints():void {
			var n:String;
			var s:int;
			var enab:Boolean;
			//var baseMissionId:Array = MissionStorage.getMissionByAdditional(true);
			var primaryMissionId:Array = MissionStorage.getMissionByType("location1", true);
			trace ("->")
			var l:Location  = MissionStorage.getLocationById("location1");
			var m:Mission = MissionStorage.getMissionById(primaryMissionId[1]);
			trace (m.pointX,m.pointY)
			
			for (var i:int = 1; i < 7; i++) {
				n = String(i);
				s = i - 1;
				if (i <= 5) {
					enab = true;
				} else {
					enab = false;
				}
				point = new MissionsPoint(n, enab);
				point.x = px[s];
				point.y = py[s];
				point.addEventListener(MissionPointEvent.MISSION_SELECT, isSelect)
				this.addChild(point);

			}
		}



		public function isSelect(event:MissionPointEvent):void {
			Controller.instance.startLevel(event.id);
			trace("triggered! " + event.id);
			Controller.instance.addEventListener(LevelEvent.LEVEL_LOADED, startLevel);
			
		}
		
		private function startLevel():void
		{
			// TODO Auto Generated method stub
			Controller.instance.changeState(GameState.newInstance);
		}
		
		
		private function buttonClicked(event:Event):void {
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


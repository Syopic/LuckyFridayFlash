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
	import ua.com.syo.luckyfriday.data.EmbededAssets;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.meta.MissionsButton;
	import ua.com.syo.luckyfriday.view.meta.MissionsMeteor;

	public class MissionsState extends StarlingState {

		private var backBtn:Button;
		private var mission1Btn:MissionsButton;
		private var mission2Btn:MissionsButton;
		private var mission3Btn:MissionsButton;
		private var mission4Btn:MissionsButton;
		private var mission5Btn:MissionsButton;
		private var mission6Btn:MissionsButton;
		private var container:LayoutGroup;
		private var settingsBtn:Button;
		private var bg:Image;
		private var meteor:MissionsMeteor = new MissionsMeteor;

		override public function initialize():void {
			super.initialize();
			initBg();
			initButtons();

		}

		private function initBg():void {

			bg = new Image(Texture.fromEmbeddedAsset(EmbededAssets.SpacebgC));
			bg.width = Globals.stageWidth;
			bg.height = Globals.stageHeight;
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


			// mission 
			mission1Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "1", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission1Btn.fontName = EmbededAssets.font.fontName;
			mission1Btn.fontSize = 50;
			mission1Btn.fontBold = true;
			mission1Btn.x = 500;
			mission1Btn.y = 100;
			mission1Btn.enabled = true;
			mission1Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission1Btn);

			mission2Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "2", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission2Btn.fontName = EmbededAssets.font.fontName;
			mission2Btn.fontSize = 50;
			mission2Btn.fontBold = true;
			mission2Btn.x = 500;
			mission2Btn.y = 200;
			mission2Btn.enabled = true;
			mission2Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission2Btn);

			mission3Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "3", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission3Btn.fontName = EmbededAssets.font.fontName;
			mission3Btn.fontSize = 50;
			mission3Btn.fontBold = true;
			mission3Btn.x = 500;
			mission3Btn.y = 300;
			mission3Btn.enabled = true;
			mission3Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission3Btn);


			mission4Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "4", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission4Btn.fontName = EmbededAssets.font.fontName;
			mission4Btn.fontSize = 50;
			mission4Btn.fontBold = true;
			mission4Btn.x = 600;
			mission4Btn.y = 100;
			mission4Btn.enabled = true;
			mission4Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission4Btn);


			mission5Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "5", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission5Btn.fontName = EmbededAssets.font.fontName;
			mission5Btn.fontSize = 50;
			mission5Btn.fontBold = true;
			mission5Btn.x = 600;
			mission5Btn.y = 200;
			mission5Btn.enabled = true;
			mission5Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission5Btn);

			mission6Btn = new MissionsButton(Texture.fromEmbeddedAsset(EmbededAssets.LogobtnC), "6", Texture.fromEmbeddedAsset(EmbededAssets.ButtonDownC), null, Texture.fromEmbeddedAsset(EmbededAssets.ButtonDisabledC));
			mission6Btn.fontName = EmbededAssets.font.fontName;
			mission6Btn.fontSize = 50;
			mission6Btn.fontBold = true;
			mission6Btn.x = 600;
			mission6Btn.y = 300;
			mission6Btn.enabled = false;
			mission6Btn.addEventListener(Event.TRIGGERED, bttClicked);
			container.addChild(mission6Btn);

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
			settingsBtn.defaultIcon = new Image(EmbededAssets.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);
		}

		private function bttClicked(event:Event):void {
			trace("triggered!");
			switch (event.currentTarget as MissionsButton) {
				case mission1Btn:
					Controller.instance.startLevel("1");
					break;
				case mission2Btn:
					Controller.instance.startLevel("2");
					break;
				case mission3Btn:
					Controller.instance.startLevel("3");
					break;
				case mission4Btn:
					Controller.instance.startLevel("4");
					break;
				case mission5Btn:
					Controller.instance.startLevel("5");
					break;

			}

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


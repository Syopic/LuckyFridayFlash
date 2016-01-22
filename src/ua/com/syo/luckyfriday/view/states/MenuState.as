package ua.com.syo.luckyfriday.view.states
{
	import citrus.core.starling.StarlingState;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.EmbededAssets;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.model.storage.profile.ProfileStorage;
	import ua.com.syo.luckyfriday.view.UIManager;

	public class MenuState extends StarlingState
	{
		private var playBtn:Button;
		private var locationsBtn:Button;
		private var helpBtn:Button;
		private var profileBtn:Button;
		private var settingsBtn:Button;
		private var exitBtn:Button;
		private var container:LayoutGroup;

		private var versionLabel:Label;

		override public function initialize():void   
		{   
			super.initialize(); 
			initButtons();
		}

		/**
		 * Init buttons
		 */
		private function initButtons():void {

			container = new LayoutGroup();
			container.layout = new AnchorLayout();
			container.autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;
			this.addChild(container);

			// play
			playBtn = new Button();
			playBtn.label = "PLAY";
			playBtn.width = 300;
			playBtn.height = 100;
			playBtn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			playBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(playBtn);

			// locations
			locationsBtn = new Button();
			locationsBtn.label = "LOCATIONS";
			locationsBtn.width = 300;
			locationsBtn.height = 100;
			locationsBtn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 120);
			locationsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(locationsBtn);

			// help
			helpBtn = new Button();
			helpBtn.label = "?";
			helpBtn.width = 75;
			helpBtn.height = 75;
			helpBtn.layoutData = new AnchorLayoutData(20, NaN, NaN, 20);
			helpBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(helpBtn);

			// profile
			profileBtn = new Button();
			profileBtn.label = "P";
			profileBtn.width = 75;
			profileBtn.height = 75;
			profileBtn.layoutData = new AnchorLayoutData(20, 20);
			profileBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(profileBtn);

			// exit
			exitBtn = new Button();
			exitBtn.width = 75;
			exitBtn.height = 75;
			exitBtn.layoutData = new AnchorLayoutData(NaN, NaN, 20, 20);
			exitBtn.defaultIcon = new Image(EmbededAssets.getTexture("PowerIconC"));
			exitBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(exitBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			settingsBtn.defaultIcon = new Image(EmbededAssets.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);

			versionLabel = new Label();
			versionLabel.scaleX = versionLabel.scaleY = 0.5;
			versionLabel.text = "v." + Constants.VERSION;
			versionLabel.layoutData = new AnchorLayoutData(NaN, 20, 5, NaN);
			container.addChild(versionLabel);

			// MOCK
			//UIManager.instance.showSettings();
		}


		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_ce.input.hasDone(Constants.PLAY_ACTION)) {
				Controller.instance.startLoadLevel(Controller.instance.currentLevelId);  
			}
		}

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case playBtn: 
					//TODO goto location
					Controller.instance.startLoadLevel(Controller.instance.currentLevelId);   
					break;
				case locationsBtn: 
					Controller.instance.changeState(LocationsState.newInstance);   
					break;
				case settingsBtn: 
					UIManager.instance.showSettings();
					break;
				case helpBtn: 
					UIManager.instance.showAbout();
					break;
				case exitBtn: 
					UIManager.instance.showExitAlert();
					break;
				case profileBtn:
					UIManager.instance.showProfileView();
					//UIManager.instance.showMissionComplete();
					break;


			}
		}   

		/**
		 * Singleton
		 */
		private static var _instance:MenuState;

		public static function get instance():MenuState
		{
			if (_instance == null) _instance = new MenuState();
			return _instance;
		}

		/**
		 * Reinstance for changeState
		 * @return
		 *
		 */
		public static function get newInstance():MenuState
		{
			_instance = new MenuState();
			return _instance;
		}
		/**
		 * Arrange profile button icon
		 */
		public function arrange():void {
			profileBtn.label = "";
			profileBtn.defaultIcon = new Image(ProfileStorage.getProfileTexture());
			profileBtn.defaultIcon.width = 60;
			profileBtn.defaultIcon.height = 60;
		}
	}
}


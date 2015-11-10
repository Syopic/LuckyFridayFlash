package ua.com.syo.luckyfriday.view
{
	import citrus.core.starling.StarlingState;

	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;

	import starling.display.Image;
	import starling.events.Event;

	import ua.com.syo.luckyfriday.LuckyFriday;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Constants;

	public class MenuState extends StarlingState
	{
		public function MenuState()
		{
			super();
		}

		private var playBtn:Button;
		private var helpBtn:Button;
		private var profileBtn:Button;
		private var settingsBtn:Button;
		private var exitBtn:Button;
		private var container:LayoutGroup;

		override public function initialize():void   
		{   
			super.initialize(); 

			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
			initButtons();
		}

		/**
		 * Get the keyboard, and add actions
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
			container.addChild(profileBtn);

			// exit
			exitBtn = new Button();
			exitBtn.width = 75;
			exitBtn.height = 75;
			exitBtn.layoutData = new AnchorLayoutData(NaN, NaN, 20, 20);
			exitBtn.defaultIcon = new Image(Assets.getTexture("PowerIconC"));
			exitBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(exitBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			settingsBtn.defaultIcon = new Image(Assets.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);


			// MOCK
			UIManager.instance.showSettings();
		}


		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_ce.input.hasDone(Constants.PLAY_ACTION)) {
				UIManager.instance.changeState(GameState.newInstance);
			}
		}

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case playBtn: 
					UIManager.instance.changeState(GameState.newInstance);   
					break;
				case settingsBtn: 
					UIManager.instance.showSettings();
					break;
				case helpBtn: 
					UIManager.instance.showAbout();
					break;
				case exitBtn: 

					var alert:Alert = Alert.show( "Do you want to exit?", "Exit to system", new ListCollection(
						[
						{ label: "OK", triggered: alertCloseHandler(event, exitBtn) },
						{ label: "Cancel", triggered: buttonClicked }
						]) );
					alert.addEventListener( Event.CLOSE, alertCloseHandler );
					break;
			}

		}   

		private function alertCloseHandler(event:Event, data:Object):void
		{
			if(data.label == "OK")
			{
				LuckyFriday.exitApplication();
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
	}
}


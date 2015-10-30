package ua.com.syo.luckyfriday.view
{
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksDesktopTheme;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.LuckyFriday;

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

		override public function initialize():void   
		{   
			super.initialize(); 

			initKeyboardActions();

			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
			initButtons();
		}

		/**
		 * Get the keyboard, and add actions
		 */
		private function initButtons():void {

			var container:LayoutGroup = new LayoutGroup();
			container.setSize(stage.stageWidth, stage.stageHeight);
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
			exitBtn.label = "E";
			exitBtn.width = 75;
			exitBtn.height = 75;
			exitBtn.layoutData = new AnchorLayoutData(NaN, NaN, 20, 20);
			container.addChild(exitBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.label = "S";
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			container.addChild(settingsBtn);
		}


		/**
		 * Get the keyboard, and add actions
		 */
		private function initKeyboardActions():void {
			var kb:Keyboard = _ce.input.keyboard;
			kb.addKeyAction("play", Keyboard.P);
		}

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_ce.input.hasDone("play")) {
				LuckyFriday(_ce).changeState(GameState.newInstance);
			}
		}

		private function buttonClicked(event:Event):void   
		{   
			LuckyFriday(_ce).changeState(GameState.newInstance);   
		}   

		private static var _instance:MenuState;

		public static function get instance():MenuState
		{
			if (_instance == null) _instance = new MenuState();
			return _instance;
		}

		public static function get newInstance():MenuState
		{
			_instance = new MenuState();
			return _instance;
		}
	}
}


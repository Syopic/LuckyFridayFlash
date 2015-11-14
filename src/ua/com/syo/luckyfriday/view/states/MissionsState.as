package ua.com.syo.luckyfriday.view.states
{
	import citrus.core.starling.StarlingState;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;

	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.view.UIManager;

	public class MissionsState extends StarlingState
	{

		private var backBtn:Button;
		private var mission1Btn:Button;
		private var container:LayoutGroup;
		private var settingsBtn:Button;

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


			// mission 
			mission1Btn = new Button();
			mission1Btn.label = "MISSION 1";
			mission1Btn.width = 300;
			mission1Btn.height = 100;
			mission1Btn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			mission1Btn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(mission1Btn);

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

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case backBtn: 
					UIManager.instance.changeState(LocationsState.newInstance);   
					break;
				case mission1Btn: 
					UIManager.instance.changeState(GameState.newInstance);   
					break;
				case settingsBtn: 
					UIManager.instance.showSettings();
			}
		}   


		/**
		 * Singleton
		 */
		private static var _instance:MissionsState;

		public static function get instance():MissionsState
		{
			if (_instance == null) _instance = new MissionsState();
			return _instance;
		}

		/**
		 * Reinstance for changeState
		 * @return
		 *
		 */
		public static function get newInstance():MissionsState
		{
			_instance = new MissionsState();
			return _instance;
		}
	}
}


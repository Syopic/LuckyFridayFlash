package ua.com.syo.luckyfriday.view.states
{
	import citrus.core.starling.StarlingState;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.view.UIManager;

	public class MissionsState extends StarlingState
	{

		private var backBtn:Button;
		private var mission1Btn:Button;
		private var mission2Btn:Button;
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
			mission1Btn.width = 250;
			mission1Btn.height = 50;
			mission1Btn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			mission1Btn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(mission1Btn);

			mission2Btn = new Button();
			mission2Btn.label = "MISSION 2";
			mission2Btn.width = 250;
			mission2Btn.height = 50;
			mission2Btn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 70);
			mission2Btn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(mission2Btn);

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
					Controller.instance.changeState(LocationsState.newInstance);   
					break;
				case mission1Btn: 
					Controller.instance.startLevel("1");
					break;
				case mission2Btn: 
					Controller.instance.startLevel("2"); 
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

